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
            event.details = self.scrape_details
        end
    end

    def self.scrape_details
        event_details = []
        website = Nokogiri::HTML(open("https://www.parentmap.com/calendar/oly-ice-seasonal-skating"))
        event_details << info = website.css("div.body p").text
        more_info = website.css("ul.info-list")
        more_info.each do |i|
            event_details << price = "Cost: " + i.css("div.field_event_cost").text
            event_details << rec_ages = i.css("div.field_age_recommendation").text
            event_details << address1 = "Address: " + i.css("p.address").text.split.join(" ")
        end
        event_details
        # binding.pry
    end

    # def self.scrape_free_events
    #     doc = Nokogiri::HTML(open("https://www.parentmap.com/calendar?geolocation-lat=&geolocation-lng=&geolocation_geocoder_google_geocoding_api_state=1&date=now&keys=&geolocation_geocoder_google_geocoding_api=&geolocation=5&field_event_types_value%5Bfree%5D=free"))
    #     free_events = doc.search("")
    # end

end