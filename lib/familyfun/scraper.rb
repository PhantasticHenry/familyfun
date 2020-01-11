class Familyfun::Scraper

    @@user_input = 1
    def self.scrape_events
        doc = Nokogiri::HTML(open("https://www.parentmap.com/calendar"))
        events = doc.search("div.col-content")
        events.each do |e|
            event = Familyfun::Event.new
            event.name = e.search("h3.event-title").text.strip
            event.date = e.search("h4.event-date").text.strip.gsub(/[[:space:]]/, ' ').split(" ").join(" ")
            event.location = e.search("h5.event-location").text.gsub(/[[:space:]]/, ' ').split(" ").join(" ")
            event.url = "https://www.parentmap.com" + (e.search("a").attr("href").text)
            event.details = self.scrape_details
        end
    end

    def self.scrape_details
        website = Nokogiri::HTML(open("https://www.parentmap.com/calendar/oly-ice-seasonal-skating"))
        event_details = website.css("div.body p").text
    end

end