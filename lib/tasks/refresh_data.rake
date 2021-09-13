task :refresh_data => :environment do
  RefreshDataJob.perform_now
end
