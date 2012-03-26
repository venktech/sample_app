class PagesController < ApplicationController

  require 'crypto42'


PAYPAL_CERT_PEM = File.read("#{Rails.root}/paypal/paypal_cert_pem.pem")
APP_CERT_PEM = File.read("#{Rails.root}/paypal/my-pubcert.pem")
APP_KEY_PEM = File.read("#{Rails.root}/paypal/my-prvkey.pem")



def temp

decrypted = {
      "cert_id" => "23YKTMPQN3J7S",
      "cmd" => "_xclick",
      "business" => "venkte_1331656958_biz@gmail.com",
      "item_name" => "FWJ - 1 Credit",
      "item_number" => "1",
      "custom" =>"something to pass to IPN",
      "amount" => "75",
      "currency_code" => "USD",
      "country" => "US",
      "no_note" => "1",
      "no_shipping" => "1",
    }

signed=OpenSSL::PKCS7::sign(OpenSSL::X509::Certificate.new(APP_CERT_PEM),        OpenSSL::PKey::RSA.new(APP_KEY_PEM, ''), decrypted.map { |k, v| "#{k}=#{v}" }.join("\n"), [], OpenSSL::PKCS7::BINARY)
    OpenSSL::PKCS7::encrypt([OpenSSL::X509::Certificate.new(PAYPAL_CERT_PEM)], signed.to_der, OpenSSL::Cipher::Cipher::new("DES3"),        OpenSSL::PKCS7::BINARY).to_s.gsub("\n", "")

end

   def home
 @encrypted_basic = temp

    @title = "Home"
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end
  
  def help
  @title = "Help"
  end
end
