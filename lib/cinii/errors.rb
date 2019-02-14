# frozen_string_literal: true

module Cinii
  class CiniiError < StandardError; end
  class RemoteURLNotAvailableError < CiniiError; end
  class APIResponseError < CiniiError; end
  class UnKnownResponseTypeError < CiniiError; end
end
