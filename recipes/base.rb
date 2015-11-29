%w(yum_update ruby_build mysql_for65 nginx redis).each do |resource|
  include_recipe "./#{resource}.rb"
end
