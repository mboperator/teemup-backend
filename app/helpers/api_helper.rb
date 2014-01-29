module ApiHelper
  def set_user(user)
    @user = user
  end

  def current_user
    @user
  end

  def current_group
    Group.find_by(id: params[:group_id]) if params[:group_id]
  end
end
