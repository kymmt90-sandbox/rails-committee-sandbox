require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users', json: :true do
    before { create_pair(:user) }

    it '200 OKが返る' do
      get "/users"
      expect(response.status).to eq 200
      expected = {
        users: [
          id: Integer,
          email: String,
          name: String,
          age: Integer
        ] * 2
      }
      expect(response.body).to be_json_as expected
    end
  end

  describe 'GET /users/:id', json: :true do
    let!(:user) { create(:user) }

    context '存在するuserのとき' do
      it '200 OKが返る' do
        get "/users/#{user.id}"
        expect(response.status).to eq 200
        expected = {
          id: user.id,
          email: user.email,
          name: user.name,
          age: user.age
        }
        expect(response.body).to be_json_as expected
      end
    end

    context '存在しないuserのとき' do
      let(:invalid_id) { user.id.succ }

      it '404 Not Foundが返る' do
        get "/users/#{invalid_id}"
        expect(response.status).to eq 404
        expected = {
          errors: [
            {
              title: 'User not found',
              detail: "#{invalid_id}"
            }
          ]
        }
        expect(response.body).to be_json_as expected
      end
    end
  end

  describe 'POST /users', json: :true do
    let(:user_attributes) { attributes_for(:user) }
    let(:params) {
      {
        user: {
          email: user_attributes[:email],
          name: user_attributes[:name],
          age: user_attributes[:age],
        }
      }
    }

    context '正しいパラメータのとき' do
      it '201 Createdを返す' do
        expect { post '/users', params: params.to_json }.to change(User, :count).by(1)
        expect(response.status).to eq 201
        expected = {
          id: Integer,
          email: user_attributes[:email],
          name: user_attributes[:name],
          age: user_attributes[:age]
        }
        expect(response.body).to be_json_as expected
      end
    end
  end
end
