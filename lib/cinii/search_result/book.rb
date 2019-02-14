# frozen_string_literal: true

module Cinii
  class SearchResult
    class Book < Base
      def items
        items = graph['items']

        @items ||= items ? items.map { |i| item_class.new(i) } : []
      end

      private

      def item_class
        case title
        when /CiNii Books OpenSearch/
          Cinii::Item::Book
        when /CiNii Books Author/
          Cinii::Item::Author
        when /CiNii Books Library/
          Cinii::Item::Library
        when /CiNii Books Holder/
          Cinii::Item::Library
        else
          raise UnKnownResponseTypeError
        end
      end
    end
  end
end
