class FoldersController < ApplicationController

  before_filter :require_login

  layout 'main'

  def update
    @folder = @current_user.folders.where( id: params[:id] ).first
    @folder.update(folder_params) if @folder
  end

  def ask_delete
    @folder = @current_user.folders.where( id: params[:id] ).first
  end

  def edit
    @folder = @current_user.folders.where( id: params[:id] ).first
  end

  def toggle_collapse
    @folder = @current_user.folders.where(:id => params[:id]).first
    @folder.collapsed = !@folder.collapsed
    @folder.save!
    render nothing: true
  end

  def save_sort
    position = 1
    params[:order].split('&').each do |s|
      id = s.split('=')[1].to_i
      folder = @current_user.folders.where(:id => id).first
      if folder
        folder.position = position
        folder.save!
        position += 1
      end
    end
    render nothing: true
  end

  def organize
    session[:organize_folder_id] = params[:folder_id].to_i
    get_projects_list
    if @folder
      render :partial => 'projects_list'
      return
    end
    render nothing: true
    return false
  end

  def destroy
    @folder = @current_user.folders.where(id: params[:id]).first
    if @folder
      @id = @folder.id
      @folder.destroy
    end
  end

  def create
    @folder = Folder.create(folder_params)
    if @folder.valid?
      redirect_to organize_projects_path(show: :edit_folder, id: @folder.id)
      return false
    end
    @projects = @current_user.undeleted_projects
    @folders = @current_user.folders
    render 'projects/organize'
    return false
  end

  private

  def folder_params
    params.permit(:id, :name, :fg, :bg).merge(:user => @current_user)
  end

end