class InvitationController < ApplicationController
  def show
    @recipient = Recipient.find_by(converted_name_for_link: params[:converted_name_for_link])
    
  end
end
