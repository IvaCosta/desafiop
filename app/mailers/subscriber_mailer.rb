class SubscriberMailer

def send_email(subscribers, subject, text)
  RestClient.post "https://api:key-fb6959b8d265475d06d96f139262b1ef"\
   "@api.mailgun.net/v3/sandbox77d066d127a84a72a0727f80a75b1d76.mailgun.org/messages",
   :from => "Excited User <mailgun@sandbox77d066d127a84a72a0727f80a75b1d76.mailgun.org>",
   :to => subscribers.email,
   :subject => subject,
   :text => text
 end
 end
