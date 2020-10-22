class PostSummariesController < ApplicationController
  before_action :set_post_summary, only: [:show, :edit, :update, :destroy]

  # GET /post_summaries
  # GET /post_summaries.json
  def index
    post_summary = PostSummary.where(post_id: params[:post_id])&.first
    @post_summary = post_summary ? post_summary : {} 
  end

  # GET /post_summaries/1
  # GET /post_summaries/1.json
  def show
  end

  # GET /post_summaries/new
  def new
    @post_summary = PostSummary.new
  end

  # GET /post_summaries/1/edit
  def edit
  end

  # POST /post_summaries
  # POST /post_summaries.json
  def create
    @post_summary = PostSummary.new(post_summary_params)

    respond_to do |format|
      if @post_summary.save
        format.html { redirect_to @post_summary, notice: 'Post summary was successfully created.' }
        format.json { render :show, status: :created, location: @post_summary }
      else
        format.html { render :new }
        format.json { render json: @post_summary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /post_summaries/1
  # PATCH/PUT /post_summaries/1.json
  def update
    respond_to do |format|
      if @post_summary.update(post_summary_params)
        format.html { redirect_to @post_summary, notice: 'Post summary was successfully updated.' }
        format.json { render :show, status: :ok, location: @post_summary }
      else
        format.html { render :edit }
        format.json { render json: @post_summary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_summaries/1
  # DELETE /post_summaries/1.json
  def destroy
    @post_summary.destroy
    respond_to do |format|
      format.html { redirect_to post_summaries_url, notice: 'Post summary was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_summary
      @post_summary = PostSummary.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_summary_params
      params.require(:post_summary).permit(:up_votes, :down_votes)
    end
end
