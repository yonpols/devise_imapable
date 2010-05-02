require 'net/imap'

module Devise

  # simple adapter for imap credential checking
  # (i don't like to add stuff like this directly to the model)
  module ImapAdapter

    def self.valid_credentials?(username, password)
      if Devise.imap_server_use_ssl
        port = 993
      else
        port = 143
      end
      imap = Net::IMAP.new(Devise.imap_server, port, Devise.imap_server_use_ssl)
      imap.authenticate("cram-md5", username, password)
      true
    rescue Net::IMAP::ResponseError => e
      false
    ensure
      imap.disconnect unless imap.nil?
    end

  end

end