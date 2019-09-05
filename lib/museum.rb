class Museum

  attr_reader :name, :exhibits, :patrons

  def initialize(name)
    @name     = name
    @exhibits = []
    @patrons  = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    @exhibits.find_all do |exhibit|
      patron.interests.include?(exhibit.name)
    end

  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    output = Hash.new
    @exhibits.each do |exhibit|
      output.store(exhibit, get_patrons_with_interest_in_exhibit(exhibit))
    end
    output
  end

  #returns array of patrons
  def get_patrons_with_interest_in_exhibit(exhibit)
    @patrons.find_all do |patron|
      # require 'pry'; binding.pry
      patron.interests.include?(exhibit.name)
    end
  end

end
