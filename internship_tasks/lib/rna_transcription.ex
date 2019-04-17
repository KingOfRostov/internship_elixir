defmodule RNATranscription do
    @moduledoc """
    Включает в себя функцию `to_rna/1`, которая переводит цепочку ДНК в РНК.
    """

    @doc """
    Переводит цепочку ДНК в РНК

    ## Параметры

        - dna: Строка, в которой находится цепочка ДНК.

    ## Примеры

        iex> RNATranscription.to_rna("ACGTGGTCTTAA")
        "UGCACCAGAAUU"

        iex> RNATranscription.to_rna("T")
        "A"

    """
    def to_rna(dna) do
        if dna == String.replace(dna, ~r/[^ATCGАТС]/, "") do
            # Заводим Map, в которой ключи - ДНК, значения - соответствующие ключу РНК 
            rule = %{"G" => "C", "C" => "G", "T" => "A", "A" => "U"}
            # Переводим входную цепочку в список символов
            list = String.graphemes(dna)
            # Для каждого символа применяем подстановку 
            rna_list = Enum.map(list, fn(i) -> rule[i] end)
            # Переводим список обратно в строку, что бы вернуть результат строкой
            List.to_string(rna_list)
        else 
            raise ArgumentError, message: "Invalid argument"
        end
    end
end