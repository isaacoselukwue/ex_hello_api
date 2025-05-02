defmodule HelloApi.Router do
  use Plug.Router

  import Plug.Conn

  plug :match
  plug :dispatch

  get "/" do
    today = Date.utc_today()
    current_time = Time.utc_now()

    formatted_date = Calendar.strftime(today, "%d/%m/%Y")
    formatted_time = Calendar.strftime(current_time, "%H:%M:%S")

    random_number = :rand.uniform(100)

    response = %{
      date: formatted_date,
      time: formatted_time,
      random: random_number
    }

    json_response = Jason.encode!(response)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, json_response)
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
