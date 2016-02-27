defmodule Exads.DataStructures.Stack do
  @moduledoc """
  An implementation of the Stack data structure with lists.
  """

  @opaque t(a) :: {__MODULE__, non_neg_integer, list(a)}
  @opaque t :: t(any)

  @doc """
  Returns a new empty stack.
  """
  @spec new() :: t

  def new, do: {__MODULE__, 0, []}

  @doc """
  Returns a stack created from a given list. It does assume, that the item at
  the front of the list is the youngest.
  """

  @spec from_list(list(a)) :: t(a) when a: var

  def from_list(list), do: {__MODULE__, length(list), list}

  @doc """
  Return the stack with the given element pushed into it.
  """
  @spec push(t(a), a) :: t(a) when a: var

  def push({__MODULE__, size, stack}, elem) do
    {__MODULE__, size + 1, [elem|stack]}
  end

  @doc """
  Pops the top element from the stack returning a tuple with the format
  {element, new_list}
  """
  @spec pop(t(a)) :: {a, t(a)} | nil when a: var

  def pop({__MODULE__, 0, []}), do: nil
  def pop({__MODULE__, size, [head | tail]} = _stack) do
    {head, {__MODULE__, size - 1, tail}}
  end

  @doc """
  Deletes the top element from the stack.
  """
  @spec delete(t(a)) :: t(a) | nil when a: var

  def delete({__MODULE__, _size, _stack} = stack_obj) do
    case pop(stack_obj) do
      {_, result} -> result
      nil         -> nil
    end
  end

  @doc """
  Returns true if the stack is empty or false otherwise.
  """
  @spec empty?(t) :: boolean

  def empty?({__MODULE__, 0, []}), do: true
  def empty?({__MODULE__, _size, _stack}), do: false

  @doc """
  Returns the top element from the stack without removing it. If the stack
  is empty returns nil.
  """
  @spec top(t(a)) :: a | nil when a: var

  def top({__MODULE__, _size, _stack} = stack_obj) do
    case pop(stack_obj) do
      {result, _} -> result
      nil         -> nil
    end
  end

  @doc """
  Returns the maximum element in the stack using Elixir's built-in hierarchy.
  """
  @spec max(t(a)) :: a | nil when a: var

  def max({__MODULE__, _size, []}), do: nil
  def max({__MODULE__, _size, stack}) do
    stack |> Enum.max
  end

  @doc """
  Returns the minimum element in the stack using Elixir's built-in hierarchy.
  """
  @spec min(t(a)) :: a | nil when a: var

  def min({__MODULE__, _size, []}), do: nil
  def min({__MODULE__, _size, stack}) do
    stack |> Enum.min
  end

  @doc """
  Given a stack and an element, returns true if the element is a member
  of the stack or false otherwise.
  """
  @spec member?(t(a), a) :: boolean when a: var

  def member?({__MODULE__, _size, stack}, elem) do
    Enum.member? stack, elem
  end

  @doc """
  Returns the position in the stack of a given element. Returns -1 if the
  element is not present. If the element appears more than once, then the
  first occurrence is considered.
  """
  @spec position(t(a), a) :: non_neg_integer | nil when a: var

  def position({__MODULE__, _size, stack}, elem) do
    stack |> Enum.find_index(&(&1 === elem))
  end

  @doc """
  Given a stack and an element returns true if element appears more than
  once in the stack or false otherwise.
  """
  @spec more_than_once(t(a), a) :: boolean when a: var

  def more_than_once({__MODULE__, _size, stack}, elem), do: mto stack, elem, 0

  defp mto([], _, _), do: false
  defp mto([elem|tail], elem, 1), do: true
  defp mto([elem|tail], elem, 0), do: mto(tail, elem, 1)
  defp mto([_head|tail], elem, c), do: mto(tail, elem, c)

  @doc """
  Returns the size of the stack.
  """
  @spec size(t) :: non_neg_integer()

  def size({__MODULE__, size, _stack}), do: size
end
