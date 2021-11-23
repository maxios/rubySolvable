
require 'spec_helper'

#######################################################
# DO NOT CHANGE THIS FILE - WRITE YOUR OWN SPEC FILES #
#######################################################
RSpec.describe 'ParserService' do
  describe 'ParserService parse the whole file' do
    let(:params) do
      File.read('spec/fixtures/people_by_dollar.txt')
    end
    let(:parser_service) { ParserService.new(params, 'dollar') }

    it 'gets the header' do
      header = parser_service.header

      # Expected format of each entry: `<first_name>, <city>, <birthdate M/D/YYYY>`
      expect(header).to eq ['city', 'birthdate', 'last_name', 'first_name']
    end

    it 'gets the rows' do
      rows = parser_service.rows

      puts rows.inspect
      # Expected format of each entry: `<first_name>, <city>, <birthdate M/D/YYYY>`
      expect(rows.length).to eq 2
      expect(rows.first.first).to eq "LA"
    end
  end
end
