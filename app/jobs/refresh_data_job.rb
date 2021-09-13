class RefreshDataJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Airtable::DataService.new.refresh_data
  end
end
