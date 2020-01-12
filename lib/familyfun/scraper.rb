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
            # event.details = []
                
                more_info = Nokogiri::HTML(open("https://www.parentmap.com" + (e.search("a").attr("href").text)))
                event.details = more_info.search("div.body p").text + "\n\n" + more_info.css("div.field_age_recommendation").text
                event.price = (more_info.css("div.field_event_cost").text) unless (more_info.css("div.field_event_cost").text == "")
                # event.details << more_info.css("div.field_age_recommendation").text
                event.address = more_info.css("p.address").text.split.join(" ")
        end
    end
end