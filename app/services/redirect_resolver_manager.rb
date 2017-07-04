require 'uri'
require 'net/http'
class RedirectResolverManager
  include ActiveModel::Validations
  MAXIMUM_URL_LENGTH = 2048
  attr_accessor :url, :input_url, :proxy

  def initialize(url)
    self.input_url = url
  end
  def resolve
    self.url = mechanize_agent().head(input_url).uri.to_s
    self.valid? ? url : input_url
  rescue Mechanize::ResponseCodeError => exception
    self.url = exception.page.uri.to_s
    return self.valid? ? url : input_url
  rescue Exception => exception
    raise exception
  end
  private

  USER_AGENT = 'Mac Safari'.freeze
   private
   def mechanize_agent(proxy = {})
     Mechanize.new do |agent|
       agent.follow_meta_refresh = true
       agent.redirect_ok         = true
       agent.user_agent_alias    = USER_AGENT
       agent.open_timeout        = 5
       agent.read_timeout        = 20
       agent.verify_mode         = OpenSSL::SSL::VERIFY_NONE
       agent.keep_alive          = false
       agent.idle_timeout        = 0
       if proxy.present?
         agent.set_proxy(proxy[:host], proxy[:port], proxy[:user], proxy[:password])
       end
     end
   end
end
