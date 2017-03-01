require 'pathname'
require 'fileutils'
require 'tmpdir'
require 'digest'
require 'timeout'
require 'base64'
require 'mixlib/cli'
require 'mixlib/shellout'
require 'securerandom'
require 'excon'
require 'json'
require 'uri'
require 'ostruct'
require 'time'
require 'i18n'
require 'paint'
require 'inifile'
require 'rugged'
require 'rubygems/package'

require 'net_status'

require 'dapp/version'
require 'dapp/core_ext/hash'
require 'dapp/core_ext/pathname'
require 'dapp/helper/cli'
require 'dapp/helper/trivia'
require 'dapp/helper/sha256'
require 'dapp/helper/net_status'
require 'dapp/prctl'
require 'dapp/error/base'
require 'dapp/error/dimg'
require 'dapp/error/dappfile'
require 'dapp/error/build'
require 'dapp/error/config'
require 'dapp/error/dapp'
require 'dapp/error/shellout'
require 'dapp/error/registry'
require 'dapp/error/rugged'
require 'dapp/error/tar_writer'
require 'dapp/exception/base'
require 'dapp/exception/introspect_image'
require 'dapp/exception/registry'
require 'dapp/lock/error'
require 'dapp/lock/base'
require 'dapp/lock/file'
require 'dapp/cli'
require 'dapp/cli/base'
require 'dapp/cli/build'
require 'dapp/cli/push'
require 'dapp/cli/spush'
require 'dapp/cli/tag'
require 'dapp/cli/list'
require 'dapp/cli/stages'
require 'dapp/cli/stages/flush_local'
require 'dapp/cli/stages/flush_repo'
require 'dapp/cli/stages/cleanup_local'
require 'dapp/cli/stages/cleanup_repo'
require 'dapp/cli/stages/push'
require 'dapp/cli/stages/pull'
require 'dapp/cli/run'
require 'dapp/cli/cleanup'
require 'dapp/cli/bp'
require 'dapp/cli/mrproper'
require 'dapp/cli/stage_image'
require 'dapp/filelock'
require 'dapp/config/base'
require 'dapp/config/directive/base'
require 'dapp/config/dimg/instance_methods'
require 'dapp/config/dimg/validation'
require 'dapp/config/dimg'
require 'dapp/config/artifact_dimg'
require 'dapp/config/dimg_group_base'
require 'dapp/config/dimg_group_main'
require 'dapp/config/dimg_group'
require 'dapp/config/artifact_group'
require 'dapp/config/directive/artifact_base'
require 'dapp/config/directive/git_artifact_local'
require 'dapp/config/directive/git_artifact_remote'
require 'dapp/config/directive/artifact'
require 'dapp/config/directive/chef'
require 'dapp/config/directive/shell/dimg'
require 'dapp/config/directive/shell/artifact'
require 'dapp/config/directive/docker/base'
require 'dapp/config/directive/docker/dimg'
require 'dapp/config/directive/docker/artifact'
require 'dapp/config/directive/mount'
require 'dapp/dapp/lock'
require 'dapp/dapp/ssh_agent'
require 'dapp/dapp/git_artifact'
require 'dapp/dapp/dappfile'
require 'dapp/dapp/chef'
require 'dapp/dapp/command/common'
require 'dapp/dapp/command/build'
require 'dapp/dapp/command/bp'
require 'dapp/dapp/command/cleanup'
require 'dapp/dapp/command/mrproper'
require 'dapp/dapp/command/stage_image'
require 'dapp/dapp/command/list'
require 'dapp/dapp/command/push'
require 'dapp/dapp/command/run'
require 'dapp/dapp/command/spush'
require 'dapp/dapp/command/tag'
require 'dapp/dapp/command/stages/common'
require 'dapp/dapp/command/stages/cleanup_local'
require 'dapp/dapp/command/stages/cleanup_repo'
require 'dapp/dapp/command/stages/flush_local'
require 'dapp/dapp/command/stages/flush_repo'
require 'dapp/dapp/command/stages/push'
require 'dapp/dapp/command/stages/pull'
require 'dapp/dapp/logging/base'
require 'dapp/dapp/logging/process'
require 'dapp/dapp/logging/paint'
require 'dapp/dapp/logging/i18n'
require 'dapp/dapp/deps/base'
require 'dapp/dapp/deps/gitartifact'
require 'dapp/dapp/shellout/streaming'
require 'dapp/dapp/shellout/base'
require 'dapp/dapp'
require 'dapp/docker_registry'
require 'dapp/docker_registry/mod/request'
require 'dapp/docker_registry/mod/authorization'
require 'dapp/docker_registry/base'
require 'dapp/docker_registry/default'
require 'dapp/dimg/mod/git_artifact'
require 'dapp/dimg/mod/path'
require 'dapp/dimg/mod/tags'
require 'dapp/dimg/mod/stages'
require 'dapp/dimg/builder/base'
require 'dapp/dimg/builder/chef'
require 'dapp/dimg/builder/chef/error'
require 'dapp/dimg/builder/chef/cookbook_metadata'
require 'dapp/dimg/builder/chef/berksfile'
require 'dapp/dimg/builder/chef/cookbook'
require 'dapp/dimg/builder/shell'
require 'dapp/dimg/builder/none'
require 'dapp/dimg/build/stage/mod/logging'
require 'dapp/dimg/build/stage/mod/group'
require 'dapp/dimg/build/stage/base'
require 'dapp/dimg/build/stage/ga_base'
require 'dapp/dimg/build/stage/ga_dependencies_base'
require 'dapp/dimg/build/stage/artifact_base'
require 'dapp/dimg/build/stage/artifact_default'
require 'dapp/dimg/build/stage/from'
require 'dapp/dimg/build/stage/import_artifact'
require 'dapp/dimg/build/stage/before_install'
require 'dapp/dimg/build/stage/before_install_artifact'
require 'dapp/dimg/build/stage/ga_archive_dependencies'
require 'dapp/dimg/build/stage/ga_archive'
require 'dapp/dimg/build/stage/install/ga_pre_install_patch_dependencies'
require 'dapp/dimg/build/stage/install/ga_pre_install_patch'
require 'dapp/dimg/build/stage/install/install'
require 'dapp/dimg/build/stage/install/ga_post_install_patch_dependencies'
require 'dapp/dimg/build/stage/install/ga_post_install_patch'
require 'dapp/dimg/build/stage/after_install_artifact'
require 'dapp/dimg/build/stage/before_setup'
require 'dapp/dimg/build/stage/before_setup_artifact'
require 'dapp/dimg/build/stage/setup/ga_pre_setup_patch_dependencies'
require 'dapp/dimg/build/stage/setup/ga_pre_setup_patch'
require 'dapp/dimg/build/stage/setup/setup'
require 'dapp/dimg/build/stage/setup/ga_post_setup_patch_dependencies'
require 'dapp/dimg/build/stage/setup/ga_post_setup_patch'
require 'dapp/dimg/build/stage/after_setup_artifact'
require 'dapp/dimg/build/stage/ga_latest_patch'
require 'dapp/dimg/build/stage/docker_instructions'
require 'dapp/dimg/build/stage/ga_artifact_patch'
require 'dapp/dimg/build/stage/build_artifact'
require 'dapp/dimg/git_artifact'
require 'dapp/dimg/dimg'
require 'dapp/dimg/artifact'
require 'dapp/image/argument'
require 'dapp/image/docker'
require 'dapp/image/stage'
require 'dapp/image/scratch'
require 'dapp/git_repo/base'
require 'dapp/git_repo/own'
require 'dapp/git_repo/remote'

# Dapp
module Dapp
  def self.root
    File.expand_path('../..', __FILE__)
  end
end
