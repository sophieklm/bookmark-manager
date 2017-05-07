require 'mailgun'
require 'envyable'
Envyable.load('./config/env.yml', 'development')

class SendRecoverLink

 def initialize(mailer: nil)
   @mailer = mailer || Mailgun::Client.new(ENV["api-key"])
 end

 def self.call(user, mailer = nil)
   new(mailer: mailer).call(user)
 end

 def call(user)
   mailer.send_message(ENV["mailgun_domain"], {from: "bookmarkmanager@mail.com",
       to: user.email,
       subject: "reset your password",
       text: "use this link to reset your password http://chitter-challenge-sophieklm.herokuapp.com/reset_password?token=#{user.password_token}"})
 end

 private
 attr_reader :mailer
end
