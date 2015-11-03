class OrisMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.oris_mailer.contact_message_request.subject
  #
  def contact_message_request
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.oris_mailer.subscription_request.subject
  #
  def subscription_request
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.oris_mailer.order_service_request.subject
  #
  def order_service_request
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.oris_mailer.vacancy_request.subject
  #
  def vacancy_request
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
