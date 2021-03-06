defmodule BankingChallengeWeb.TransactionController do
  @moduledoc """
  Actions related to the transactions resource.
  """
  use BankingChallengeWeb, :controller

#  alias BankingChallenge.Accounts.Account
  alias BankingChallenge.Transactions.Transaction

  action_fallback BankingChallengeWeb.FallbackController


  @doc """
  Send the money to other account
  """
  def send(conn, params) do
    #IO.inspect(params, label: "Send")

    params
    |> Transaction.send_to_other_account()
    |> handle_response1(conn)
    #with {:ok, transaction} <- Transaction.send_to_other_account(params) do
    #  send_json(conn, 200, transaction)
    #else
    #  {:error, :not_found} ->
    #     msg = %{ type: "invalid action", description: "error"}
    #     send_json(conn, 412, msg)
    #end
  end

 #  def all(conn, params) do
 #      with {:ok, Transaction} <- Transaction.fetch(params) do
 #        send_json(conn, 200, Transaction)
 #      else
 #        {:error, :not_found} ->
 #           msg = %{ type: "not found", description: "error"}
 #           send_json(conn, 412, msg)
 #      end
 #  end

  @doc """
  Withdraw money to self account
  """
  def withdraw(conn, params) do
    #IO.inspect(params, label: "withdraw")

    params
    |> Transaction.withdraw_to_account()
    |> handle_response2(conn)

    #with {:ok, transaction}  <- Transaction.withdraw_to_account(params) do
    #  send_json(conn, 200, transaction)
    #else
    #  {:error, :not_found} ->
    #     msg = %{ type: "invalid action", description: "error"}
    #     send_json(conn, 412, msg)
    #end
  end

  #defp send_json(conn, status, body) do
  #  conn
  #  |> put_resp_header("content-type", "application/json")
  #  |> send_resp(status, Jason.encode!(body))
  #end

  defp handle_response1({:ok, transaction}, conn) do
    conn
    |> put_status(:ok)
    |> render("transaction.json", transaction: transaction)
  end

  defp handle_response1({:error, _result} = error, _conn), do: error


  defp handle_response2({:ok, transaction}, conn) do
    conn
    |> put_status(:ok)
    |> render("withdraw.json", transaction: transaction)
  end

  defp handle_response2({:error, _result} = error, _conn), do: error


end
