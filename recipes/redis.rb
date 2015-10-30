package "redis" do
  options "--enablerepo=epel"
  action :install
end

service "redis" do
  action %i(enable start)
end
