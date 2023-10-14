# frozen_string_literal: true

class RemoteSearchController < ApplicationController
  def index
    @pages = RemoteSearchService.search(params[:q])
    render layout: nil
  end
end
