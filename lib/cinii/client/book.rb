# frozen_string_literal: true

module Cinii
  class Client
    class Book < Base
      # https://support.nii.ac.jp/ja/cib/api/b_opensearch
      def list_books(**params)
        response = send_get('/books/opensearch/search', book_params(params))
        Cinii::SearchResult::Book.new(response)
      end

      # https://support.nii.ac.jp/ja/cib/api/b_opensearch_auth
      def list_authors(**params)
        raise ArgumentError unless has_required_params?(params, [:name])

        response = send_get('/books/opensearch/author', author_params(params))
        Cinii::SearchResult::Book.new(response)
      end

      # https://support.nii.ac.jp/ja/cib/api/b_opensearch_lib
      def list_libraries(**params)
        raise ArgumentError unless has_required_params?(params, [:name])

        response = send_get('/books/opensearch/library', library_params(params))
        Cinii::SearchResult::Book.new(response)
      end

      # https://support.nii.ac.jp/ja/cib/api/b_opensearch_hold
      def list_holders(**params)
        raise ArgumentError unless has_required_params?(params, [:ncid])

        response = send_get('/books/opensearch/holder', holder_params(params))
        Cinii::SearchResult::Book.new(response)
      end

      # https://support.nii.ac.jp/ja/cib/api/b_json
      def book(ncid)
        raise 'Not implemented yet.'
      end

      # https://support.nii.ac.jp/ja/cib/api/b_json_auth
      def author(author_id)
        raise 'Not implemented yet.'
      end

      # https://support.nii.ac.jp/ja/cib/api/b_json
      def library(library_id)equal?
        raise 'Not implemented yet.'
      end

      private

        def book_params(params)
          {
            q:             params[:q],
            title:         params[:title],
            title_exact:   params[:title_exact],
            include_utl:   params[:include_utl],
            author:        params[:author],
            include_alias: params[:include_alias],
            publisher:     params[:publisher],
            subject:       params[:subject],
            note:          params[:note],
            authorid:      params[:author_id],
            utid:          params[:utid],
            isbn:          params[:isbn],
            issn:          params[:issn],
            ncid:          params[:ncid],
            clas:          params[:clas],
            gmd:           params[:gmd],
            lang:          params[:lang],
            fano:          params[:fano],
            kid:           params[:kid],
            area:          params[:area],
            year_from:     params[:year_from],
            year_to:       params[:year_to],
            type:          params[:type],
            sortorder:     params[:sortorder],
            p:             params[:page],
            count:         params[:count]
          }.compact
        end

        def author_params(params)
          {
            name:      params[:name],
            sortorder: params[:sortorder],
            p:         params[:page],
            count:     params[:count]
          }.compact
        end

        def library_params(params)
          author_params(params)
        end

        def holder_params(params)
          {
            ncid:       params[:ncid],
            ill:        params[:ill],
            ill_stat:   params[:ill_stat],
            ill_copys:  params[:ill_copys],
            ill_loans:  params[:ill_loans],
            ill_faxs:   params[:ill_faxs],
            ill_oclc:   params[:ill_oclc],
            ill_keris:  params[:ill_keris],
            ill_offset: params[:ill_offset],
            fano:       params[:fano],
            year:       params[:year],
            vol:        params[:vol],
            issue:      params[:issue],
            count:      params[:count]
          }.compact
        end
    end
  end
end
