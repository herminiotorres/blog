defmodule HerminioTorresWeb.Live.BlogShow do
  use HerminioTorresWeb, :live_view

  def mount(%{"id" => id, "preview" => "true"}, _session, socket) do
    id
    |> HerminioTorres.Blog.get_post_preview_by_id!()
    |> show(socket)
  end

  def mount(%{"id" => id}, _session, socket) do
    id
    |> HerminioTorres.Blog.get_post_by_id!()
    |> show(socket)
  end

  def show(post, socket) do
    relevant =
      post.tags
      |> Enum.shuffle()
      |> List.first()
      |> HerminioTorres.Blog.get_posts_by_tag!()
      |> Enum.reject(&(&1.id == post.id))
      |> Enum.shuffle()
      |> Enum.take(2)

    socket = socket |> assign(:post, post) |> track_users()

    {:ok,
     socket
     |> assign(:live_seo, true)
     |> assign(:relevant_posts, relevant)
     |> assign(:page_title, post.title), temporary_assigns: [relevant_posts: [], post: nil]}
  end

  defp track_users(socket) do
    topic = "blogpost:#{socket.assigns.post.id}"
    readers = topic |> HerminioTorresWeb.Presence.list() |> map_size()

    if connected?(socket) do
      HerminioTorresWeb.Endpoint.subscribe(topic)
      HerminioTorresWeb.Presence.track(self(), topic, socket.id, %{id: socket.id})
    end

    assign(socket, :readers, readers)
  end

  def handle_info(
        %{event: "presence_diff", payload: %{joins: joins, leaves: leaves}},
        %{assigns: %{readers: count}} = socket
      ) do
    readers = count + map_size(joins) - map_size(leaves)
    {:noreply, assign(socket, :readers, readers)}
  end
end
