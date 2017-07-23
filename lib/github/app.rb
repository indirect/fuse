require "jwt"
require "openssl"
require "time"

module Github
  class App
    attr_reader :github_id, :private_key

    def initialize(id, key)
      @github_id = id
      @private_key = key
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