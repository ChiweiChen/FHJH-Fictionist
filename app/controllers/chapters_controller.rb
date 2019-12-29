class ChaptersController < ApplicationController
  before_action :set_chapter, only: [:show, :edit, :update, :destroy, :upload, :unsend]
  protect_from_forgery except: :upload

  # GET /chapters
  # GET /chapters.json
  def index
    @chapters = Chapter.all
  end

  # GET /chapters/1
  # GET /chapters/1.json
  def show
    #Get the book this chapter belongs to
    @which_chapter=0
    @chapter.book.chapters.each_with_index do |chapter, count|
    #_with_index increments second variable
    #ex. |v1, v2| increments v2
      if (@chapter.id==chapter.id)
        @which_chapter=count + 1
      end
    end
    #For each chapter, check whether or not it is the same one as the one being displayed on the page
  end

  # GET /chapters/new
  def new
    @chapter = Chapter.new
    @book = Book.find(params[:book_id])
  end

  # GET /chapters/1/edit
  def edit
    @book = Book.find(params[:book_id])
  end

  # POST /chapters
  # POST /chapters.json
  def create
    @chapter = Chapter.new(chapter_params)
    @book = Book.find(params[:chapter][:book_id])
    respond_to do |format|
      if @chapter.save
        @chapter.update(user_ids: current_user.id)
        format.html { redirect_to "/books/#{@book.id}/dashboard", notice: 'Chapter was successfully created.' }
        format.json { render :show, status: :created, location: @chapter }
      else
        format.html { render :new }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chapters/1
  # PATCH/PUT /chapters/1.json
  def update
    respond_to do |format|
      if @chapter.update(chapter_params)
        format.html { redirect_to @chapter, notice: 'Chapter was successfully updated.' }
        format.json { render :show, status: :ok, location: @chapter }
      else
        format.html { render :edit }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chapters/1
  # DELETE /chapters/1.json
  def destroy
    @chapter.destroy
    respond_to do |format|
      format.html { redirect_to chapters_url, notice: 'Chapter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upload
    @chapter.update(upload: Time.now)
    render json: true
  end

  def unsend
    @chapter.update(upload: nil)
    render json: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chapter
      @chapter = Chapter.find(params[:id])
      #Parameters for book_id and chapter_id are found from URL
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chapter_params
      params.require(:chapter).permit(:title, :content, :book_id)
    end
end
