# frozen_string_literal: true

module Cinii
  class Item
    class Dissertation < Base
      attr_reader :creator, :publisher, :degree_name, :dissertation_number, :source

      def initialize(item)
        @creator             = item['dc:creator'].map { |c| c['@value'] }
        @publisher           = item['dc:publisher']
        @degree_name         = item['ndl:degreeName']
        @dissertation_number = item['ndl:dissertationNumber']
        @source              = item['dc:source']&.map { |c| { id: c['@id'], title: c['dc:title']} }

        super(item)
      end
    end
  end
end
