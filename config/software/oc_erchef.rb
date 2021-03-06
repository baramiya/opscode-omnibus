name "oc_erchef"
default_version "0.27.7"

dependency "erlang"
dependency "rebar"
dependency "rsync"
dependency "gecode"

# RUBY DEPSOLVER - REMOVE FOR ROLLBACK #
dependency "ruby"
dependency "bundler"
# END RUBY DEPSOLVER #

source :git => "git@github.com:opscode/oc_erchef"

relative_path "oc_erchef"

env = {
  "PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}",
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command "make distclean", :env => env
  command "make rel", :env => env
  command "mkdir -p #{install_dir}/embedded/service/opscode-erchef"
  command "#{install_dir}/embedded/bin/rsync -a --delete --exclude=.git/*** --exclude=.gitignore ./rel/oc_erchef/ #{install_dir}/embedded/service/opscode-erchef/"
  # TODO: git cleanup in opscode-erchef service directory
  command "rm -rf #{install_dir}/embedded/service/opscode-erchef/log"
end
