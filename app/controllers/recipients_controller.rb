class RecipientsController < ApplicationController

  def create
    @recipient = Recipient.new(
      name: params[:name],
      converted_name_for_link: params[:name].split(%r(\W|\d|_)).join("").downcase,
      event_id: params[:event_id],
      user_id: @current_user.id
    )
    @recipient.save
    redirect_to("/events/#{params[:event_id]}")
  end

  def delete_recipient
    # @event = Event.find_by(event_id: params[:event_id])
    @recipient = Recipient.find_by(id: params[:id])
    @recipient.destroy
    redirect_to("/events/#{params[:event_id]}")
  end
end