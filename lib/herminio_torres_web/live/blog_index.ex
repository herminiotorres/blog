defmodule HerminioTorresWeb.Live.BlogIndex do
  use HerminioTorresWeb, :live_view

  @page_title "Blog"

  def mount(_params, _session, socket) do
    posts = HerminioTorres.Blog.published_posts()

    {:ok,
     socket
     |> assign(:posts, posts)
     |> assign(:page_title, @page_title), temporary_assigns: [posts: []]}
  end
end
