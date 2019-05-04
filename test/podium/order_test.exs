defmodule Podium.OrderTest do
  use ExUnit.Case, async: true

  alias Podium.Order

  setup_all do
    # Read the test HTML file into a variable
    html = File.read!("test/fixtures/html.txt")

    # Make the variable available in test context
    %{html: html}
  end

  describe "Order.get_positivity_score/1" do
    test "gets the right score for a review", context do
      review = context.html |> Podium.extract_review_data() |> List.first()

      length = String.length(review.review)
      {score, _review} = Order.get_positivity_score(review)

      assert score == 0.01675977653631285
      assert score * length == 3
    end

    test "returns the same review", context do
      review_before = context.html |> Podium.extract_review_data() |> List.first()

      {_score, review_after} = Order.get_positivity_score(review_before)

      assert review_before == review_after
    end
  end

  describe "Order.order_by_most_positive/1" do
    test "first review after ordering is correct", context do
      reviews = Podium.extract_review_data(context.html)

      ordered = Order.order_by_most_positive(reviews)

      most_positive = List.first(ordered)

      assert most_positive.customer == "MsSharon"
      assert most_positive.date == "April 23, 2019"
      assert String.contains?(most_positive.review, "!!!!!!!!") == true
    end

    test "second review after ordering is correct", context do
      reviews = Podium.extract_review_data(context.html)

      ordered = Order.order_by_most_positive(reviews)

      [_ | [second_most_positive | _]] = ordered

      assert second_most_positive.customer == "DeEsta"
      assert second_most_positive.date == "April 25, 2019"
      assert String.contains?(second_most_positive.review, "NO high pressure") == true
    end
  end
end
