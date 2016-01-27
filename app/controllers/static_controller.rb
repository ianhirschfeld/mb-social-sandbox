class StaticController < ApplicationController

  def home
    @user = current_user
    @facebook_auth_url = MiniFB.oauth_url(
      ENV['FACEBOOK_APP_ID'],
      facebook_auth_users_url,
      scope: "public_profile,manage_pages,user_managed_groups"
    )
    @facebook_accounts = [['My Feed', 0]] + current_user.facebook_groups.pluck(:name, :group_id) + current_user.facebook_pages.pluck(:name, :page_id)
  end

end
