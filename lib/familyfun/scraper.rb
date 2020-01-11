class Familyfun::Scraper

    # def self.scrape_all_events
    #     all_events = []
    #     all_events << self.scrape_events
    # end

    def self.scrape_events
        doc = Nokogiri::HTML(open("https://www.parentmap.com/calendar"))
        events = doc.search("div.col-content")
        events.each do |e|
            event = Familyfun::Event.new
            event.name = e.search("h3.event-title").text.strip
            event.date = e.search("h4.event-date").text.strip.gsub(/[[:space:]]/, ' ').split(" ").join(" ")
            event.location = e.search("h5.event-location").text.gsub(/[[:space:]]/, ' ').split(" ").join(" ")
            event.url = "https://www.parentmap.com/calendar" + (e.search("a").attr("href").text)
        end
        
    end
end