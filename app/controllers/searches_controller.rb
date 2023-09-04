# frozen_string_literal: true

class SearchesController < ApplicationController
  def show
    @pages = if params[:q].present?
               Page.by_term(params[:q])
             else
               Page.none
             end
  end
end
