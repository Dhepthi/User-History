class BookmarksController < ApplicationController
  # GET /bookmarks
  # GET /bookmarks.json
  before_filter :authenticate_user!, :except => [:show]
  def index
    @bookmarks = Bookmark.all
    @tags = Bookmark.select("DISTINCT(tags)")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bookmarks }
    end
  end

  def get_list
    if params[:curr_usr] == "true"
      @urls = current_user.bookmarks.all(:select => "url,tags", :conditions => ["tags like ?", params[:tag_value]])
    else
      @urls = Bookmark.all(:select => "url,tags", :conditions => ["tags like ?", params[:tag_value]] )
    end
    
    render :json => {:msg => "Search Complete", :data => @urls }
  end
  # GET /bookmarks/1
  # GET /bookmarks/1.json
  def show
    @bookmark = Bookmark.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bookmark }
    end
  end

  # GET /bookmarks/new
  # GET /bookmarks/new.json
  def new
    @bookmark = Bookmark.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bookmark }
    end
  end

  # GET /bookmarks/1/edit
  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  # POST /bookmarks
  # POST /bookmarks.json
  def create
    @bookmark = current_user.bookmarks.build(params[:bookmark])

    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to bookmarks_url, notice: 'Bookmark was successfully created.' }
        format.json { render json: @bookmark, status: :created, location: @bookmark }
      else
        format.html { render action: "new" }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bookmarks/1
  # PUT /bookmarks/1.json
  def update
    @bookmark = Bookmark.find(params[:id])

    respond_to do |format|
      if @bookmark.update_attributes(params[:bookmark])
        format.html { redirect_to @bookmark, notice: 'Bookmark was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.json
  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy

    respond_to do |format|
      format.html { redirect_to bookmarks_url }
      format.json { head :ok }
    end
  end
end
