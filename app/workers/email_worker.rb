class EmailWorker
  include Sidekiq::Worker

  sidekiq_options failures: true, retry: 1, queue: :emails

  def perform(site_id, url)
    site = Site.find site_id

    doc = Nokogiri::HTML(open(url))

    email_address = doc.text.match(/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i).to_a

    email_address.each do |email|
      site.emails.where(email: email).first_or_create
    end
  rescue => e
    #do nothing  
  end
end
