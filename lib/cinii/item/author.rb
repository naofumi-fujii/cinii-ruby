# frozen_string_literal: true

module Cinii
  class Item
    class Author < Base
      attr_reader :description, :subject

      def initialize(item)
        @description = item['description']
        @subject     = item['dc:subject']

        super(item)
      end
    end
  end
end
