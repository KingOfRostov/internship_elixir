defmodule Year do
    @moduledoc """
    Включает в себя функцию `leap?/1`, которая определяет високосный год или нет.
    """

    @doc """
    Определяет високосный год или нет

    ## Параметры

        - year: Число, содержащее год.

    ## Примеры

        iex> Year.leap?(2000)
        true

        iex> Year.leap?(2100)
        false

        iex> Year.leap?(1904)
        true

    """
    def leap?(year) do
        # Если делится на 4 и при этом не делится на 100. 
        # Или если делится на 400, тогда год считается високосным
        if is_integer(year) do 
            (div_by?(year, 4) and not div_by?(year, 100)) or div_by?(year, 400)
        else
            raise ArgumentError, message: "Invalid argument"
        end
    end

    defp div_by?(year, number) do
        rem(year, number) == 0
    end
end