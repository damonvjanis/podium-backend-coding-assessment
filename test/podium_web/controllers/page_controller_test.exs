defmodule PodiumWeb.PageControllerTest do
  use PodiumWeb.ConnCase

  @tag :integration
  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Reviews"
  end
end
