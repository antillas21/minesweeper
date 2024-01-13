require 'rails_helper'

RSpec.describe Board, type: :model do
  describe 'validations' do
    subject { build(:board) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:created_by) }
    it { is_expected.to validate_presence_of(:width) }
    it { is_expected.to validate_presence_of(:height) }
    it { is_expected.to validate_presence_of(:mines_count) }

    it { is_expected.to validate_numericality_of(:width).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:height).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:mines_count).is_greater_than(0) }

    describe 'created_by validation' do
      subject { build(:board, created_by: email) }

      context 'valid email address' do
        let(:email) { 'valid@example.com' }

        it { is_expected.to be_valid }
      end

      context 'invald email address' do
        let(:email) { 'foo@something.x' }

        it { is_expected.to be_invalid }
      end
    end
  end
end