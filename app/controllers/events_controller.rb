class EventsController < ApplicationController

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
    redirect_to("/events/index")
  end

  def invitation
    @event = Event.find_by(id: params[:id])
    @recipient = Recipient.find_by(converted_name_for_link: params[:converted_name_for_link])
    @day_id = ["Minggu", "Senin", "Selasa", "Rabu", "Kamis", "Jum'at", "Sabtu"]
    @month_id = ["Januari", "Februari", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"]
  end
end
