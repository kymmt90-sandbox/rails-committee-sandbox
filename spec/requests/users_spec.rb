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

  describe 'GET /user/:id', json: :true do
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
end
