require 'rails_helper'

RSpec.describe BoardsQuery do
  subject { described_class.call(filters) }

  let(:filters) { {} }
  let!(:existing_boards) { FactoryBot.create_list(:board, 5, mines_count: 3) }

  context 'without filters' do
    it 'retrieves all Board records' do
      expect(subject).to include(*existing_boards)
    end
  end
   
  context 'with filters' do
    describe 'filter by name' do
      let(:filters) { { name: board_name } }
      let!(:matching_board) { FactoryBot.create(:board, name: board_name) }
      let(:board_name) { 'Matching Board' }

      it 'retrieves exact matching boards' do
        expect(subject).to include(matching_board)
        expect(subject).to_not include(*existing_boards)
      end

      context 'with partial matches' do
        let(:filters) { { name: 'Match' } }

        it 'retrieves boards with partial string matches' do
          expect(subject).to include(matching_board)
        end
      end
    end

    describe 'filter by created_by' do
      let(:filters) { { created_by: email } }
      let!(:matching_board) { FactoryBot.create(:board, created_by: email) }
      let(:email) { 'test_subject@example.com' }

      it 'retrieves exact created_by matching boards' do
        expect(subject).to include(matching_board)
        expect(subject).to_not include(*existing_boards)
      end

      context 'with partial matches' do
        let(:filters) { { created_by: 'test' } }

        it 'retrieves boards with partial string matches' do
          expect(subject).to include(matching_board)
        end
      end
    end

    describe 'filter min mines count' do
      let(:filters) { { min_mines: min_number } }
      let!(:matching_board) { FactoryBot.create(:board, mines_count: min_number + 3) }
      let(:min_number) { 5 }

      it 'retrieves boards with at least min mines count' do
        expect(subject).to include(matching_board)
        expect(subject).to_not include(*existing_boards)
      end
    end
  end
end