# frozen_string_literal: true

module Cinii
  class Item
    class Base
      attr_reader :id, :type, :title, :link, :see_also, :date

      def initialize(item)
        @id       = item['@id']
        @type     = item['@type']
        @title    = item['title']
        @link     = item['link']['@id']
        @see_also = item['rdfs:seeAlso']['@id']
        @date     = item['dc:date']
      end
    end
  end
end
