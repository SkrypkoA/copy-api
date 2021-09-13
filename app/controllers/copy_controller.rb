class CopyController < ApplicationController
  before_action :read_data

  def index
    if params[:since].present?
      @data = @data.select{ |record| record["fields"]["Last Modified"].to_time.to_i > params[:since].to_i }
    end

    render json: @data
  end

  def show
    record = @data.find { |record| record["fields"]["Key"] == params[:id] }

    return render json: { error: "Not found" }.to_json, status: 404 if record.blank?

    @record = Record.new(key: record["fields"]["Key"], copy: record["fields"]["Copy"])
    render json: { value: @record.value(params) }
  end

  def refresh
    RefreshDataJob.perform_now
    render json: :ok
  end

  private

  def read_data
    @data = JSON.parse(File.read("public/copy.json"))["records"]
  end
end
