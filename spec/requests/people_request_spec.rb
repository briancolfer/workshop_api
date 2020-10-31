require 'swagger_helper'
require 'faker'

RSpec.describe 'People API', type: :request do
  # create 9 additional people
  let!(:people) { create_list(:person, 10) }
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
  #
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

    context 'when a person record does not exist' do
      let(:person_id) { 100 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Person/)
      end
    end
  end

  # Tests for POST /people
  describe 'POST /people' do
    # valid payload
    let(:valid_attributes) { { first_name: 'Fred', last_name: 'Flintstone', birth_date: '01/01/1960' } }

    context 'when the request is valid' do
      before { post '/people', params: valid_attributes }

      it 'creates a person' do
        expect(json['first_name']).to eq('Fred')
      end

      it 'returns http status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/people', params: { first_name: 'Wilma' } }

      it 'returns http status 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Last name can't be blank/)
      end
    end
  end

  describe 'PUT /people/:id' do
    let(:valid_attributes) { { first_name: 'Barny', last_name: 'Rubble', birth_date: '01/01/1960' } }

    context 'when the person record exists' do
      before { put "/people/#{person_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns http status 204' do
        expect(response).to have_http_status(204)
      end
    end
  end
end
=begin
describe 'People API', type: :request, swagger_doc: 'api/swagger_doc.json' do
  TAGS_PEOPLE = Person.freeze

  path '/people' do

    post 'Creates a person' do
      tags TAGS_PEOPLE
      consumes 'application/json'
      parameter name: :person, in: :body, schema: {
          type: :object,
          properties: {
              first_name: { type: :string },
              last_name: { type: :string },
              birth_date: { type: :string }
          },
          required: ['first_name', 'last_name', 'birth_date']
      }

      response '201', 'person created' do
        let(:person) { { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
                         birth_date: Faker::Date.birthday
        } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:person) { { first_name: Faker::Name.first_name } }
        run_test!
      end
    end

    get 'Returns all people' do
      tags TAGS_PEOPLE
      produces 'application/json'

      response '200', "People found" do
        before { create_list(:person, 2)}

        # include_context 'with integration test'
      end
    end

    #TODO: fix swagger for get person
    get 'Retrieves a person' do
      tags 'People'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'person found' do
        schema type: :object,
               properties: {
                   id: { type: :integer },
                   fist_name: { type: :string },
                   last_name: { type: :string },
                   birth_date: { type: :string }
               },
               required: ['id', 'first_name', 'last_name', 'birthdate']

        let(:id) { Person.create(first_name: "First_Name",
                                 last_name: "Last_Name",
                                 birth_date: Faker::Date.birthday(min_age: 20, max_age: 65) ).id }
        run_test!
      end
    end
  end
end
=end
