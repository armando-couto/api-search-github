class Search
  attr_accessor :full_name, :description, :star_count, :amount_of_forks, :author_name

  QUANTITY_PER_PAGE = 15

  def initialize(full_name, description, star_count, amount_of_forks, author_name)
    @full_name = full_name
    @description = description
    @star_count = star_count
    @amount_of_forks = amount_of_forks
    @author_name = author_name
  end

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

  def self.search_repositories oauth_token, params
    language = params["language"]
    if language.nil? || language == ""
      language = "ruby"
    end

    sort = params["sort"]
    if sort.nil? || sort == ""
      sort = "created"
    end

    order = params["order"]
    if order.nil? || order == ""
      order = "asc"
    end

    self.pagination_struct_items HTTParty.get("https://api.github.com/search/repositories?q=#{params["query"]}+language:#{language};page=#{params["page"]}&sort=#{sort}&order=#{order}",
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
      list << Search.new(item["full_name"], item["description"], count(item["stargazers_url"]), count(item["forks_url"]), item["owner"]["login"])
      next_id = item["id"]
    end
  end

  def self.pagination_struct_items response
    list = []
    response["items"].each_with_index do |item, index|
      return list, pagination_link(response) unless (index + 1) != QUANTITY_PER_PAGE
      list << Search.new(item["full_name"], item["description"], item["stargazers_count"], item["forks_count"], item["owner"]["login"])
    end
  end

  def count url
    response = HTTParty.get(url)
    response.length
  end

  def self.pagination_link response
    next_page = 0
    prev_page = 0
    last_page = 0
    first_page = 0

    response.headers["link"].split(",").each do |s|
      type = s.split(";")[1].split("rel=\"")[1].split("\"")
      case type[0]
      when "next"
        next_page = s.split(";")[0].split("page=")[1][/\d+/].to_i
      when "prev"
        prev_page = s.split(";")[0].split("page=")[1][/\d+/].to_i
      when "last"
        last_page = s.split(";")[0].split("page=")[1][/\d+/].to_i
      when "first"
        first_page = s.split(";")[0].split("page=")[1][/\d+/].to_i
      end
    end
    return {next_page: next_page, prev_page: prev_page, last_page: last_page, first_page: first_page}
  end
end
