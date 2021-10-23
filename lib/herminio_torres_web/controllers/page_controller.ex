defmodule HerminioTorresWeb.PageController do
  use HerminioTorresWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
