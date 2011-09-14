class PostsController < ApplicationController
  
   respond_to :html, :json, :amf
   
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    respond_with(@posts) do |format|
      format.amf { render  amf: @posts.to_amf(:include => [:comments]) }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    respond_with(@post) do |format|
      format.amf { render amf: @post.to_amf(:include => [:comments]) }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    respond_with(@post = Post.new)
  end

  # GET /posts/1/edit
  def edit
    respond_with(@post = Post.find(params[:id]))
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.create(params[:post])
    respond_with(@post)  # assuming no comments need to be returned
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])
    respond_with(@post) do |format|
      format.amf { render amf: @post.to_amf(:include => [:comments]) }
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_with(@post)
  end
end
