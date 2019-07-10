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

defmodule Type do
  @moduledoc """
  Utilities for Typable protocol
  """

  defdelegate type_of(x), to: Typable

  @doc """
  Checks if the given type exist.
  Returns :ok if so, otherwise raises exception.

  ## Examples

  ```
  iex> Type.assert_exist!(Integer)
  :ok
  iex> Type.assert_exist!(URI)
  :ok
  iex> Type.assert_exist!(TypeNotExist)
  ** (UndefinedFunctionError) function TypeNotExist.__struct__/0 is undefined (module TypeNotExist is not available)
  ```
  """
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
    def assert_exist!(unquote(type)), do: :ok
  end)

  def assert_exist!(type) do
    %_{} = type.__struct__()
    :ok
  end

  @doc """
  Returns term which is instance of given type.
  Have compile-time guarantees.

  ## Examples

  ```
  iex> require Type
  iex> Type.instance_of(Integer)
  0
  iex> Type.instance_of(Port)
  #Port<0.0>
  iex> Type.instance_of(URI)
  %URI{}

  iex> quote do
  ...>   require Type
  ...>   Type.instance_of(TypeNotExist)
  ...> end
  ...> |> Code.eval_quoted()
  ** (UndefinedFunctionError) function TypeNotExist.__struct__/0 is undefined (module TypeNotExist is not available)
  ```
  """
  defmacro instance_of(quoted_type) do
    {type, []} = Code.eval_quoted(quoted_type, [], __CALLER__)
    mk_instance(type)
  end

  # scalars
  defp mk_instance(Atom), do: nil
  defp mk_instance(BitString), do: ""
  defp mk_instance(Float), do: 0.0

  defp mk_instance(Function) do
    quote location: :keep do
      &self/0
    end
  end

  defp mk_instance(Integer), do: 0

  defp mk_instance(PID) do
    quote location: :keep do
      :erlang.list_to_pid('<0.0.0>')
    end
  end

  defp mk_instance(Port) do
    quote location: :keep do
      :erlang.list_to_port('#Port<0.0>')
    end
  end

  defp mk_instance(Reference) do
    quote location: :keep do
      :erlang.list_to_ref('#Ref<0.0.0.0>')
    end
  end

  # collections
  defp mk_instance(Tuple) do
    quote location: :keep do
      {}
    end
  end

  defp mk_instance(List) do
    quote location: :keep do
      []
    end
  end

  defp mk_instance(Map) do
    quote location: :keep do
      %{}
    end
  end

  # other types
  defp mk_instance(type) do
    type.__struct__()
    |> Macro.escape()
  end
end
