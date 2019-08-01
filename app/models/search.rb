class Search
  attr_accessor :full_name, :description, :star_count, :amount_of_forks, :author_name

  def initialize(item)
    @full_name = item["full_name"]
    @description = item["description"]
    @star_count = count item["stargazers_url"]
    @amount_of_forks = count item["forks_url"]
    @author_name = item["owner"]["login"]
  end

  def self.repositories
    response = HTTParty.get("https://api.github.com/repositories",
                            {headers: {
                                "User-Agent" => "Httparty",
                                "Content-Type" => "application/json",
                                "Authorization" => "token b0d0bc7366b3632e3a18f410a7625f8cead8cdf9"}
                            })
    list = []
    response.each do |item|
      ## TODO Limit per page 15
      list << Search.new(item)
    end
    list
  end

  private

  def count url
    response = HTTParty.get(url)
    response.length
  end
end
