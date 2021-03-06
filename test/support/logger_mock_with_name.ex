defmodule LoggerMockWithName do
  @moduledoc false

  def init({__MODULE__, name}) do
    {:ok, %{:events => [], :name => name, :configure => nil}}
  end

  def handle_call({:configure, opts}, state) do
    {:ok, :ok, %{state | :configure => opts}}
  end

  def handle_call(:reset, state) do
    {:ok, :ok, %{:events => [], :name => state[:name], :configure => nil}}
  end

  def handle_call(:get_state, state) do
    {:ok, state, state}
  end

  def handle_event({level, _gl, {Logger, msg, _ts, _md}}, state) do
    {:ok, %{state | :events => state[:events] ++ [{level, msg}]}}
  end

  def handle_event(_, state) do
    {:ok, state}
  end

  def handle_info(_opts, state), do: {:ok, state}

end