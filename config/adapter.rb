CLIENT_ID = "PhbL8wqAysBKULlTiPkSug"
CLIENT_SECRET = "OEIwjTbMR5OiBHjslEKHRYgsuGg8hc4SXum0TQUjCYPlFbgEMuDiy3zo0N8A6ZiL"


API_HOST = "https://api.yelp.com"
SEARCH_PATH = "/v3/businesses/search"
BUSINESS_PATH = "/v3/businesses/"
TOKEN_PATH = "/oauth2/token"
GRANT_TYPE = "client_credentials"


DEFAULT_BUSINESS_ID = "yelp-san-francisco"
DEFAULT_TERM = "lunch"
DEFAULT_LOCATION = "11 Broadway #260, New York, NY 10004"
DEFAULT_RADIUS = 1000
SEARCH_LIMIT = 10


def bearer_token
  # Put the url together
  url = "#{API_HOST}#{TOKEN_PATH}"

  raise "Please set your CLIENT_ID" if CLIENT_ID.nil?
  raise "Please set your CLIENT_SECRET" if CLIENT_SECRET.nil?

  # Build our params hash
  params = {
    client_id: CLIENT_ID,
    client_secret: CLIENT_SECRET,
    grant_type: GRANT_TYPE
  }

  response = HTTP.post(url, params: params)
  parsed = response.parse

  "#{parsed['token_type']} #{parsed['access_token']}"
end

def search(term, location, radius, sort_by = "rating")
  url = "#{API_HOST}#{SEARCH_PATH}"
  params = {
    term: term,
    location: location,
    limit: SEARCH_LIMIT,
    radius: radius,
    sort_by: "rating"
  }

  response = HTTP.auth(bearer_token).get(url, params: params)
  response.parse
end
