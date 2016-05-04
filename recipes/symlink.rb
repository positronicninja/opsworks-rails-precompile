node[:deploy].each do |application, deploy|
  release_path = deploy[:release_path]
  shared_path = deploy[:deploy_to] + '/shared'

  # create shared directory for assets, if it doesn't exist
  directory "#{shared_path}/public/assets" do
    mode 0770
    action :create
    recursive true
  end

  Chef::Log.info("Symlinking #{release_path}/public/assets to #{shared_path}/shared/assets")

  # symlink current deploy's asset folder to shared assets each deploy
  link "#{release_path}/public/assets" do
    to "#{shared_path}/public/assets"
  end
end
