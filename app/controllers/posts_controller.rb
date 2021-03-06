class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy comment upvote unvote ]
  before_action :denied, only: %i[ edit update destroy ]
  #before_action :set_parent, only: %i[  ]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /posts or /posts.json
  def index
    @posts = Post.roots.order(weight: :DESC).page(params[:page]) # TODO conf page num
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post.root, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post.root }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /posts/1/comment
  def comment
    @post = Post.new(parent_id: @post.id)
  end

  # POST /posts/1/upvote
  def upvote
    @upvote = @post.upvotes.where(user: current_user).first_or_create
    redirect_to @post.root
  end

  # POST /posts/1/upvote
  def unvote
    @upvote = @post.upvotes.where(user: current_user).first
    @upvote.destroy if @upvote
    redirect_to @post.root
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :parent_id)
    end

    def denied
      redirect_to '/'
    end
end
