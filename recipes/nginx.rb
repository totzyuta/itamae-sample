package 'nginx' do
  action :install
end

remote_file "/etc/nginx/nginx.conf" do
  source "../remote_files/nginx.conf"
end

remote_file "/etc/nginx/conf.d/onebox.conf" do
  source "../remote_files/onebox.conf"
end

service 'nginx' do
  action [:enable, :start]
end
