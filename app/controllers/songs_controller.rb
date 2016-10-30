class SongsController < ApplicationController

  def index
  end

  def search
    @songs = Song.search(params)
    respond_to do |format|
      format.js 
    end
  end

end