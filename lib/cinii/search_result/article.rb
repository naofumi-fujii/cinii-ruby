# frozen_string_literal: true

module Cinii
  class SearchResult
    class Article < Base
      def items
        items = graph['items']

        @items ||= items ? items.map { |i| item_class.new(i) } : []
      end

      private

        def item_class
          case title
          when /CiNii OpenSearch/
            Cinii::Item::Article
          when /CiNii Author OpenSearch/
            Cinii::Item::Author
          when /CiNii FullText OpenSearch/
            Cinii::Item::Article
          else
            raise UnKnownResponseTypeError
          end
        end
    end
  end
end
