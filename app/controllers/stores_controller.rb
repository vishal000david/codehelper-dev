class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]

  # GET /stores
  # GET /stores.json
  def index
    @stores = Store.where(user_id: current_user.id)
    @quota =  @stores.sum{|u| u.upload.size}
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
  end

  # GET /stores/new
  def new
    @store = Store.new
    @quota =  Store.where(user_id: current_user.id).sum{|u| u.upload.size}
  end

  # GET /stores/1/edit
  def edit 
  end

  # POST /stores
  # POST /stores.json
  def create
    @current_quota = Store.where(user_id: current_user.id).sum{|u| u.upload.size}
 
    if @current_quota +  params[:store][:upload].size < 10000
      @store = current_user.stores.build(store_params)
      respond_to do |format|
        if @store.save
          format.html { redirect_to @store, notice: 'Store was successfully created.' }
          format.json { render :show, status: :created, location: @store }
        else
          format.html { render :new }
          format.json { render json: @store.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to stores_path
      flash[:error] = "Limit Reached!!! cannot upload more files"
    end  
end




  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to @store, notice: 'Store was successfully updated.' }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to stores_url, notice: 'Store was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:upload, :folderType)
    end
end
