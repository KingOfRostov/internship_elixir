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

            # Проверяем входное значение и на основе этого возвращаем ответ
            cond do
                # Если пустая строка  
                is_empty?(phrase) -> "Подумаешь!"

                # Если накричали (капс) с вопросом
                is_question?(phrase) and any_letters?(phrase) and is_shout?(phrase)->
                    "Не учите меня жить!"

                # Если задали вопрос
                is_question?(phrase) -> "Мрак"

                # Если накричали (капсом)
                is_shout?(phrase) -> "Хамите, парниша!"
                
                # Во всех остальных случаях
                true -> "Хо-хо!"    
            end
        else 
            raise ArgumentError, message: "Invalid argument"
        end
    end
    
    defp is_empty?(phrase), do: String.trim(phrase) == ""
    defp any_letters?(phrase), do: Regex.run(~r/[\p{L}]/u, phrase) != nil
    defp is_question?(phrase), do: String.last(phrase) == "?"
    defp is_shout?(phrase), do: phrase == String.upcase(phrase) and any_letters?(phrase)
end