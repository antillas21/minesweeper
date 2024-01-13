class BoardGenerator
  def self.call(**kwargs)
    new(**kwargs).call
  end

  def initialize(width:, height:, mines:)
    @width = width
    @height = height
    @mines = mines
  end

  def call
    elements = Array.new(cells_count, EMPTY_CELL_MARKER)
    mines_indexes.each { |idx| elements[idx] = MINE_MARKER }

    elements.each_slice(width)
            .map { |slice| slice }
  end

  private

  EMPTY_CELL_MARKER = ' '.freeze
  MINE_MARKER = 'X'.freeze

  attr_reader :width, :height, :mines

  def cells_count
    width * height
  end

  def mines_indexes
    @mines_indexes ||= (0...cells_count).to_a.sample(mines)
  end
end