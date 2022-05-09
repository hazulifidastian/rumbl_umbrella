defmodule InfoSys.Counter do
  def inc(pid), do: send(pid, :inc)

  def dec(pid), do: send(pid, :dec)

  def val(pid, timeout \\ 5_000) do
    ref = make_ref()
    send(pid, {:val, self(), ref})
    # waiting response
    receive do
      {^ref, val} -> val
    after
      timeout -> exit(:timeout)
    end
  end

  def start_link(initial_val) do
    {:ok, spawn_link(fn -> listen(initial_val) end)}
  end

  defp listen(val) do
    # val adalah state
    receive do
      :inc ->
        # state berubah
        listen(val + 1)

      :dec ->
        # state berubah
        listen(val - 1)

      {:val, sender, ref} ->
        send(sender, {ref, val})
        # state tetap
        listen(val)
    end
  end
end