defmodule Metex do
  @moduledoc """
  Documentation for Metex.
  """
  def temperatures_of(cities) do
    coordinator_pid =
      spawn(Metex.Coordinator, :loop_de_loop, [[], Enum.count(cities)])

    cities |> Enum.each(fn city ->
      worker_pid = spawn(Metex.Worker, :loop_de_loop, [])
      send worker_pid, {coordinator_pid, city}
    end)
  end
end
