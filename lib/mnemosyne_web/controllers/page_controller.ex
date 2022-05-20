defmodule MnemosyneWeb.PageController do
  use MnemosyneWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def api_test(conn, %{"id" => id}) do
    :timer.sleep(2000)
    json conn, %{res: "I am #{id}"}
  end

end
