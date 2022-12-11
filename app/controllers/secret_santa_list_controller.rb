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

      santa_list_participant.save!
    end

    redirect_to '/dashboard'
  end

  def manage
    @list_id = params[:list_id]
    @participants = SantaListParticipant.where(list_id_id: @list_id).order(:id)
    @list = SecretSantaList.find_by(id: @list_id)
  end

  def generate_pairings
    list_id = params[:list_id]
    @participants = SantaListParticipant.where(list_id_id: list_id)

    receiver_ids = []
    @participants.each do |p|
      receiver_ids.append(p.sender.id)
    end

    total_good_matches = 0
    while total_good_matches != @participants.length do
      total_good_matches = 0
      receiver_ids = receiver_ids.shuffle
      @participants.each_with_index do |p, i|
        p.receiver_id_id = receiver_ids[i]
        if p.receiver_id_id != p.sender_id_id
          total_good_matches += 1
        end
        p.save
      end
    end

    redirect_to "/manage_santa_lists/#{list_id}"
  end

end
