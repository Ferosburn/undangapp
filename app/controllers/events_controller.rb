class EventsController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :new, :create, :delete, :edit, :update]}
  before_action :ensure_correct_user, {only: [:show, :delete, :edit, :update]}

  def index
    @events = Event.all.order(created_at: :desc)
  end

  def show
    @recipients = Recipient.all.order(created_at: :desc)
    @event = Event.find_by(id: params[:id])
    @day_id = ["Minggu", "Senin", "Selasa", "Rabu", "Kamis", "Jum'at", "Sabtu"]
    @month_id = ["Januari", "Februari", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"]
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(
      name: params[:name],
      date: params[:date],
      place: params[:place],
      description: params[:description],
      opening: params[:opening],
      closing: params[:closing],
      sender: params[:sender],
      sender_status: params[:sender_status],
      user_id: @current_user.id
    )
    if @event.save
      flash[:success] = "Acara berhasil dibuat"
      redirect_to("/events/index")
    else
      render("events/new")
    end
  end

  def delete
    @event = Event.find_by(id: params[:id])
    @event.destroy
    @recipient = Recipient.where(event_id: params[:id])
    @recipient.destroy_all
    flash[:warning] = "Acara berhasil dihapus"
    redirect_to("/events/index")
  end

  def edit
    @event = Event.find_by(id: params[:id])
  end

  def update
    @event = Event.find_by(id: params[:id])
    @event.name = params[:name]
    @event.date = params[:date]
    @event.place = params[:place]
    @event.description = params[:description]
    @event.opening = params[:opening]
    @event.closing = params[:closing]
    @event.sender = params[:sender]
    @event.sender_status = params[:sender_status]
    @event.save
    flash[:warning] = "Acara berhasil diperbarui"
    redirect_to("/events/index")
  end

  def invitation
    @event = Event.find_by(id: params[:id])
    @recipient = Recipient.find_by(converted_name_for_link: params[:converted_name_for_link])
    @day_id = ["Minggu", "Senin", "Selasa", "Rabu", "Kamis", "Jum'at", "Sabtu"]
    @month_id = ["Januari", "Februari", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"]
    render layout: false
  end

  def ensure_correct_user
    @event = Event.find_by(id: params[:id])
    if @event.user_id != @current_user.id
      flash[:danger] = "Akses dilarang"
      redirect_to("/dashboard/#{@current_user.id}")
    end
  end
end
