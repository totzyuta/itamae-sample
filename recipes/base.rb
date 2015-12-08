%w(yum_update ruby_build postgresql postgresql-user nginx redis).each do |resource|
  include_recipe "./#{resource}.rb"
end
