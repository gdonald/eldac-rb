# frozen_string_literal: true

class RequestEncoderService
  include Headers

  attr_reader :term, :private_key, :algorithm

  def initialize(term, private_key: nil, algorithm: nil)
    @term = term
    @private_key = private_key || ENV.fetch('RSA_PRIVATE_KEY', nil)
    @algorithm = algorithm || ENV.fetch('RSA_ALGO', nil)
  end

  def encode
    Rails.logger.error('Invalid RSA private key value') unless private_key
    Rails.logger.error('Invalid RSA algorithm value') unless algorithm

    return unless private_key && algorithm

    body = { data:, algorithm: }.to_json
    headers = self.headers.merge({ 'Content-Type' => 'application/json' })

    { body:, headers: }
  end

  private

  def pkey
    OpenSSL::PKey::RSA.new(private_key)
    # rescue StandardError
    #   logger.error('Invalid RSA private key value')
  end

  def data
    JWT.encode({ q: term }, pkey, algorithm)
    # rescue StandardError
    #   logger.error('Failed to encode JWT data')
  end
end
