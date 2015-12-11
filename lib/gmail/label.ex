defmodule Gmail.Label do

  import Gmail.Base

  @moduledoc"""
  Labels are used to categorize messages and threads within the user's mailbox.
  """

  @doc """
  > Gmail API documentation: https://developers.google.com/gmail/api/v1/reference/users/labels#resource
  """
  defstruct id: "",
    name: "",
    messageListVisibility: "",
    labelListVisibility: "",
    type: "",
    messagesTotal: "",
    messagesUnread: "",
    threadsTotal: "",
    threadsUnread: ""

  @type t :: %__MODULE__{}

  @doc """
  Gets the specified label.

  > Gmail API documentation: https://developers.google.com/gmail/api/v1/reference/users/labels/get
  """
  @spec get(String.t) :: Gmail.Label.t
  def get(id), do: get("me", id)

  @doc """
  Gets the specified label.

  > Gmail API documentation: https://developers.google.com/gmail/api/v1/reference/users/labels/get
  """
  @spec get(String.t, String.t) :: Gmail.Label.t
  def get(user_id, id) do
    case do_get("users/#{user_id}/labels/#{id}") do
      {:ok, %{"error" => %{"code" => 404}}} ->
        :not_found
      {:ok, %{"error" => %{"code" => 400, "errors" => errors}}} ->
        [%{"message" => error_message}|_rest] = errors
        {:error, error_message}
      {:ok, %{"error" => details}} ->
        {:error, details}
      {:error, details} ->
        {:error, details}
      {:ok, raw_label} ->
        {:ok, convert(raw_label)}
    end
  end

  @doc """
  Lists all labels in the user's mailbox.

  > Gmail API Documentation: https://developers.google.com/gmail/api/v1/reference/users/labels/list
  """
  @spec list(String.t) :: {:ok, [Gmail.Label.t]}
  def list(user_id  \\ "me") do
    case do_get("users/#{user_id}/labels") do
      {:ok, %{"error" => details}} ->
        {:error, details}
      {:ok, %{"labels" => raw_labels}} ->
        {:ok, Enum.map(raw_labels, &convert/1)}
    end
  end

  @doc """
  Converts a Gmail API label resource into a local struct
  """
  @spec convert(Map.t) :: Gmail.Label.t
  defp convert(%{"id" => id,
    "name" => name,
    "type" => type}) do
    %Gmail.Label{id: id, name: name, type: type}
  end

end