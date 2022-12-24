# frozen_string_literal: true

class SectionsController < ApplicationController
  before_action :require_login
  before_action :page
  before_action only: %i[ask_delete destroy edit update] do
    get_section(params[:id])
  end

  layout 'main'

  def create
    @section = Section.create(section_params.merge(page: @page))
    if @section.persisted?
      redirect_to edit_page_section_path(@page, @section)
      return
    end
    @form = @page.form
    @sections = @page.sections
    render 'pages/edit'
  end

  def edit
    @fields = @section.fields
    @field = Field.new
    @form = @section.page.form
    @field_types = FieldType.all
  end

  def update
    @section.update(section_params)
    if @section.valid?
      redirect_to edit_page_section_path(@page, @section)
      return
    end
    @fields = @section.fields
    @field = Field.new
    @form = @section.page.form
    render 'sections/edit'
  end

  def destroy
    @id = @section.id
    @section.destroy
  end

  def save_sort
    save_sorted(@page.sections)
    head :ok
  end

  private

  def section_params
    params.require(:section).permit(:name)
  end

  def page
    @page = Page.where(id: params[:page_id]).first
    @project = @current_user.projects.where(id: @page.form.project_id).first if @page
    @page = nil unless @project
    redirect_to root_path unless @page
  end
end
