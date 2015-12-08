%w{postgresql-server}.each do |pkg|
  package pkg do
    action :install
  end
end

version = node[:postgresql][:version]
short_version = node[:postgresql][:short_version]

package node[:postgresql][:rpm_package] do
  p node[:postgresql]
  p node[:postgresql][:rpm_package]
  not_if "rpm -q #{File.basename(node[:postgresql][:rpm_package], ".rpm")}"
end

package "postgresql#{short_version}"
package "postgresql#{short_version}-server"
package "postgresql#{short_version}-contrib"
package "postgresql#{short_version}-devel"
package "postgresql#{short_version}-libs"

execute "initdb" do
  command "PGSETUP_INITDB_OPTIONS='--encoding UTF8 --no-locale' initdb -D /var/lib/pgsql/#{version}/data"
  not_if "test -e /var/lib/pgsql/#{version}/data/postgresql.conf"
end

%w(pg_hba.conf postgresql.conf).each do |file|
  remote_file "/var/lib/pgsql/#{version}/data/#{file}" do
    source "../remote_files/#{file}"
    owner "postgres"
    group "postgres"
    mode "0600"
  end
end

[:enable, :restart].each do |act|
  service "postgresql-#{version}" do
    action act
  end
end

# Firewall
# execute "firewall port open" do
#   command "firewall -cmd --add-port=5432/tcp --zone=public --permanent"
#   not_if "grep -c 5432 /etc/firewalld/zones/public.xml"
# end
#
# execute "Firewall reload" do
#   command "firewall-cmd --reload"
# end
