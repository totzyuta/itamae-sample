%w(yum_update ruby_build postgresql nginx redis).each do |resource|
  include_recipe "./#{resource}.rb"
end
