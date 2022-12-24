# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :require_login
  before_action :form
  before_action :page, only: %i[ask_delete destroy edit update]

  layout 'main'

  def create
    @page = Page.create(page_params.merge(form: @form))
    if @page.persisted?
      redirect_to edit_form_page_path(@form, @page)
      return
    end
    @pages = @form.pages
    render 'forms/edit'
  end

  def edit
    @sections = @page.sections
    @section = Section.new
  end

  def update
    @page.update(page_params)
    if @page.valid?
      redirect_to edit_form_page_path(@form, @page)
      return
    end
    @sections = @page.sections
    @section = Section.new
    render 'pages/edit'
  end

  def destroy
    @id = @page.id
    @page.destroy
  end

  def save_sort
    save_sorted(@form.pages)
    head :ok
  end

  private

  def page_params
    params.require(:page).permit(:name)
  end

  def form
    @form = Form.where(id: params[:form_id]).first
    @project = @current_user.projects.where(id: @form.project_id).first if @form
    @form = nil unless @project
    redirect_to root_path unless @form
  end

  def page
    @page = @form.pages.where(id: params[:id]).first
    @project = @current_user.projects.where(id: @page.form.project_id).first if @page
    @page = nil unless @project
    redirect_to root_path unless @page
  end
end
