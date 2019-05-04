defmodule Podium.Order do
  @moduledoc """
  See README for information on the ordering methodology.
  """

  @happy_words [
    "wow",
    "amazing",
    "nice",
    "great",
    "love",
    "super",
    "best",
    "incredible",
    "extreme",
    "happy",
    "very",
    "ever",
    "help",
    "really"
  ]

  @doc """
  Entry point. Gets the scores, sorts them and then returns the reviews in order.
  """
  def order_by_most_positive(reviews) do
    reviews
    |> Enum.map(&get_positivity_score/1)
    |> Enum.sort(&(&1 >= &2))
    |> Enum.map(fn {_score, review} -> review end)
  end

  @doc """
  Runs the review through a pipeline that increments the score and returns it with the review.
  """
  def get_positivity_score(review) do
    {0, review}
    |> add_exclamation_score()
    |> add_upcase_word_score()
    |> add_happy_word_score()
    |> divide_by_character_count()
  end

  @doc """
  Finds the number of exclamation marks in the score and adds 1 point per mark.
  """
  def add_exclamation_score({score, review}) do
    scan = Regex.scan(~r/[!]/, review.review)
    {score + length(scan), review}
  end

  @doc """
  Find the upcased letters in each word, and adds a point if a word has more than two upcase letters.
  """
  def add_upcase_word_score({score, review}) do
    words = String.split(review.review)

    count =
      for word <- words do
        trimmed = Regex.replace(~r/[^A-Z]/, word, "")
        if String.length(trimmed) > 1, do: 1, else: 0
      end
      |> Enum.sum()

    {score + count, review}
  end

  @doc """
  Adds a point for each word in the review that matches @happy_words.
  """
  def add_happy_word_score({score, review}) do
    words = String.split(review.review)

    count =
      for word <- words do
        trimmed = Regex.replace(~r/[^a-zA-Z]/, word, "")
        downcase = String.downcase(trimmed)

        if downcase in @happy_words, do: 1, else: 0
      end
      |> Enum.sum()

    {score + count, review}
  end

  @doc """
  Divides the score by the character count of the review to prompte concentrated positivity.
  """
  def divide_by_character_count({score, review}) do
    {score / String.length(review.review), review}
  end
end
