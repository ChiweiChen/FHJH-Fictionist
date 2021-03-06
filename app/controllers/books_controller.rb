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
      @books = Book.all.includes(:users, :categories).paginate(page: params[:page])
      #finds users and categories from other tables in advance
    else
      @books = Category.find(category_id).books.includes(:users, :categories).paginate(page: params[:page])
      
    end
    # @books = Book.where(category: ...)
    
    @category_name= Category.find_by(id:category_id).try(:show) || "全部"
    # find_by; similar to find; [Model].find_by(column:[value]); returns first result
    # same as Category.where(name:category)[0]
    # try(:column); try executing something; if there are no results, return nil
    # || "or" operator; ex. a || b; chose the variable which is not nil
    @all_book_ids=Book.all.ids
    @all_book_ids=@all_book_ids.rotate(Date.today.yday+9)
    @recs=[]
    i=1
    if Book.all.size<9
        for i in 0..Book.all.size-1
            @recs.push(Book.find(@all_book_ids[i]))
        end
    else 
        for i in 0..8
            @recs.push(Book.find(@all_book_ids[i]))
        end
    end
  end

  def dashboard
    if current_user == nil
      redirect_to "/books/#{@book.id}/"
    else
      if User.where(name: @book.get_author)[0].id != current_user.id && current_user.admin? !=true
        redirect_to "/books/#{@book.id}/"
      end
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    add = Random.new.rand(1..3)
    temp= @book.views += add
    @book.update_attribute "views", temp
    @comments = []
    @book.chapters.each do |chapter|
      chapter.get_comments.each do |comment|
        @comments.push(comment)
      end
    end
  end
  
  # GET /books/new
  def new
    @book = Book.new
    @categories= Category.all
  end

  # GET /books/1/edit
  def edit
    if current_user == nil
      redirect_to "/books/#{@book.id}"
    elsif current_user.id != User.where(name: @book.get_author)[0].id
      if current_user.admin!=true
        if current_user.artist=="not"
          redirect_to "/books/#{@book.id}"
        end
      end
    end
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    respond_to do |format|
      if @book.save
        @book.update(category_ids: params[:book][:category_ids])
        
        chapter = Chapter.create(title: '新章節', content: '目前尚無內容', book_id: @book.id, is_first: true)
        chapter.update(user_ids: current_user.id)
        @stopword.each do |word|
          @book.update(summary: @book.summary.gsub(word,""))
          @book.update(book_name: @book.book_name.gsub(word,""))
        end
        @stopwords.each do |word|
          @book.update(summary: @book.summary.gsub(word,"*"))
          @book.update(book_name: @book.book_name.gsub(word,"*"))
        end
        
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
        @stopwords.each do |word|
          @book.update(summary: @book.summary.gsub(word,"*"))
          @book.update(book_name: @book.book_name.gsub(word,"*"))
        end
        @stopword.each do |word|
          @book.update(summary: @book.summary.gsub(word,""))
          @book.update(book_name: @book.book_name.gsub(word,""))
        end
        format.html { redirect_to "/books/#{@book.id}/dashboard", notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def search
      if params[:search].blank?
        redirect_to(root_path, alert: "Empty field!") and return
      else
        @parameter = params[:search].downcase  
        @books = Book.all.where("lower(book_name) LIKE :search", search: "%#{@parameter}%")
        @authors=[]
        @authors= User.all.where("lower(name) LIKE :search", search: "%#{@parameter}%")
        @authors_books=[]
        @authors.each do |author|
          chapters= author.chapters.where(is_first: true)
          chapters.each do |chapter|
            
            @authors_books.push(chapter.book)
          end
        end
        
        
      end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to '/admin', notice: 'Book was successfully destroyed.' }
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
      params.require(:book).permit(:book_name, :summary, :cover, :search)
      #category_ids is not included in permit because it does weird stuff and it's only used to create relationships
    end
end
