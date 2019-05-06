defmodule PodiumWeb.IndexTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts PodiumWeb.Router.init([])

  describe "test web request" do
    @tag :integration
    test "returns well formatted header and table" do
      # Create a connection
      conn = conn(:get, "/")

      # Invoke the plug
      conn = PodiumWeb.Router.call(conn, @opts)

      # Assert the response and status
      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body =~ "McKaig"
      assert conn.resp_body =~ "#1"
      assert conn.resp_body =~ "#2"
      assert conn.resp_body =~ "#3"
    end
  end
end
