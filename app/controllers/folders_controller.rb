# frozen_string_literal: true

# Allows documents to be viewed and added.
class FoldersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_editor!, only: [
    :new, :create, :edit, :update, :destroy, :attach_file, :attach_files,
    :upload
  ]
  before_action :create_category, only: [:create, :update]
  before_action :find_category_and_folder_or_redirect, only: [
    :show, :edit, :upload
  ]
  before_action :find_folder_or_redirect, only: [
    :update, :destroy, :attach_file, :attach_files
  ]

  layout "layouts/full_page_sidebar"

  # GET /docs
  def index
    # @folders = Folder.all
  end

  # # GET /docs/:category/:folder
  # def show
  # end

  # GET /docs/new
  def new
    @folder = Folder.new
  end

  # # GET /docs/:category/:folder/edit
  # def edit
  # end

  # POST /docs
  def create
    @folder = @category.folders.new(folder_params)
    if @folder.save
      redirect_to category_folder_path(@folder.category, @folder), notice: "Folder was successfully created."
    else
      render :new
    end
  end

  # PATCH /folders/1
  def update
    if @folder.update(folder_params)
      redirect_to category_folder_path(@folder.category, @folder), notice: "Folder was successfully updated."
    else
      render :edit
    end
  end

  # # GET /docs/:category/:folder/upload
  # def upload
  # end

  # POST /folders/1/attach-file
  def attach_file
    if params[:file].present?
      @folder.files.attach(params[:file])
      redirect_to category_folder_path(@folder.category, @folder)
    else
      redirect_to upload_category_folder_path(@folder.category, @folder), notice: "Choose a file to upload."
    end
  end

  # POST /folders/1/attach-files
  def attach_files
    @folder.files.attach(params[:files])
    render :show
  end

  # DELETE /folders/1
  def destroy
    @folder.destroy
    redirect_to folders_path, notice: "Folder was successfully deleted."
  end

  private

  def find_category_and_folder_or_redirect
    @category = Category.find_by_param(params[:category])
    empty_response_or_root_path(folders_path) unless @category
    @folder = @category.folders.with_attached_files.find_by_param(params[:folder])
    empty_response_or_root_path(folders_path) unless @folder
  end

  def find_folder_or_redirect
    @folder = Folder.with_attached_files.find_by_param(params[:id])
    empty_response_or_root_path(folders_path) unless @folder
  end

  def create_category
    @category = Category.where(name: params[:folder][:category]).first_or_create
    @category.update(slug: @category.name.parameterize) if @category.persisted? && @category.slug.blank?
    params[:folder][:category_id] = @category.id
  end

  def folder_params
    params.require(:folder).permit(
      :category_id, :name, :slug, :description, :archived
    )
  end
end
