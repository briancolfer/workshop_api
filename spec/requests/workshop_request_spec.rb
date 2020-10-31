require 'swagger_helper'
require 'faker'

RSpec.describe 'Workshop API', type: :request do
  #TODO: figure out why is there an off by 1
  let!(:workshops) { create_list(:workshop, 10) }
  let(:workshop_id) { workshops.first.id }

  describe 'GET /workshops' do
    before { get '/workshops' }

    it 'returns workshops' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns https status 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /workshops/:id' do
    before { get "/workshops/#{workshop_id}" }

    context "when the workshop exists" do
      it 'returns the workshop' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(workshop_id)
      end

      it 'returns https status 200' do
        expect(response).to have_http_status(200)
      end
    end

    context "when the workshop does not exist" do
      let(:workshop_id) { 100 }

      it "returns http status 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Workshop/)
      end
    end
  end

  describe 'POST /workshops' do
    let(:valid_attributes) { { workshop_name: 'Workshop1' ,
                               description:  'A workshop description',
                               start_date:  1.days.from_now,
                               end_date:  7.days.from_now
    } }

    context 'when the request is valid' do
      before { post '/workshops', params: valid_attributes}

      it'creates a workshop' do

        expect(json['workshop_name']).to eq('Workshop1')
      end

      it 'returns http status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/workshops', params: { workshop_name: '1234' } }

      it 'returns a https status of 422' do
        #puts("\nDEBUG: #{__LINE__}: response body is #{response.body}\n")
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Workshop name is too short/)
      end

    end

    describe 'PUT /workshop/:id' do
      let(:valid_attributes) { { workshop_name: 'Updated workshop',
                                 description: 'Updated description',
                                 start_date: 7.days.from_now,
                                 end_date: 14.days.from_now
      }}

      context 'when the request is valid' do
        before { put "/workshops/#{workshop_id}", params: valid_attributes}

        it 'updates the record' do
          expect(response.body).to be_empty
        end

        it 'returns http status 204' do
          expect(response).to have_http_status(204)
        end
      end
    end


  end

  path '/workshops' do

    post 'Creates a workshop ' do
      TAGS_WORKSHOPS = 'WORKSHOPS'
      consumes 'application/json'

      parameter name: :workshop, in: :body, schema: {
          type: :object,
          properties: {
              workshop_name: { type: :string },
              description: { type: :string },
              description: { type: :string },
              start_date: { type: :string },
              end_date: { type: :string }
          },
          required: ['workshop_name', 'start_date', 'end_date']
      }

      response '201', 'Workshop created' do
        let(:workshop) { { workshop_name: "#{Faker::University.name} workshop",
                           description: Faker::Lorem.sentence,
                           start_date: 1.week.since,
                           end_date: 2.week.since
        } }
        run_test!
      end

      response '422', 'Invalid request' do
        let(:workshop) { { workshop_name: "#{Faker::University.name} workshop" } }
        run_test!
      end
    end
  end

  #TODO: get swagger specs to work
  path '/workshops/{id}' do

    get 'Returns a workshop' do
      tags 'Workshops'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'workshop found' do
        schema type: :object,
               properties: {
                   id: { type: :integer },
                   workshop_name: { type: :string },
                   description: { type: :string },
                   start_date: { type: :string },
                   end_date: { type: :string }
               },
               required: ['id', 'workshop_name', 'start_date', 'end_date']

        let(:id) { Workshop.create(workshop_name: 'Workshop 1',
                                   description: '0123456789',
                                   start_date: Date.yesterday,
                                   end_date: Date.tomorrow).id }
        run_test!
      end

      response '404', 'workshop not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      # response '406', 'unsupported accept header' do
      #   let(:'Accept') { 'application/foo' }
      #   run_test!
      # end
    end
  end
end
