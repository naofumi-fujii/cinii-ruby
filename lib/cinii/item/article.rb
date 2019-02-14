# frozen_string_literal: true

module Cinii
  class Item
    class Article < Base
      attr_reader :creator, :publisher, :publication_date, :publication_name,
                  :issn, :volume, :number, :starting_page, :ending_page, :page_range,
                  :description

      def initialize(item)
        @creator          = item['dc:creator'].map { |c| c['@value'] }
        @publisher        = item['dc:publisher']
        @publication_date = item['prism:publicationDate']
        @publication_name = item['prism:publicationName']
        @issn             = item['prism:issn']
        @volume           = item['prism:volume']
        @number           = item['prism:number']
        @starting_page    = item['prism:startingPage']
        @ending_page      = item['prism:endingPage']
        @page_range       = item['prism:pageRange']
        @description      = item['description']

        super(item)
      end
    end
  end
end
