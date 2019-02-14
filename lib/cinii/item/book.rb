# frozen_string_literal: true

module Cinii
  class Item
    class Book < Base
      attr_reader :creator, :publisher, :publication_date, :is_part, :has_part, :owner_count

      def initialize(item)
        @publisher        = item['dc:publisher']
        @publication_date = item['prism:publicationDate']
        @creator          = item['dc:creator']
        @is_part          = item['dcterms:isPartOf']&.map { |c| { id: c['@id'], title: c['dc:title']} }
        @has_part         = item['dcterms:hasPart']&.map { |c| c['@id'] }
        @owner_count      = item['cinii:ownerCount']

        super(item)
      end
    end
  end
end
