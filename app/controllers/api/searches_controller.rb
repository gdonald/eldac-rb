# frozen_string_literal: true

module Api
  class SearchesController < ApplicationController
    def show
      respond_to do |format|
        format.json { @pages = PageService.new(params).search }
        format.html { redirect_to root_path }
      end
    end
  end
end
