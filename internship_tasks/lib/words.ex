defmodule Words do
    @moduledoc """
    Включает в себя функцию `count/1`, которая считает количество вхождений каждого слова в тексте.
    """

    @doc """
    Считает количество вхождений каждого слова в тексте

    ## Параметры

        - phrase: Строка, в которой находится текст.

    ## Примеры

        iex> Words.count("car : carpet as java : javascript!!&@$%^&")
        %{"as" => 1, "car" => 1, "carpet" => 1, "java" => 1, "javascript" => 1}

        iex> Words.count("two_words")
        %{"two" => 1, "words" => 1}

        iex> Words.count("one fish two fish red fish blue fish")
        %{"blue" => 1, "fish" => 4, "one" => 1, "red" => 1, "two" => 1}

    """
    def count(phrase) do
        if is_bitstring phrase do
            # Обрабатываем входной текст, переводим результат в список слов и считаем вхождения
            phrase
            |> clear()
            |> String.split()
            |> count(%{})
        else 
            raise ArgumentError, message: "Invalid argument"
        end
    end

    # Если список слов пуст - просто возвращаем результат
    defp count([], res), do: res

    # Идем рекурсивно по списку, обновляя результат 
    defp count([head|tail], res) do
        count(tail, Map.update(res, head, 1, fn current_value -> current_value + 1 end))
    end

    # Переводит символы в нижний регистр и заменяет все, кроме букв и цифр на пробел
    defp clear(phrase) do
        phrase
        |> String.downcase()
        |> String.replace(~r/[^\p{L}\p{N}-]/, " ")
    end
end