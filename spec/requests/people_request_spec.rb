require 'swagger_helper'
require 'faker'

RSpec.describe 'People API', type: :request do
  # create 9 additional people
  let!(:people) { create_list(:person, 9) }
  let(:person_id) { people.first.id }

  # Get people
  describe 'GET /people' do
    before { get '/people' }

    it 'returns people' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns http status 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /people/:id' do
    before { get "/people/#{person_id}" }

    context 'when a person record exists' do
      it 'returns the person' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(person_id)
      end

      it 'returns http status 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  path '/people' do

    post 'Creates a person' do
      tags 'People'
      consumes 'application/json'
      parameter name: :person, in: :body, schema: {
          type: :object,
          properties: {
              first_name: {type: :string},
              last_name: {type: :string},
              birth_date: {type: :string}
          },
          required: ['first_name', 'last_name', 'birth_date']
      }

      response '201', 'person created' do
        let(:person) { {first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
                        birth_date: Faker::Date.birthday
        } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:person) { {first_name: Faker::Name.first_name} }
        run_test!
      end
    end
  end

end

