require File.expand_path '../spec_helper.rb', __FILE__

describe 'Dog Facts' do
  before do
    5.times do |i|
      Fact.create(body: "Fact #{i}")
    end
  end

  it 'should return a json object as response' do
    get '/api/facts'
    headers = last_response.header['Content-Type']
    expect(headers).to include('application/json')
  end

  it 'should return 1 fact if no number is specified' do
    get '/api/facts'
    facts = JSON.parse(last_response.body)["facts"]
    expect(facts.size).to eq(1)
  end

  it 'should return 5 facts if number is specified' do
    get '/api/facts?number=5'
    facts = JSON.parse(last_response.body)["facts"]
    expect(facts.size).to eq(5)
  end

  it 'should return 1 fact if number is not integer value' do
    get '/api/facts?number=foobarcandybaz'
    facts = JSON.parse(last_response.body)["facts"]
    expect(facts.size).to eq(1)
  end
end
