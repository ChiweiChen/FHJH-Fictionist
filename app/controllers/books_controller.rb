class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :dashboard, :subscribe, :unsubscribe]
  #When showing the page, the page runs the function set_book before Show, creating @book for use in View

  # GET /books
  # GET /books.json
  def index
    puts params[:category]
    #prints out category parameters
    category_id=params[:category]
  
    if category_id == nil
    #use nil when you don't receive any parameters; don't use "", even an empty string is considered data
      @books = Book.all.includes(:users, :categories)
      #finds users and categories from other tables in advance
    else
      @books = Category.find(category_id).books.includes(:users, :categories)
      
    end
    # @books = Book.where(category: ...)
    
    @category_name= Category.find_by(id:category_id).try(:show) || "全部"
    # find_by; similar to find; [Model].find_by(column:[value]); returns first result
    # same as Category.where(name:category)[0]
    # try(:column); try executing something; if there are no results, return nil
    # || "or" operator; ex. a || b; chose the variable which is not nil
  end

  def dashboard
    
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end
  
  # GET /books/new
  def new
    @book = Book.new
    @categories= Category.all
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    respond_to do |format|
      if @book.save
        @book.update(category_ids: params[:book][:category_ids])
        chapter = Chapter.create(title: 'Chapter 1', content: 'Chapter 1 Content', book_id: @book.id, is_first: true)
        chapter.update(user_ids: current_user.id)
        #@book.update([column_name]: [value])
        #category_ids does not belong to any table, it belongs to the model Book
        #the :book in params is a key for book_name, book_summary, and category_ids
        #updates relationship between this book and corresponding categories
        #adds new row in books_categories table
        #the variable category_ids is generated by |has_and_belongs_to_many :categories| in book.rb and |has_and_belongs_to_many :books| in category
        format.html { redirect_to '/user', notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        @book.update(category_ids: params[:book][:category_ids])
        format.html { redirect_to "/books/#{@book.id}/dashboard", notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def subscribe
    subscribers=@book.users.pluck("id")
    subscribers.push(current_user.id)
    @book.update(user_ids: subscribers)
    render json: true
  end

  def unsubscribe
    subscribers=@book.users.pluck("id")
    subscribers.delete(current_user.id)
    @book.update(user_ids: subscribers)
    render json: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
      #Adding "@" allows a variable to be used in View
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:book_name, :summary, :cover)
      #category_ids is not included in permit because it does weird stuff and it's only used to create relationships
    end
end
