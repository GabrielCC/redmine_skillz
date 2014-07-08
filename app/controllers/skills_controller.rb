class SkillsController < ApplicationController
  
  # GET /skills/show
  # GET /skills/show.json
  def show
    @user_skills = User.current.user_skills
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_skills }
    end
  end


end
