class SitesController < ApplicationController

  def index
    sql = "SELECT sites.url, emails.email  FROM sites LEFT JOIN emails ON emails.site_id = sites.id WHERE sites.id IN (SELECT a.site_id FROM (SELECT site_id, count(*) FROM emails GROUP BY site_id HAVING count(*) = 3) as a)"

    @sites = Site.connection.execute(sql).values
  end
end
