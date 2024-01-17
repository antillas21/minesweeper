class BoardsController < ApplicationController
  before_action :most_recent_boards, except: %i[show index]

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.layout = ::BoardGenerator.call(**layout_params)
    @board.save!

    redirect_to @board
  rescue => e
    flash.now[:warning] = e.message
    render :new
  end

  def show
    @board = Board.find(params[:id])
  end

  def index
    @boards = BoardsQuery.call(filter_params)
                         .page(params[:page])
                         .per(DEFAULT_PAGE_SIZE)
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

  def most_recent_boards
    @most_recent_boards ||= Board.most_recent
  end

  def filter_params
    params.permit(:name, :created_by, :min_mines)
  end
end
