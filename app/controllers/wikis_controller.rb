class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    if current_user.present?
      #collaborators = []
      #@wiki.collaborators.each do |collaborator|
        #collaborators << collaborator.email
      #end
      unless (@wiki.private == false) || @wiki.user == current_user || collaborators.include?(current_user.email) || current_user.admin?
        flash[:alert] = "You are not authorized to view this wiki."
        redirect_to new_charge_path
      end
    else
      flash[:alert] = "You are not authorized to view this wiki."
      redirect_to new_user_registration_path
    end
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.user = current_user
    authorize @wiki
    emails = params[:wiki][:add_collaborator].split(',').map(&:strip)
    @wiki.collaborator_users = User.where(email: emails)
    
    if @wiki.save
      flash[:notice] = "Your wiki was saved successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving your wiki. Please try again later."
      render :new
    end
  end

  def update 
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    authorize @wiki
    emails = params[:wiki][:add_collaborator].split(',').map(&:strip)
    @wiki.collaborator_users = User.where(email: emails)

    if @wiki.save && (@wiki.user == current_user || current_user.admin?)
     
      flash[:notice] = "Wiki was updated successfully."
      redirect_to @wiki
    elsif @wiki.save
      flash[:notice] = "Wiki was updated successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end
end