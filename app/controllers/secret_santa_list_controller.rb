class SecretSantaListController < ApplicationController
  #Create new santa list, need to know who I can add - gets all users.
  def new
    @users = User.all()
  end

  #Handles "submit" on the new santa list form.
  def save
    #Getting the parameters set by the form.
    list_name = params[:list_name]
    participant_ids = params[:participant_ids]

    #Find username that is stored in the session(logged in user).
    #Needed in order for user to become the organizer.
    user = User.find_by(user_name: session[:user_name])

    #Create secret santa list models with info and saving.
    #e.g (tableplus) secret_santa_lists:organizer_id(2) => list_name(Family)
    secret_santa_list = SecretSantaList.new
    secret_santa_list.organizer = user
    secret_santa_list.list_name = list_name
    secret_santa_list.save!

    #Adding all of the participants to the secret santa list.
    #e.g (tableplus) santa_list_participants:list_id(17) => sender_id(2), list_id(17) => sender_id(3) etc.
    participant_ids.each do |participant_id|
      santa_list_participant = SantaListParticipant.new
      santa_list_participant.secret_santa_list = secret_santa_list
      santa_list_participant.sender_id_id = participant_id

      santa_list_participant.save!
    end

    redirect_to '/dashboard'
  end

  #Shows the matches on the list (who's gifting to who)
  def manage
    @list_id = params[:list_id]
    #Find all santa_list_participant rows where: list_id_id = list_id (@list_id from URL)
    @participants = SantaListParticipant.where(list_id_id: @list_id).order(:id)
    @list = SecretSantaList.find_by(id: @list_id)
  end

  #Shuffles participants as much as you like, if you don't like original match.
  def generate_pairings
    list_id = params[:list_id]
    @participants = SantaListParticipant.where(list_id_id: list_id)

    #Adds existing users in the list to be recieving a gift.
    receiver_ids = []
    @participants.each do |p|
      receiver_ids.append(p.sender.id)
    end

    #While total_good_matches is not equal to the number of participants, keep trying to find a good match.
    #good_match = a match where someone isn't paired up with themselves.
    total_good_matches = 0
    while total_good_matches != @participants.length do
      total_good_matches = 0
      receiver_ids = receiver_ids.shuffle
      @participants.each_with_index do |p, i|
        #setting receiver_id to one of the shuffled reciever id's. (Hopefully, won't be same as sender id!)
        p.receiver_id_id = receiver_ids[i]

        #If receiver_id is not equal to sender_id - add 1 to total_good_matches.
        if p.receiver_id_id != p.sender_id_id
          total_good_matches += 1
        end

        p.save
        # end of loop - if total_good_matches is equal to total no. of participants - we're done.
        # else, the loop starts again and we look for another match.
      end
    end

    redirect_to "/manage_santa_lists/#{list_id}"
  end

end
