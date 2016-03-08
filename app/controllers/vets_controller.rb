class VetsController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def index
    if params[:search]
      @vets = Vet.search(params[:search]).order("name DESC")
    else
      @vets = Vet.all.order('name DESC')
    end
    @all_vets = Vet.all
    render json: @all_vets
  end

  def show
    id = params[:id]
    @vet = Vet.find(id)
    @user = User.find(@current_user.id)
    @service_vets = ServiceVet.where("vet_id = '#{id}'")
    @services = @service_vets.map do |sv|
      sv_id = sv.service_id
      Service.find(sv_id)
    end
    @user_vet = UserVet.where(:user => @user, :vet => @vet).first
  end

  def new
    @vet = Vet.new
    @action = "create"
  end

  def create
    # creates a new vet using the params passed in
    @vet = Vet.create(vet_params[:vet])
    redirect_to root_path
  end

def create_uservet
  id = params[:id]
  @vet = Vet.find(id)
  @user = User.find(@current_user.id)
  @user.vets << @vet
  flash[:notice] = 'Vet was added to your list'
  redirect_to root_path
rescue
  flash[:notice] = 'Vet was not added to your list'
  redirect_to vet_path(@vet)
end

  def edit
    id = params[:id]
    @vet = Vet.find(id)
    @action = "update"
  end

  def update
    id = params[:id]
    Vet.update(id, vet_params[:vet])
    redirect_to root_path
  end

  def destroy
    id = params[:id]
    Vet.destroy(id)
    redirect_to root_path
  end

  private

  def vet_params
    params.permit(vet:[:name, :url, :email, :address, :phone, :fax, :favorite])
  end

  def only_owner
      if !@current_user || @current_user.id != Vet.find(params[:id]).user_id
        flash[:error] = "You are not authorized to view that section"
        redirect_to root_path
      end
  end

end
