class BoardsQuery
  def self.call(filters = {})
    new(filters).call
  end

  def initialize(filters = {})
    @filters = filters
  end

  def call
    boards = Board.where(nil)
    filtering_options.each do |key, value|
      boards = boards.public_send(key, value)
    end
    boards
  end

  private

  attr_reader :filters

  def filtering_options
    {
      by_name: filters[:name],
      by_author: filters[:created_by],
      by_min_mines: filters[:min_mines]
    }.compact
  end
end