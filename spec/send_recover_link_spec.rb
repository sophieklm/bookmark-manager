require 'envyable'
Envyable.load('./config/env.yml', 'test')
require 'send_recover_link'

describe SendRecoverLink do
  let(:user) { double :user, email: "test@test.com", password_token: "12345678" }
  let(:mail_gun_client){ double :mail_gun_client }
  let(:sandbox_domain_name) { ENV["sandbox_domain_name"] }

  it "sends a message to mailgun when called" do
    params = {from: "bookmarkmanager@mail.com",
      to: user.email,
      subject: "reset your password",
      text: "use this link to reset your password http://chitter-challenge-sophieklm.herokuapp.com/reset_password?token=#{user.password_token}" }
    expect(mail_gun_client).to receive(:send_message).with(sandbox_domain_name, params)
    described_class.call(user, mail_gun_client)
  end
end
