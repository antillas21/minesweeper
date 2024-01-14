class BoardsController < ApplicationController
  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.layout = ::BoardGenerator.call(**layout_params)
    @board.save!

    redirect_to @board
  rescue => e
    flash[:notice] = e.message
    render :new
  end

  def show
    
  end

  private

  def board_params
    params.require(:board)
          .permit(:width, :height, :mines_count, :created_by, :name)
  end

  def layout_params
    params.require(:board)
          .permit(:width, :height, :mines_count)
          .to_h
          .symbolize_keys
  end
end
