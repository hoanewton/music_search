class SongsController < ApplicationController

  def index
  end

  def search
    binding.pry
    @songs = Song.search(params)
    respond_to do |format|
    # format.html {render or redirect_to wherever you need it}
      format.js 
    end
  end

end