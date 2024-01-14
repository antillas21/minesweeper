require 'rails_helper'

RSpec.describe BoardsController, type: :controller do
  shared_examples_for 'renders new board page' do
    it 'renders form to create new board' do
      expect(subject).to render_template('new')
    end
  end

  describe '#new' do
    subject { get :new }

    it_behaves_like 'renders new board page'
  end

  describe '#create' do
    subject { post :create, params: params }

    let(:params) { { board: board_params } }

    context 'no params provided' do
      let(:board_params) { nil }

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
end