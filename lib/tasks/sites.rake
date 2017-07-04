namespace :sites do
  task import: :environment do
    Rails.root.join('db', 'sites.txt').read.each_line do |url|
      Site.where(url: url).first_or_create! if url.present?
    end
  end

  task export: :environment do
    n = 3
    open(Rails.root.join("#{n}.txt"), 'w') do |f|
      sql = "SELECT sites.url, emails.email  FROM sites LEFT JOIN emails ON emails.site_id = sites.id WHERE sites.id IN (SELECT a.site_id FROM (SELECT site_id, count(*) FROM emails GROUP BY site_id HAVING count(*) = #{n}) as a)"

      Site.connection.execute(sql).values.each do |(url, email)|
        f.puts "#{email.strip}, #{url.strip}"
      end
    end
  end
end
