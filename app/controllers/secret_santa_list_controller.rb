class SecretSantaListController < ApplicationController
  def new
    @users = User.all()
  end

  def save
    list_name = params[:list_name]
    participant_ids = params[:participant_ids]

    user = User.find_by(user_name: session[:user_name])

    secret_santa_list = SecretSantaList.new
    secret_santa_list.organizer = user
    secret_santa_list.list_name = list_name
    secret_santa_list.save!

    participant_ids.each do |participant_id|
      puts "Saving for #{participant_id}"
      santa_list_participant = SantaListParticipant.new
      santa_list_participant.secret_santa_list = secret_santa_list
      santa_list_participant.sender_id_id = participant_id
      # santa_list_participant.list_id_id = 2
      # santa_list_participant.sender_id_id = 2
      santa_list_participant.save!
    end

    redirect_to '/dashboard'
  end
end
