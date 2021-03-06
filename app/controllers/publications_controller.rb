# encoding: utf-8

require 'pdf/info'

class PublicationsController < ApplicationController
  
  #check authentication via devise
  before_filter :authenticate_user!, :except => [:show, :index, :bibtex, :abstract]
  
  # caches the index action, until some create or delete method is triggered
  #caches_action :index, :layout => false
  
  # GET /publications
  # GET /publications.json
  def index
    @publications = Publication.order(:year)
    
    respond_to do |format|
      format.html
      format.json { render json: @publications.tokens(params[:q]) }
    end
    
  end

  # GET /publications/1
  # GET /publications/1.json
  def show
    @publication = Publication.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @publication }
    end
  end

  # GET /publications/new
  # GET /publications/new.json
  def new
    @publication = Publication.new
    @publication.url ||= 'http://www.'
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @publication }
    end
  end

  # GET /publications/1/edit
  def edit
    @publication = Publication.find(params[:id])
    @publication.url ||= 'http://www.'
  end
  
  # POST /publications
  # POST /publications.json
  
  # here are some extensions
  # save should not be triggered, if pdf metadata have been read
  def create
    @publication = Publication.new(params[:publication])
    flash[:pdf_notice] = nil
    read_pdf = params[:pdf_button] && @publication.upload != nil && @publication.title.empty?
    msg = ""
    if read_pdf
      @publication.set_rdy_to_save false
      md_exists = @publication.extract_metadata
      flash[:pdf_notice] = get_msg md_exists
    else
      @publication.set_rdy_to_save true
      #expire_action :action => :index
    end
    
    respond_to do |format|
      if read_pdf
        format.html { render action: "new" }
        format.json { render json: @publication }
      elsif @publication.save
          format.html { redirect_to @publication, notice: 'Publication was successfully created.' }
          format.json { render json: @publication, status: :created, location: @publication }
      else
          format.html { render action: "new" }
          format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /publications/1
  # PUT /publications/1.json
  def update
    @publication = Publication.find(params[:id])
    #expire_action :action => :index
    respond_to do |format|
      if @publication.update_attributes(params[:publication])
        format.html { redirect_to @publication, notice: 'Publication was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publications/1
  # DELETE /publications/1.json
  def destroy
    @publication = Publication.find(params[:id])
    @publication.destroy
    #expire_action :action => :index
    respond_to do |format|
      format.html { redirect_to publications_url }
      format.json { head :no_content }
    end
  end
  
  def bibtex
      @publication = Publication.find(params[:publication_id])
      
      respond_to do |format|
        format.js
      end
  end
  
  def abstract
      @publication = Publication.find(params[:publication_id])
      
      respond_to do |format|
        format.js
      end
  end
  
  # just forms the flash message
  
  private 
  def get_msg extraction_hash
    (extraction_hash["authors"].empty?)? ((extraction_hash["title"])? "PDF was successfully read" : "PDF has no metadata") : "Author(s) not found: " + extraction_hash[:authors]
  end
end
