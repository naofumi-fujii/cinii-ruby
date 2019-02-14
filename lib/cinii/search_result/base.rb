# frozen_string_literal: true

require 'date'

module Cinii
  class SearchResult
    class Base
      def initialize(faraday_response)
        @raw_body = faraday_response.body

        raise APIResponseError, 'レスポンスに@graph属性が含まれていません' unless body['@graph']
      end

      def items
        raise 'This method must be overridden.'
      end

      # タイトル
      def title
        @title ||= graph['title']
      end

      # タイトルと同じ
      def description
        @description ||= graph['description']
      end

      # リクエストURI
      def link
        @link ||= graph['link']['@id']
      end

      # 検索日時
      def date
        @date ||= DateTime.parse(graph['dc:date'])
      end

      # 検索結果総数
      def total_items
        @total_items ||= graph['opensearch:totalResults'].to_i
      end

      # 検索結果の開始番号
      def start_index
        @start_index ||= graph['opensearch:startIndex'].to_i
      end

      # 検索結果件数
      def items_per_page
        @items_per_page ||= graph['opensearch:itemsPerPage'].to_i
      end

      # 現在のページ数
      def current_page
        (start_index.to_f / items_per_page.to_f).ceil
      end

      # 全てのページ数
      def total_pages
        (total_items.to_f / items_per_page.to_f).ceil
      end

      # 最初のページ判定
      def first_page?
        start_index.between?(1, items_per_page)
      end

      # 最終ページ判定
      def last_page?
        start_index.between?(last_page_start_index, total_items)
      end

      # 次ページの開始番号
      def next_page_start_index
        start_index + items_per_page
      end

      # 前ページの開始番号
      def prev_page_start_index
        index = start_index - items_per_page
        index >= 1 ? index : 1
      end

      # 最終ページの開始番号
      def last_page_start_index
        total_items - items_per_page
      end

      private

        def body
          @raw_body
        end

        def graph
          body['@graph'].first
        end
    end
  end
end
