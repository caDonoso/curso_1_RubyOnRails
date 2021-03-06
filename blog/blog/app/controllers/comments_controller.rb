class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]
  before_action :set_mountain
  before_action :authenticate_user!

  

  # El editor además de ver y crear comentarios, podrá editar uno.
  before_action :authenticate_editor!, only: [:update]

  # El admin tendrá tambien las funciones del editor, pero especificamente puede destruir también.
  before_action :authenticate_admin!, only: [:destroy]


  # POST /comments
  # POST /comments.json
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.mountain = @mountain

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.mountain, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment.mountain }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment.mountain, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @mountain, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_mountain
      @mountain = Mountain.find(params[:mountain_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :mountain_id, :body)
    end
end
