defmodule Podium do
  @moduledoc """
  See README for information on the project.
  """

  alias Podium.Order

  @base_url "https://www.dealerrater.com/dealer"
  @path "/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-dealer-reviews-23685/page"
  @url @base_url <> @path

  # This query string ensures that only 5 star reviews are included in the scrape.
  @only_positive "?filter=ONLY_POSITIVE#link"

  @doc """
  By default, scrapes the first 5 pages of @url and returns the 3 most positive reviews.
  """
  def get_reviews(page_range \\ 1..5, num_reviews \\ 3) do
    page_range
    |> Enum.map(&get_html/1)
    |> Enum.map(&extract_review_data/1)
    |> List.flatten()
    |> Order.order_by_most_positive()
    |> Enum.take(num_reviews)
  end

  @doc """
  For a given page of results, makes the request and returns the raw HTML string body.
  """
  def get_html(page_num) do
    (@url <> to_string(page_num) <> @only_positive)
    |> HTTPoison.get!()
    |> Map.get(:body)
  end

  @doc """
  Puts together a list of maps of the various pieces of data important to the review.
  """
  def extract_review_data(html) do
    for entry <- Floki.find(html, ".review-entry") do
      date = date_from_entry(entry)
      review = review_from_entry(entry)
      "- " <> customer = customer_from_entry(entry)

      %{date: date, review: review, customer: customer}
    end
  end

  defp date_from_entry(entry) do
    entry
    |> Floki.find(".review-date")
    |> Floki.find("div .italic")
    |> Floki.text()
  end

  defp review_from_entry(entry) do
    entry
    |> Floki.find(".review-content")
    |> Floki.text()
  end

  defp customer_from_entry(entry) do
    entry
    |> Floki.find(".review-wrapper")
    |> Floki.find(".margin-bottom-sm")
    |> Floki.find("span")
    |> Floki.text()
  end
end
