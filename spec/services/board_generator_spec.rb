require 'rails_helper'

RSpec.describe BoardGenerator do
  describe '.call' do
    subject { described_class.call(**args) }

    let(:args) do
      {
        width: width,
        height: height,
        mines_count: mines_count
      }.compact
    end

    it 'errors out without arguments' do
      expect { described_class.call }.to raise_error(ArgumentError)
    end

    context 'with arguments' do
      let(:width) { 2 }
      let(:height) { 2 }
      let(:mines_count) { 2 }

      it 'does not raise error' do
        expect { subject }.to_not raise_error
      end

      describe 'output' do
        it 'returns an array' do
          expect(subject).to be_an(Array)
        end

        it 'array includes `height` times arrays' do
          expect(subject.size).to eq(height)
        end

        describe 'a row array' do
          it 'inclues `width` times elements' do
            row = subject.first
            expect(row.size).to eq(width)
          end
        end

        it 'includes elements representing mines as X' do
          resulting_mines = subject.flatten.select { |e| e == described_class::MINE_MARKER }
          expect(resulting_mines.size).to eq(mines_count)
        end
      end
    end
  end
end