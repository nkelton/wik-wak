class CommentSummariesController < ApplicationController
  before_action :set_comment_summary, only: [:show, :edit, :update, :destroy]

  # GET /comment_summaries
  # GET /comment_summaries.json
  def index
    @comment_summaries = CommentSummary.all
  end

  # GET /comment_summaries/1
  # GET /comment_summaries/1.json
  def show
  end

  # GET /comment_summaries/new
  def new
    @comment_summary = CommentSummary.new
  end

  # GET /comment_summaries/1/edit
  def edit
  end

  # POST /comment_summaries
  # POST /comment_summaries.json
  def create
    @comment_summary = CommentSummary.new(comment_summary_params)

    respond_to do |format|
      if @comment_summary.save
        format.html { redirect_to @comment_summary, notice: 'Comment summary was successfully created.' }
        format.json { render :show, status: :created, location: @comment_summary }
      else
        format.html { render :new }
        format.json { render json: @comment_summary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comment_summaries/1
  # PATCH/PUT /comment_summaries/1.json
  def update
    respond_to do |format|
      if @comment_summary.update(comment_summary_params)
        format.html { redirect_to @comment_summary, notice: 'Comment summary was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment_summary }
      else
        format.html { render :edit }
        format.json { render json: @comment_summary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comment_summaries/1
  # DELETE /comment_summaries/1.json
  def destroy
    @comment_summary.destroy
    respond_to do |format|
      format.html { redirect_to comment_summaries_url, notice: 'Comment summary was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment_summary
      @comment_summary = CommentSummary.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_summary_params
      params.require(:comment_summary).permit(:up_votes, :down_votes)
    end
end
