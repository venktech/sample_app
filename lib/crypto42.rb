module Crypto42
  class Button
    def initialize(data)
      my_cert_file = Dir.getwd + "/paypal/my-pubcert.pem"
      my_key_file = Dir.getwd + "/paypal/my-prvkey.pem"
      paypal_cert_file = Dir.getwd + "/paypal/paypal_cert.pem"

PAYPAL_CERT_PEM = File.read("#{Rails.root}/certs/paypal_cert.pem")
APP_CERT_PEM = File.read("#{Rails.root}/certs/app_cert.pem")
APP_KEY_PEM = File.read("#{Rails.root}/certs/app_key.pem")

     # IO.popen("/usr/bin/openssl smime -sign -signer #my_cert_file -inkey #my_key_file -outform der -nodetach -binary | /usr/bin/openssl smime -encrypt -des3 -binary -outform pem #paypal_cert_file", 'r+') do |pipe|
       # data.each { |x,y| pipe << "#{x}=#{y}\n" }
        #pipe.close_write
       
      end
    end

    def self.from_hash(hs)
      return self.new hs
    end

    def get_encrypted_text(values)
    signed = OpenSSL::PKCS7::sign(OpenSSL::X509::Certificate.new(APP_CERT_PEM),        OpenSSL::PKey::RSA.new(APP_KEY_PEM, ''), data.map { |k, v| "#{k}=#{v}" }.join("\n"), [], OpenSSL::PKCS7::BINARY)
    OpenSSL::PKCS7::encrypt([OpenSSL::X509::Certificate.new(PAYPAL_CERT_PEM)], signed.to_der, OpenSSL::Cipher::Cipher::new("DES3"),        OpenSSL::PKCS7::BINARY).to_s.gsub("\n", "")
    end

    def testfun
	return "test"
    end
  end #end button
end #end module
