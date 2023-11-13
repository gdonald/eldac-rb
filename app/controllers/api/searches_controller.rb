# frozen_string_literal: true

module Api
  class SearchesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def show
      respond_to do |format|
        format.json do
          data = RequestDecoderService.new(request).decode
          @pages = PageService.new(data).search
        end
        format.html { redirect_to root_path }
      end
    end
  end
end
