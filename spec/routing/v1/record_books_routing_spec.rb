require 'rails_helper'

RSpec.describe 'V1 Record Books Routing', type: :routing do
  it 'routes POST "/v1/record_books" to RecordBooksController' do
    expect(post('/v1/record_books')).to route_to 'v1/record_books#create', format: 'json'
  end

  it 'routes DELETE "/v1/record_books/:id" to RecordBooksController' do
    expect(delete('/v1/record_books/1')).to route_to 'v1/record_books#destroy', format: 'json', id: '1'
  end

  it 'routes GET "/v1/record_books" to RecordBooksController' do
    expect(get('/v1/record_books')).to route_to 'v1/record_books#index', format: 'json'
  end

  it 'routes GET "/v1/record_books/:id" to RecordBooksController' do
    expect(get('/v1/record_books/1')).to route_to 'v1/record_books#show', format: 'json', id: '1'
  end

  it 'routes PATCH "/v1/record_books/:id" to RecordBooksController' do
    expect(patch('/v1/record_books/1')).to route_to 'v1/record_books#update', format: 'json', id: '1'
  end
end
