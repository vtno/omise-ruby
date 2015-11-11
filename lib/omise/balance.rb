require "omise/object"

module Omise
  # Balance allows you to retrieve an Omise balance. Note that the `/balance`
  # endpoint is a singleton resource. But this class isn't a singleton and each 
  # balance object that you fetch will have it's own object_id.
  #
  # Example:
  #
  #     Omise.api_key = OMISE_API_KEY
  #     account = Omise::Balance.retrieve
  #
  # Alternatively if you have mutliple accounts you can retrieve each balance
  # separately by passing the `key:` option to retrieve all of them.
  #
  #     balances = accounts.map do |account|
  #       begin
  #         account = Omise::Balance.retrieve(key: account.key)
  #       rescue Omise::Error => e
  #         # deal with exception accordingly
  #         nil
  #       end
  #     end.compact
  #
  class Balance < OmiseObject
    self.endpoint = "/balance"
    singleton!
  end
end
