# Podium Backend Coding Assessment

## Easy online visual
I've added Phoenix and deployed to Heroku for a quick visual of the top three most positive reviews without having to compile and run the program: https://damon-podium.herokuapp.com

## Instructions for running the program

1. Download or clone the git repo from [GitHub](https://github.com/podium-eng-recruiting/backend-coding-assessment-damonvjanis-1298)
   
2. Make sure Elixir >= 1.8.0 is installed on your computer

3. Change into the directory of the project

4. Run `mix deps.get` to get the dependencies
   
5. Run the following:

```
$ mix scrape
```

To run the test suite, run the following in the project directory:

```
$ mix test
```

To run the tests as well as integration tests that actually hit the website, run:

```
$ mix test --include integration
```

## Libraries

The program depends on several open-source libraries and their dependencies, please see `mix.exs` and `mix.lock` for a full list. Since they're all imported from the Hex package manager their respective licenses can be found on [hex.pm](hex.pm)

## Methodology

I've chosen to identify the "most overly positive" reviews by utilizing a point system with these criteria:

1. Each exclamation mark in the review is worth a point.
2. Each word in all caps more than one letter long (to avoid "I"), is worth 1 point.
3. Every word in the review matching an arbitrary list of common "positive" words is worth one point. The full list can be found in a module attribute "constant" in `lib/order.ex`.
4. The total score is then divided by the number of characters in the review, so that more concentrated occurances of the positivity indicators will result in a higher overall ranking.

## Testing

Since this is a simple app, I wanted the test suite to reflect that. Pre-mature optimization in testing can increase the overhead of code changes in the future, and so it's important to keep the test suite clean and purposeful, and matching the level of optimization in the codebase. I intentially kept some repetition in the tests instead of moving it all into the `setup_all` block (or even moving it into more granular `setup` blocks), and I probably wouldn't refactor until there were some changes and there were more tests being added with the same repetition. 

I've avoided directly or indirectly testing HTTPoison and Floki, because from a testing perspective it doesn't matter *how* they're getting or transforming data, and I don't want to couple my tests to the specific library or implementation.

In the case of HTTPoison, the important thing is that the raw HTML body can be returned as a string by whatever HTTP client is serving the data, and the integration tests shouldn't fail as long as that behavior stays consistent.

In the case of Floki, most of the functions using the library to transform data are private because they're limited in scope and are tightly coupled to the API of the library itself. The important thing is testing the parent function, which has the responsibility of taking a raw HTML body and outputting a list of maps representing reviews. As long as the input and output are the same, the function (and the private functions it depends on) could easily use a different library or API and the tests would still pass.

Because of the small scale of the application, the integration tests actually call the website, and the other tests use a fixture that is a snapshot of a single page of reviews results.