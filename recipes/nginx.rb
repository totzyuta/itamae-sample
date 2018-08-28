package 'nginx' do
  action :install
end

remote_file "/etc/nginx/nginx.conf" do
  source "../remote_files/nginx.conf"
end

remote_file "/etc/nginx/conf.d/virtual.conf" do
  source "../remote_files/app.conf"
end

service 'nginx' do
  action [:enable, :start]
end
