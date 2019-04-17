defmodule Ella do
    @moduledoc """
    Включает в себя функцию `say/1`, которая отвечает на входное предложение.
    """

    @doc """
    Отвечает на входное предложение

    ## Параметры

        - phrase: Строка, в которой находится входное предложение.

    ## Примеры

        iex> Ella.say("Как дела?")
        "Мрак"

        iex> Ella.say("ЙОЛО")
        "Хамите, парниша!"

        iex> Ella.say("")
        "Подумаешь!"

        iex> Ella.say()
        "Подумаешь!"

        iex> Ella.say("Энисинг элс")
        "Хо-хо!"

    """
    def say(phrase \\ "") do
        if is_bitstring(phrase) do
            clean_phrase = String.replace(phrase, ~r/[^\p{L}?]/, "") 
            # IO.puts(clean_phrase)
            # Проверяем входное значение и на основе этого возвращаем ответ
            cond do
                # Если пустая строка  
                String.length(String.replace(phrase, ~r/[^\p{L}\p{N}?]/, "")) == 0 -> "Подумаешь!"

                # Если накричали (капс) с вопросом
                String.last(phrase) == "?" and String.replace(phrase, ~r/[^\p{L}]/, "") != "" and clean_phrase == String.upcase(clean_phrase)->
                    "Не учите меня жить!"

                # Если задали вопрос
                String.last(clean_phrase) == "?" -> "Мрак"

                # Если накричали (капсом)
                clean_phrase == String.upcase(clean_phrase) -> "Хамите, парниша!"
                
                # Во всех остальных случаях
                true -> "Хо-хо!"    
            end
        else 
            raise ArgumentError, message: "Invalid argument"
        end
    end
end