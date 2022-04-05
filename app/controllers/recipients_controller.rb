class RecipientsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:delete_recipient]}

  def create
    @recipient = Recipient.new(
      name: params[:name],
      converted_name_for_link: params[:name].split(%r(\W|\d|_)).join("").downcase,
      event_id: params[:event_id],
      user_id: @current_user.id
    )
    if @recipient.save
      flash[:success] = "penerima berhasil ditambahkan"
      redirect_to("/events/#{params[:event_id]}")
    else
      flash[:warning] = "penerima sudah ada"
      redirect_to("/events/#{params[:event_id]}")
    end
  end

  def delete_recipient
    # @event = Event.find_by(event_id: params[:event_id])
    @recipient = Recipient.find_by(id: params[:id])
    @recipient.destroy
    flash[:warning] = "penerima berhasil dihapus"
    redirect_to("/events/#{params[:event_id]}")
  end

  def ensure_correct_user
    @recipient = Recipient.find_by(id: params[:id])
    if @recipient.user_id != @current_user.id
      flash[:danger] = "Akses dilarang"
      redirect_to("/dashboard/#{@current_user.id}")
    end
  end
end