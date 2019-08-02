class Search
  attr_accessor :full_name, :description, :star_count, :amount_of_forks, :author_name

  QUANTITY_PER_PAGE = 15

  def initialize(item)
    @full_name = item["full_name"]
    @description = item["description"]
    @star_count = count item["stargazers_url"]
    @amount_of_forks = count item["forks_url"]
    @author_name = item["owner"]["login"]
  end

  # https://developer.github.com/v3/repos/#list-all-public-repositories
  def self.repositories oauth_token, next_id
    if next_id.nil?
      next_id = 0
    end

    self.pagination HTTParty.get("https://api.github.com/repositories?since=#{next_id}",
                                 {headers: {
                                     "User-Agent" => "Httparty",
                                     "Content-Type" => "application/json",
                                     "Authorization" => "token #{oauth_token}"}
                                 })
  end

  private

  def self.pagination response
    list = []
    next_id = 0
    response.each_with_index do |item, index|
      return list, next_id unless (index + 1) != QUANTITY_PER_PAGE
      list << Search.new(item)
      next_id = item["id"]
    end
  end

  def count url
    response = HTTParty.get(url)
    response.length
  end
end
