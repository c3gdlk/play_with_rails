class SiteWorker
  include Sidekiq::Worker

  sidekiq_options failures: true, retry: 3, queue: :sites, backtrace: true

  def perform(site_id)
    site = Site.find site_id

    real_url = RedirectResolverManager.new("http://#{site.url}").resolve

    doc = Nokogiri::HTML(open(real_url))

    email_address = doc.text.match(/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i).to_a

    email_address.each do |email|
      site.emails.where(email: email).first_or_create
    end

    return if email_address.present?

    links = doc.css('a')
    hrefs = links.map {|link| link.attribute('href').to_s}.uniq.sort.delete_if {|href| href.empty?}.reject {|u| u.include?('#')}.map do |url|
      url.include?(site.url) ? url : "#{real_url}/#{url}"
    end

    hrefs.each do |href|
      EmailWorker.perform_async site.id, href
    end
  end
end
