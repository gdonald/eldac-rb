# frozen_string_literal: true

class HomeController < ApplicationController
  layout 'home'

  def index; end

  def examples
    respond_to do |format|
      format.html { render layout: 'examples' }
    end
  end
end
