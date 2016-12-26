defmodule PhoenixChina.NotificationController do
  use PhoenixChina.Web, :controller

  alias PhoenixChina.{Notification}

  import PhoenixChina.Ecto.Helpers, only: [update_field: 3]

  plug Guardian.Plug.EnsureAuthenticated, [handler: PhoenixChina.Guardian.ErrorHandler]

  def index(conn, params) do
    current_user = conn.assigns[:current_user]
    |> update_field(:unread_notifications_count, 0)

    pagination = Notification
    |> where(user_id: ^current_user.id)
    |> order_by([desc: :inserted_at])
    |> Repo.paginate(params)

    conn
    |> assign(:title, "消息")
    |> assign(:pagination, pagination)
    |> render("index.html")
  end
end
