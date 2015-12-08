PSQL = "/usr/bin/psql"
username = node[:postgresql][:username]
password = node[:postgresql][:password]

execute "create app role" do
  user "postgres"
  command <<-CMD
  #{PSQL} -c "CREATE USER #{username} WITH PASSWORD '#{password}'"
  CMD
end
