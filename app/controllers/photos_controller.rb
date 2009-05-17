class PhotosController < ApplicationController
  layout "layout"
  # GET /photos
  # GET /photos.xml
  def index
    @album = Album.find(params[:album_id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.xml
  def show
    @album = Album.find(params[:album_id])
    @photos = @album.photos.all
    @photo = @photos.detect{|r| r.id==params[:id].to_i}


    @prev_photo = @photos.last
    @prev_photo = @photos[@photos.index(@photo)-1] unless @photos.index(@photo) -1 ==@photos.size
    
    @next_photo = @photos.first
    @next_photo = @photos[@photos.index(@photo)+1] unless @photos.index(@photo) +1 ==@photos.size
  
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.xml
  def new
    @album = Album.find(params[:album_id])
    @photo = @album.photos.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @album = Album.find(params[:album_id])
    @photo = Photo.find(params[:id])
  end

  # POST /photos
  # POST /photos.xml
  def create
    @album = Album.find(params[:album_id])
    @album.photos.create(params[:photo])
    

    respond_to do |format|
      if  @album.save
        flash[:notice] = 'Photo was successfully created.'
        format.html { redirect_to(@album) }
        format.xml  { render :xml => @album, :status => :created, :location =>@album }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.xml
  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        flash[:notice] = 'Photo was successfully updated.'
        format.html { redirect_to(@photo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.xml
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to(photos_url) }
      format.xml  { head :ok }
    end
  end
end
