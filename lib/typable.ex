defprotocol Typable do
  @moduledoc """
  Protocol which describes type identifier of Elixir term
  """

  @fallback_to_any true
  @type t :: Typable.t()

  @doc """
  Returns module which represents type identifier of given term

  ## Examples

  ```
  iex> Typable.type_of(1)
  Integer
  iex> Typable.type_of(self())
  PID
  iex> Typable.type_of(%URI{})
  URI
  ```
  """
  @spec type_of(t) :: module
  def type_of(t)
end

[
  # scalars
  Atom,
  BitString,
  Float,
  Function,
  Integer,
  PID,
  Port,
  Reference,
  # collections
  Tuple,
  List,
  Map
]
|> Enum.each(fn type ->
  defimpl Typable, for: type do
    def type_of(_), do: unquote(type)
  end
end)

defimpl Typable, for: Any do
  def type_of(%type{}), do: type
end
