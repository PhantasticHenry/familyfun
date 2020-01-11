class Familyfun::Event

    attr_accessor :name, :date, :location, :url, :details

    @@all = []

    def initialize
        save
    end

    def self.all
        @@all
    end

    def save
        self.class.all << self
    end
end