# frozen_string_literal: true

module Cinii
  class SearchResult
    class Dissertation < Base
      def items
        items = graph['items']

        @items ||= items ? items.map { |i| Cinii::Item::Dissertation.new(i) } : []
      end
    end
  end
end
