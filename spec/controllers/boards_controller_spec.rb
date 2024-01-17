require 'rails_helper'

RSpec.describe BoardsController, type: :controller do
  shared_examples_for 'renders new board page' do
    it 'renders form to create new board' do
      expect(subject).to render_template('new')
    end
  end

  shared_examples_for 'retrieves most recent boards' do
    it 'calls #most_recent_boards method' do
      subject
      expect(assigns[:most_recent_boards]).to_not be_nil
    end
  end

  describe '#new' do
    subject { get :new }

    it_behaves_like 'renders new board page'
    it_behaves_like 'retrieves most recent boards'
  end

  describe '#create' do
    subject { post :create, params: params }

    let(:params) { { board: board_params } }
    let(:board_params) { nil }

    it_behaves_like 'retrieves most recent boards'

    context 'no params provided' do
      it_behaves_like 'renders new board page'
    end

    context 'with params' do
      context 'valid params' do
        let(:board_params) do
          {
            width: 5,
            height: 5,
            mines_count: 5,
            name: 'My First Board',
            created_by: 'user@example.com'
          }
        end
        let(:board) { Board.last }

        it 'creates a new Board record' do
          expect { subject }.to change { Board.count }.by(1)
        end

        it 'redirects to board show page' do
          expect(subject).to redirect_to(board_path(board))
        end
      end

      context 'invalid/missing params' do
        let(:board_params) do
          {
            width: 5,
            height: 5,
            mines_count: 5
          }
        end

        it_behaves_like 'renders new board page'
      end
    end
  end

  describe '#index' do
    subject { get :index }

    let!(:existing_boards) { FactoryBot.create_list(:board, total_boards_count) }
    let(:total_boards_count) { 40 }

    it 'renders #index view' do
      expect(subject).to render_template('index')
    end

    it 'lists a paginated collection of Board records' do
      subject
      expect(assigns[:boards].size).to_not eq(total_boards_count)
      expect(assigns[:boards].size).to eq(DEFAULT_PAGE_SIZE)
    end

    describe 'page param' do
      subject { get :index, params: { page: 2 } }

      it 'receives an optional ?page= param' do
        expect { subject }.to_not raise_error
      end

      it 'retrieves corresponding records' do
        subject
        expect(assigns[:boards].size).to eq(total_boards_count - DEFAULT_PAGE_SIZE)
      end
    end
  end
end