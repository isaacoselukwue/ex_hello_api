defmodule HelloApi.RouterTest do
  use ExUnit.Case, async: true
  import Plug.Test
  # import Plug.Conn


  alias HelloApi.Router

  @opts Router.init([])

  test "GET unknown route returns 404" do
    conn = conn(:get, "/unknown")
    conn = Router.call(conn, @opts)

    assert conn.status == 404
  end

  test "GET / returns JSON with date, time, and random number" do
    conn = conn(:get, "/")
    conn = Router.call(conn, @opts)

    assert conn.status == 200

    {:ok, json_response} = Jason.decode(conn.resp_body)

    assert Map.has_key?(json_response, "date")
    assert Map.has_key?(json_response, "time")
    assert Map.has_key?(json_response, "random")

    assert json_response["random"] >= 1 and json_response["random"] <= 100
  end

end
