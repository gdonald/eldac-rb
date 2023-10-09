# frozen_string_literal: true

class SearchesController < ApplicationController
  def show
    @pages = PageService.new(params).search
  end

  def autocomplete
    respond_to do |format|
      format.json do
        render json: PhraseService.new(params).search
      end
      format.html { redirect_to root_path }
    end
  end
end
