require "omise/list"
require "omise/card"
require "omise/token"

module Omise
  # CardList represents a list of cards. It inherits from Omise::List. This
  # class exposes additional methods to help work with customer's cards.
  #
  # Example:
  #
  #     # In your controller:
  #     @customer = Omise::Customer.retrieve(user.id)
  #     @cards = @customer.cards
  #
  #     # In your view:
  #     <% @cards.each do |card| %>
  #       <%= card.last_digits %>
  #     <% end %>
  #
  class CardList < List
    def initialize(customer, attributes = {})
      super(attributes)
      @customer = customer
    end

    # Retrieves a card object that belongs to the customer object that
    # initially fetched the list. Calling this method will issue a single HTTP
    # request:
    #
    #   - GET https://api.omise.co/customers/CUSTOMER_ID/cards/CARD_ID
    #
    # Example:
    #
    #     customer = Omise::Customer.retrieve(customer_id)
    #     card = customer.cards.retrieve(card_id)
    #
    # Note that it's probably easier to iterate over all the cards instead since
    # the request to retrieve a customer will already hold a list of cards.
    #
    # Returns a new `Omise::Card` instance if successful and raises an
    # `Omise::Error` if the request fails.
    #
    def retrieve(id, attributes = {})
      Card.new self.class.resource(location(id), attributes).get(attributes)
    end

    # Creates a card object that will belong to the customer object that
    # initially fetched the list. Calling this method will issue three
    # HTTP requests:
    #
    #   - POST https://vault.omise.co/tokens
    #   - PATCH https://api.omise.co/customers/CUSTOMER_ID
    #   - GET https://api.omise.co/customers/CUSTOMER_ID/cards/CARD_ID
    #
    # Note that in order to call this method you need `Omise.vault_key` to be
    # set with your Omise public key. You can find this key in Omise Dashboard.
    #
    # Example:
    #
    #     customer = Omise::Customer.retrieve(customer_id)
    #     card = customer.cards.create(omise_card_attributes)
    #
    # Returns a new `Omise::Card` instance if successful and raises an
    # `Omise::Error` if one of the requests fails.
    #
    def create(attributes = {})
      token = Token.create(card: attributes)
      @customer.update(card: token.id)
      retrieve(token.card.id)
    end
  end
end
