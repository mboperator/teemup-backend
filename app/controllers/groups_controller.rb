class GroupsController < ApplicationController
  def index
  end

  def show
    @group = Group.find_by(id: params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      current_user.group_memberships.create(group_id: @group.id, is_admin: true, is_confirmed: true)
      redirect_to @group, notice: 'Group was successfully created.'
    end
  end

  def update
    @group = Group.find_by(id: params[:id])
    if @group.update_attributes(group_params)
      redirect_to @group, notice: 'Group was successfully updated.'
    end
  end

  def destroy
    @group = Group.find_by(id: params[:id])
    @group.destroy
    redirect_to groups_url
  end

  def edit
    @group = Group.find_by(id: params[:id])
  end

  private
  def group_params
    params.require(:group)
          .permit(:name, :description, :created_by_id)
  end


end
