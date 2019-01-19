# frozen_string_literal: true

class SurveysController < ApplicationController
  before_action :require_login
  before_action :get_project, except: [:assign_forms]
  before_action :survey, only: %i[edit update ask_delete destroy]

  layout 'main'

  def create
    @survey = Survey.create(survey_params.merge(project: @project))
    if @survey.persisted?
      redirect_to edit_project_survey_path(@project, @survey)
      return
    end
    render 'projects/edit'
  end

  def update
    @survey.update(survey_params)
    if @survey.valid?
      redirect_to edit_project_survey_path(@project, @survey)
      return
    end
    render 'surveys/edit'
  end

  def destroy
    @id = @survey.id
    @survey.destroy
  end

  def assign_forms
    survey = Survey.find_by(id: forms_params[:survey_id])
    return unless survey

    project = @current_user.projects.where(id: survey.project_id).first
    return unless project

    form_params[:forms].each do |id|
      form = survey.forms.find_by(id: id)
      next unless form

      sf = SurveyForm.find_by(survey: survey, form: form)
      next if sf

      SurveyForm.create(survey: survey, form: form)
    end

    survey.survey_forms.each do |sf|
      sf.destroy unless form_params[:forms].include?(sf.form_id)
    end
  end

  private

  def survey_params
    params.require(:survey).permit(:name, :active)
  end

  def forms_params
    params.require(:survey).permit(forms: [])
  end

  def survey
    @survey = @project.surveys.where(id: params[:id]).first
    redirect_to root_path unless @survey
  end
end
