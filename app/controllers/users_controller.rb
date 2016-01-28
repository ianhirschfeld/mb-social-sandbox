class UsersController < ApplicationController
  before_action :require_login

  def message
    @message = params[:user][:message]
    post_to_facebook = params[:user][:post_to_facebook]
    current_user.update_attributes(posted_to_facebook_lasttime: post_to_facebook == '1')
    if post_to_facebook.present? && post_to_facebook == '1'
      if facebook_account = params[:user][:facebook_account].presence
        # TODO: Post to Facebook
        if facebook_account == '0'
          # Post to personal feed
          @success = 'Sucessfully posted to your personal Facebook feed.'
        elsif group = current_user.facebook_groups.find_by(group_id: facebook_account)
          # Post to group
          @success = "Sucessfully posted to the #{group.name} Facebook group."
        elsif page = current_user.facebook_pages.find_by(page_id: facebook_account)
          # Post to page
          @success = "Sucessfully posted to the #{page.name} Facebook page."
        end
        current_user.update_attributes(last_facebook_account: facebook_account)
      end
    end
  end

  def facebook_auth
    # NOTE: This was crashing for some reason.
    # access_token_hash = MiniFB.oauth_access_token(
    #   ENV['FACEBOOK_APP_ID'],
    #   facebook_auth_users_url,
    #   ENV['FACEBOOK_SECRET'],
    #   params[:code]
    # )

    # Grab Facebook access token
    oauth_url = "https://graph.facebook.com/oauth/access_token"
    oauth_url << "?client_id=#{ENV['FACEBOOK_APP_ID']}"
    oauth_url << "&redirect_uri=#{CGI.escape(facebook_auth_users_url)}"
    oauth_url << "&client_secret=#{ENV['FACEBOOK_SECRET']}"
    oauth_url << "&code=#{CGI.escape(params[:code])}"
    http = HTTPClient.new
    resp = http.get(oauth_url)
    access_token_hash = {}
    params_array = resp.body.to_s.split("&")
    params_array.each do |p|
        ps = p.split("=")
        access_token_hash[ps[0]] = ps[1]
    end
    @access_token = access_token_hash['access_token']

    # Get Facebook MB app id
    me = MiniFB.get(@access_token, 'me', {})
    current_user.update_attributes(facebook_access_token: @access_token, facebook_id: me.id)

    # Gather user's Facebook groups
    groups_response = MiniFB.get(@access_token, 'me', {type: 'groups'})
    groups_response.data.each do |group|
      current_user.facebook_groups.create(group_id: group.id, name: group.name)
    end

    # Gather user's Facebook pages
    pages_response = MiniFB.get(@access_token, 'me', {type: 'accounts'})
    pages_response.data.each do |page|
      current_user.facebook_pages.create(page_id: page.id, name: page.name)
    end

    redirect_to root_path
  end

end
