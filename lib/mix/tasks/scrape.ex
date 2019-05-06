defmodule Mix.Tasks.Scrape do
  use Mix.Task

  @shortdoc "Runs the program"

  @impl Mix.Task
  def run(_) do
    Mix.Task.run("app.start")

    # Get the reviews
    reviews = Podium.get_reviews()

    # Print the header
    IO.puts("\nMost positive reviews (in order):")
    IO.puts("\n------------------\n")

    # For each review, print out its rank and information
    reviews
    |> Enum.with_index(1)
    |> Enum.each(fn {review, index} ->
      IO.puts("##{index} most positive review:\n")
      IO.puts("Date: #{review.date} | Customer: #{review.customer}\n")
      IO.puts("Review: #{review.review}\n")
      IO.puts("------------------\n")
    end)
  end
end
