class BoardGenerator
  def self.call(**kwargs)
    new(**kwargs).call
  end

  def initialize(width:, height:, mines_count:)
    @width = width
    @height = height
    @mines_count = mines_count
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

  attr_reader :width, :height, :mines_count

  def cells_count
    width * height
  end

  def mines_indexes
    @mines_indexes ||= (0...cells_count).to_a.sample(mines_count)
  end
end