# frozen_string_literal: true

class RequestDecoderService
  attr_reader :request

  def initialize(request)
    @request = request
  end

  def decode
    client = find_client_by_ip_addr
    return {} unless client

    decode_request(client)
  end

  private

  def decode_request(client)
    params = request.params
    return {} unless params[:data] && params[:algorithm]

    begin
      data = JWT.decode(params[:data], client.pub_key, true, { algorithm: params[:algorithm] })
      { q: data.first['q'] }
    rescue JWT::DecodeError
      {}
    end
  end

  def find_client_by_ip_addr
    client_address = ClientAddress.find_by(value: request.remote_ip)
    return unless client_address&.active?

    client = client_address.client
    client if client.active?
  end
end
