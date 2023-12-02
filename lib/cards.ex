defmodule Cards do
  @moduledoc """
  Provides methods for creatinga nd handeling a deck of cards.
  """

  @doc """
  Returns a list of strings representing a deck of playing cards
  """
 def create_deck do
  values = ["Ace", "Two", "Three", "Four", "Five"]
  suits = ["Spades", "Clubs", "Hearts", "Diamond"]
  # 1st method *//////
#  cards = for values <- values do
#     for suits <- suits do
#       "#{values} of #{suits}"
#     end
#   end
#   List.flatten(cards)

# 2nd method *//////
   for suits <- suits, values <- values do
      "#{values} of #{suits}"
   end
 end

 @doc """
 shuffles the card in the deck.
 """
 def shuffle(deck) do
  Enum.shuffle(deck)
 end

 @doc """
 Determines weather a deck contains a given card

 ## Examples

     iex> deck = Cards.create_deck
     iex> Cards.contains?(deck, "Ace of Hearts")
     true
 """
 def contains?(deck, card) do
   Enum.member?(deck, card)
 end

 @doc """
 Creates a hand of cards as given.

 ## Examples

     iex> deck = Cards.create_deck
     iex> {hand, deck} = Cards.deal(deck, 3)
     iex> hand
     ["Ace of Spades", "Two of Spades", "Three of Spades"]

 """
 def deal(deck, hand_size) do
   Enum.split(deck, hand_size)
 end

 def save(deck, filename) do
   binary = :erlang.term_to_binary(deck)
   File.write(filename, binary)
 end

 def load(filename) do
   {status, binary} = File.read(filename)
   case status do
     :ok -> :erlang.binary_to_term(binary)
     :error -> "The file does not exists."
   end

 end

 #  pipe operator
   def create_hand(hand_size) do
     Cards.create_deck
     |>Cards.shuffle
     |> Cards.deal(hand_size)
   end

end
