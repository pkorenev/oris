class MailchimpController < ApplicationController
  def subscribe
    list_name = "main"
    list_id = "44da42d038"
    mailchimp = Mailchimp::API.new(MAILCHIMP_API_KEY)
    mailchimp.lists.subscribe(list_id,
                              { "email" => params[:email]
                                #"euid" => "123",
                                #"leid" => "123123"
                              })

    redirect_to root_path, notice: "Вы успешно подписались на рассылку. Проверьте почту. Вам необходимо подтвердить подписку."
  end
end