# Preview all emails at http://localhost:3000/rails/mailers/oris_mailer
class OrisMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/oris_mailer/contact_message_request
  def contact_message_request
    OrisMailer.contact_message_request
  end

  # Preview this email at http://localhost:3000/rails/mailers/oris_mailer/subscription_request
  def subscription_request
    OrisMailer.subscription_request
  end

  # Preview this email at http://localhost:3000/rails/mailers/oris_mailer/order_service_request
  def order_service_request
    OrisMailer.order_service_request
  end

  # Preview this email at http://localhost:3000/rails/mailers/oris_mailer/vacancy_request
  def vacancy_request
    OrisMailer.vacancy_request
  end

end
