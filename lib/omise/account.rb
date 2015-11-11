require "omise/object"

module Omise
  # `Account` allows you to retrieve an Omise account. Note that the `/account`
  # endpoint is a singleton resource. But this class isn't a singleton and each 
  # account object that you fetch will have it's own object_id.
  #
  # Example:
  #
  #     Omise.api_key = OMISE_API_KEY
  #     account = Omise::Account.retrieve
  #
  # Alternatively if you have mutliple accounts you can retrieve all of them
  # separately by passing the `key:` option:
  #
  #     accounts = account.map do |account|
  #       begin
  #         account = Omise::Account.retrieve(key:account account.key)
  #       rescue Omise::Error => e
  #         # deal with exception accordingly
  #         nil
  #       end
  #     end.compact
  #
  class Account < OmiseObject
    self.endpoint = "/account"
    singleton!
  end
end
