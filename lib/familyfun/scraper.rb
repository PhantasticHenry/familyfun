class Familyfun::Scraper

    def self.scrape_events
        doc = Nokogiri::HTML(open("https://www.parentmap.com/calendar"))
        events = doc.search("div.col-content")
        events.each do |e|
            event = Familyfun::Event.new
            event.name = e.search("h3.event-title").text.strip
            event.date = e.search("h4.event-date").text.strip.gsub(/[[:space:]]/, ' ').split(" ").join(" ")
            event.location = e.search("h5.event-location").text.gsub(/[[:space:]]/, ' ').split(" ").join(" ")
            event.url = "https://www.parentmap.com" + (e.search("a").attr("href").text)
            event.details = []
                
                website = Nokogiri::HTML(open("https://www.parentmap.com" + (e.search("a").attr("href").text)))
                event.details << website.search("div.body p").text
                event.details << ("Cost: " + website.css("div.field_event_cost").text) unless (website.css("div.field_event_cost").text == "")
                event.details << website.css("div.field_age_recommendation").text
                event.details << "Address: " + website.css("p.address").text.split.join(" ")
        end
    end
end