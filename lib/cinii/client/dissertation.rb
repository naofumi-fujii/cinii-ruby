# frozen_string_literal: true

module Cinii
  class Client
    class Dissertation < Base
      # https://support.nii.ac.jp/ja/cid/api/d_opensearch
      def list_dissertations(**params)
        response = send_get('/d/search', dissertation_params(params))
        Cinii::SearchResult::Dissertation.new(response)
      end

      # https://support.nii.ac.jp/ja/cid/api/d_json
      def book(naid)
        raise 'Not implemented yet.'
      end

      private

        def dissertation_params(params)
          {
            q:           params[:q],
            title:       params[:title],
            description: params[:description],
            author:      params[:author],
            grantor:     params[:grantor],
            grantorid:   params[:grantor_id],
            grantid:     params[:grant_id],
            degreename:  params[:degree_name],
            year_from:   params[:year_from],
            year_to:     params[:year_to],
            fulltext:    params[:full_text],
            range:       params[:range],
            sortorder:   params[:sortorder],
            p:           params[:page],
            count:       params[:count]
          }.compact
        end
    end
  end
end
