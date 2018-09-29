package "epel-release"
package "gcc"
package "openssl-devel"
package "libyaml-devel"
package "readline-devel"
package "zlib-devel"
package "git"
package "gcc-c++"

USER_NAME = "ec2-user"
HOME_DIR = "/home/#{USER_NAME}"
RBENV_DIR = "#{HOME_DIR}/.rbenv"
RBENV_SCRIPT = "/etc/profile.d/rbenv.sh"

git RBENV_DIR do
  repository "git://github.com/sstephenson/rbenv.git"
end

execute "change permission for rbenv dir" do
  command "sudo chown -R #{USER_NAME} #{RBENV_DIR}"
  cwd HOME_DIR
end

execute "sudo mkdir #{RBENV_DIR}/plugins" do
  not_if "test -d #{RBENV_DIR}/plugins"
end
execute "sudo mkdir #{RBENV_DIR}/shims" do
  not_if "test -d #{RBENV_DIR}/shims"
end
execute "sudo mkdir #{RBENV_DIR}/versions" do
  not_if "test -d #{RBENV_DIR}/versions"
end

remote_file RBENV_SCRIPT do
  source "../remote_files/rbenv.sh"
end

git "#{RBENV_DIR}/plugins/ruby-build" do
  repository "git://github.com/sstephenson/ruby-build.git"
end

node["rbenv"]["versions"].each do |version|
  execute "install ruby #{version}" do
    command "source #{RBENV_SCRIPT}; rbenv install #{version}"
    not_if "source #{RBENV_SCRIPT}; rbenv versions | grep #{version}"
  end
end

execute "set global ruby #{node["rbenv"]["global"]}" do
  command "source #{RBENV_SCRIPT}; rbenv global #{node["rbenv"]["global"]}; rbenv rehash"
  not_if "source #{RBENV_SCRIPT}; rbenv global | grep #{node["rbenv"]["global"]}"
end

node["rbenv"]["gems"].each do |gem|
  execute "gem install #{gem}" do
    command "source #{RBENV_SCRIPT}; gem install #{gem}; rbenv rehash"
    not_if "source #{RBENV_SCRIPT}; gem list | grep #{gem}"
  end
end
