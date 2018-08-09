class StoredfilesController < ApplicationController
  before_action :set_storedfile, only: [:show, :edit, :update, :destroy]

  # GET /storedfiles
  # GET /storedfiles.json
  def index
    @storedfiles = @current_user.storedfiles
  end

  # GET /storedfiles/1
  # GET /storedfiles/1.json
  def show
    fd = open @storedfile.path
    send_data fd.read, filename: @storedfile.name  
  end

  # GET /storedfiles/new
  def new
    @storedfile = Storedfile.new
  end

  # POST /storedfiles
  # POST /storedfiles.json
  def create
    uploaded_io = params[:storedfile][:file]
    begin 
      Dir.mkdir(File.join('/srv/files/', @current_user.id.to_s))
    rescue Exception => e
    end
    filename = File.join('/srv/files/', @current_user.id.to_s, 
                          File.basename(uploaded_io.original_filename))
        
    File.open(filename, 'wb') do |file|
        file.write(uploaded_io.read)
    end
    @storedfile = Storedfile.new(
          path: filename,
          name: uploaded_io.original_filename, user: @current_user)
    respond_to do |format|
      if @storedfile.save
        format.html { redirect_to storedfiles_path, notice: 'Storedfile was successfully created.' }
        format.json { render :show, status: :created, location: @storedfile }
      else
        format.html { render :new }
        format.json { render json: @storedfile.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @storedfile.update(storedfile_params)
        format.html { redirect_to @storedfile, notice: 'File was successfully updated.' }
        format.json { render :show, status: :ok, location: @storedfile }
      else
        format.html { render :edit }
        format.json { render json: @storedfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /storedfiles/1
  # DELETE /storedfiles/1.json
  def destroy
    @storedfile.destroy
    respond_to do |format|
      format.html { redirect_to storedfiles_url, notice: 'Storedfile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_storedfile
      @storedfile = Storedfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
   def storedfile_params
     params.require(:storedfile).permit(:name, :path)
   end
end
