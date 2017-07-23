require "jwt"
require "openssl"
require "time"

module Github
  class App
    attr_reader :github_id, :name, :private_key

    def initialize(options)
      @github_id = options.fetch(:id)
      @name = options.fetch(:name)
      @private_key = options.fetch(:private_key)
    end

    def inspect
      "#<Github::App id=#{github_id}>"
    end

    def bearer_token(time = Time.now)
      payload = {
        iat: time.to_i,
        exp: time.to_i + (10 * 60),
        iss: github_id
      }
      rsa_key = OpenSSL::PKey::RSA.new(private_key)

      JWT.encode(payload, rsa_key, "RS256")
    end

  end
end