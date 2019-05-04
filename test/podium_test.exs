defmodule PodiumTest do
  use ExUnit.Case, async: true

  setup_all do
    # Read the test HTML file into a variable
    html = File.read!("test/fixtures/html.txt")

    # Make the variable available in test context
    %{html: html}
  end

  describe "Podium.get_reviews/0" do
    @tag :integration
    test "returns 3 well formed reviews maps" do
      reviews = Podium.get_reviews()

      assert length(reviews) == 3

      for review <- reviews do
        assert Map.has_key?(review, :review) == true
        assert Map.has_key?(review, :customer) == true
        assert Map.has_key?(review, :date) == true

        assert is_nil(review.review) == false
        assert is_nil(review.customer) == false
        assert is_nil(review.date) == false
      end
    end
  end

  describe "Podium.get_html/1" do
    @tag :integration
    test "gets a string with an html declaration" do
      html = Podium.get_html(1)

      assert is_binary(html) == true
      assert String.contains?(html, "<!DOCTYPE html>") == true
    end
  end

  describe "Podium.extract_review_data/1" do
    test "finds the appropriate data", context do
      reviews = Podium.extract_review_data(context.html)

      assert length(reviews) == 10

      for review <- reviews do
        assert Map.has_key?(review, :review) == true
        assert Map.has_key?(review, :customer) == true
        assert Map.has_key?(review, :date) == true

        assert is_nil(review.review) == false
        assert is_nil(review.customer) == false
        assert is_nil(review.date) == false
      end
    end
  end
end
