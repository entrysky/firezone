defmodule FzHttpWeb.DeviceLive.Admin.Index do
  @moduledoc """
  Handles Device LiveViews.
  """
  use FzHttpWeb, :live_view
  alias FzHttp.{Devices, Repo}

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    devices =
      Devices.list_devices()
      |> Repo.preload(:user)
      |> Enum.sort_by(& &1.user_id)

    {:ok,
     socket
     |> assign(:devices, devices)
     |> assign(:page_title, "All Devices")}
  end

  @doc """
  Needed because this view will receive handle_params when modal is closed.
  """
  @impl Phoenix.LiveView
  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end
end
