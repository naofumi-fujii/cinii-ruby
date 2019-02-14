# frozen_string_literal: true

module Cinii
  class Client
    class Article < Base
      ARTICLE_REQUIRED_KEYS = %I(
          q title author author_id issn publisher affiliation journal volume
          issue page references year_from year_to
        )

      # https://support.nii.ac.jp/ja/cia/api/a_opensearch
      # https://support.nii.ac.jp/ja/cia/api/a_opensearch_full
      def list_articles(**params)
        if params[:full_text] == true
          raise ArgumentError unless has_required_params?(params, [:q])

          response = send_get('/opensearch/fulltext', full_text_params(params))
        else
          raise ArgumentError unless has_required_params?(params, ARTICLE_REQUIRED_KEYS)

          response = send_get('/opensearch/search', article_params(params))
        end

        Cinii::SearchResult::Article.new(response)
      end

      # https://support.nii.ac.jp/ja/cia/api/a_opensearch_auth
      def list_authors(**params)
        raise ArgumentError unless has_required_params?(params, [:q])

        response = send_get('/opensearch/author', author_params(params))

        Cinii::SearchResult::Article.new(response)
      end

      # https://support.nii.ac.jp/ja/cia/api/a_json
      def article(naid)
        raise 'Not implemented yet.'

        response = send_get("/naid/#{naid}")
      end

      # https://support.nii.ac.jp/ja/cia/api/a_json_auth
      def author(nrid)
        raise 'Not implemented yet.'

        response = send_get("/nrid/#{nrid}")
      end

      private

        def article_params(params)
          {
            q:           params[:q],
            count:       params[:count],
            lang:        params[:lang],
            start:       params[:start],
            title:       params[:title],
            author:      params[:author],
            authorid:    params[:author_id],
            issn:        params[:issn],
            publisher:   params[:publisher],
            affiliation: params[:affiliation],
            journal:     params[:journal],
            volume:      params[:volume],
            issue:       params[:issue],
            page:        params[:page],
            references:  params[:references],
            year_from:   params[:year_from],
            year_to:     params[:year_to],
            range:       params[:range],
            sortorder:   params[:sortorder]
          }.compact
        end

        def full_text_params(params)
          {
            q:         params[:q],
            count:     params[:count],
            lang:      params[:lang],
            start:     params[:start],
            sortorder: params[:sortorder]
          }.compact
        end

        def author_params(params)
          {
            q:         params[:q],
            count:     params[:count],
            lang:      params[:lang],
            start:     params[:start],
            sortorder: params[:sortorder]
          }.compact
        end
    end
  end
end
