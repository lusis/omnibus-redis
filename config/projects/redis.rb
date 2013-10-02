
name "redis"
maintainer "CHANGE ME"
homepage "CHANGEME.com"

replaces        "redis"
install_path    "/opt/redis"
build_version   "2.6.16"
build_iteration 1

# creates required build directories
dependency "preparation"

# redis dependencies/components
dependency "redis"

# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"
