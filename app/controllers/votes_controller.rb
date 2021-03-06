class VotesController < ApplicationController
  def create
    authorize! :vote, _movie

    _voter.vote(_type)

    SendEmailJob.new(_movie.user.email, _movie.user.name).enqueue(wait: 5.seconds)

    redirect_to root_path, notice: 'Vote cast'
  end

  def destroy
    authorize! :vote, _movie

    _voter.unvote

    SendEmailJob.new(_movie.user.email, _movie.user.name).enqueue(wait: 5.seconds)

    redirect_to root_path, notice: 'Vote withdrawn'
  end

  private

  def _voter
    VotingBooth.new(current_user, _movie)
  end

  def _type
    case params.require(:t)
    when 'like' then :like
    when 'hate' then :hate
    else raise
    end
  end

  def _movie
    @_movie ||= Movie[params[:movie_id]]
  end
end
