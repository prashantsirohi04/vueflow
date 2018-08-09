class Api::FlowsController < ApplicationController

  def index
  end

  def get_list
    flow_ids = ['null']
    Flow.all.pluck(:id).each do |flow_id|
      flow_ids << flow_id.to_s
    end
    render json: {docs: flow_ids, status:200}
  end

  def create
    flow = Flow.create(data: resource_data)
    render json: {id: flow.id, data: flow.data, status: 200}
  end

  def show
    flow = Flow.find(resource_id)
    render json: {id: flow.id, data: eval(flow.data).to_json, status: 200}
  end

  def update
    flow =  Flow.find(resource_id)
    flow.update_attribute(:data, resource_data)
    render json: {id: flow.id, data: flow.data, status: 200}
  end

  private

  def resource_data
    params.require(:data)
  end

  def resource_id
    params.require(:id)
  end

end
