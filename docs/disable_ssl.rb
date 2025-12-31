require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
puts "⚠️ SSL Verification disabled for local development"
