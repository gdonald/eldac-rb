# frozen_string_literal: true

class RemoteSearchController < ApplicationController
  def index
    @pages = RemoteSearchService.new(params[:q]).search
    render layout: nil
  end
end
