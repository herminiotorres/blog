defmodule HerminioTorresWeb.Live.BlogIndex do
  use HerminioTorresWeb, :live_view

  def mount(_params, _session, socket) do
    posts = HerminioTorres.Blog.published_posts()

    {:ok,
     socket
     |> assign(:posts, posts)
     |> assign(:page_title, "Blog"), temporary_assigns: [posts: []]}
  end
end
