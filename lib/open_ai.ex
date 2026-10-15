
defmodule ElixirMl.OpenAI do
  @api_url "https://api.openai.com/v1/responses"

  def ask(prompt) when is_binary(prompt) do
    with {:ok, api_key} <- get_api_key(),
         {:ok, response} <- send_request(api_key, prompt) do
      extract_text(response)
    end
  end

  defp get_api_key do
    case System.get_env("OPENAI_API_KEY") do
      key when is_binary(key) and key != "" ->
        {:ok, key}

      _ ->
        {:error, :missing_api_key}
    end
  end

  defp send_request(api_key, prompt) do
    Req.post(
      @api_url,
      headers: [
        {"authorization", "Bearer #{api_key}"}
      ],
      json: %{
        model: "gpt-4.1-mini",
        input: prompt
      },
      receive_timeout: 30_000
    )
    |> handle_response()
  end

  defp handle_response({:ok, %{status: status, body: body}})
       when status in 200..299 do
    {:ok, body}
  end

  defp handle_response({:ok, %{status: status, body: body}}) do
    {:error, {:http_error, status, body}}
  end

  defp handle_response({:error, reason}) do
    {:error, {:request_failed, reason}}
  end

  defp extract_text(%{"output" => output}) do
    text =
      for %{"type" => "message", "content" => content} <- output,
          %{"type" => "output_text", "text" => text} <- content do
        text
      end
      |> Enum.join("\n")

    if text == "" do
      {:error, :no_text_output}
    else
      {:ok, text}
    end
  end

  defp extract_text(_response) do
    {:error, :unexpected_response}
  end
end
