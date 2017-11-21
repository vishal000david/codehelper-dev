class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]
  before_action :get_quota, only: [:index, :new, :create,:select_folder]
  before_action :validate_store , only:[:create]

  # GET /stores
  # GET /stores.json
  def index
    #@stores.inject(0){|sum,x| sum + x.upload.size }
    @folder = Folder.new
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
  end

  # GET /stores/new
  def new
    @store = Store.new
  end

  # GET /stores/1/edit
  def edit 
  end

  # POST /stores
  # POST /stores.json
  def create   
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


  def select_folder
    # @store_list = @stores.where(folderType: params[:type])
    @user_shares = Share.where(:reciever_id => current_user.id)
   render :template => "partials/folder"
  end

   def give_perm
    @share = Share.new
    @share.reciever_id =params[:share][:reciever_id].to_i
    @share.user_id = current_user.id.to_i
    @share.permission = params[:share][:permission]
    @share.store_id = params[:share][:store_id].to_i
     
     if @share.save
      redirect_to stores_path
      flash[:notice] ="Permission granted"
     else
      redirect_to stores_path
      flash[:error] = "Some error occured"
     end
    #  params[:share][:reciever_id]
    #  params[:share][:permission]
   end

   def open_share_modal
     @share = Share.new
     @except_current = User.where.not(:id => current_user.id) 
     @current_store_id = params[:store_id].to_i
     respond_to do |format|
      format.js
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

    def get_quota
      # Share.where(:reciever_id => current_user.id).collect{|x| x.store_id}
      # @stores = current_user.stores
      @store_ids = Share.where(:reciever_id => current_user.id).collect{|x| x.store_id}
      @stores = Store.where(id: @store_ids) 
      @quota =  @stores.sum{|u| u.upload.size}
    end  

    def validate_store
      if @quota +  params[:store][:upload].size > current_user.membership.totalQuota
        redirect_to stores_path
        flash[:error] = "Limit Reached!!! cannot upload more files" 
      end
    end
end
