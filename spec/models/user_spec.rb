require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    subject { create(:user) }
    it { is_expected.to be_valid }
  end

  describe '#email' do
    context '空のとき' do
      subject { build(:user, email: '') }
      it { is_expected.not_to be_valid }
    end

    context 'すでに同じemailを持つuserが存在するとき' do
      let(:email) { 'foo@example.com' }
      before { create(:user, email: email) }
      subject { build(:user, email: email) }
      it { is_expected.not_to be_valid }
    end
  end

  describe '#name' do
    context '空のとき' do
      subject { build(:user, name: '') }
      it { is_expected.not_to be_valid }
    end
  end

  describe '#age' do
    context 'nilのとき' do
      subject { build(:user, age: nil) }
      it { is_expected.to be_valid }
    end

    context '負の値のとき' do
      subject { build(:user, age: -1) }
      it { is_expected.not_to be_valid }
    end

    context '非負の値のとき' do
      subject { build(:user, age: 0) }
      it { is_expected.to be_valid }
    end
  end
end
