#
# Copyright:: Copyright (c) 2012 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "redis"
version "2.6.16"

dependency "rsync"

source :url => "http://download.redis.io/releases/redis-2.6.16.tar.gz",
       :md5 => "ca1b81bd56fe0c5e2c8ec443a95c908d"

relative_path "redis-2.6.16"

make_args = ["PREFIX=#{install_dir}/embedded",
             "CFLAGS='-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include'",
             "LD_RUN_PATH=#{install_dir}/embedded/lib"].join(" ")

build do
  command ["make -j #{max_build_jobs}", make_args].join(" ")
  command ["make install", make_args].join(" ")
  %w{redis-benchmark redis-check-aof redis-check-dump redis-cli redis-sentinel redis-server}.each do |bin|
    command "cp src/#{bin} #{install_dir}/bin/"
  end
  command "mkdir #{install_dir}/etc"
  %w{redis.conf sentinel.conf}.each do |config|
    command "cp #{config} #{install_dir}/etc/#{config}.dist"
  end
end
