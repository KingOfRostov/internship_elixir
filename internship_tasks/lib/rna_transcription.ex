defmodule RNATranscription do
    @moduledoc """
    Включает в себя функцию `to_rna/1`, которая переводит цепочку ДНК в РНК.
    """

    @doc """
    Переводит цепочку ДНК в РНК

    ## Параметры

        - dna: Список символов, в котором находится цепочка ДНК.

    ## Примеры

        iex> RNATranscription.to_rna('ACGTGGTCTTAA')
        'UGCACCAGAAUU'

        iex> RNATranscription.to_rna('T')
        'A'

    """
    def to_rna(dna) do        
        try do
            Enum.map(dna, & transcribe(&1))
        rescue
            e in ArgumentError -> "Invalid argument"
            e in Protocol.UndefinedError -> "Invalid argument"
            e in FunctionClauseError -> "Invalid argument"
        end
    end

    # Переводит ДНК в РНК
    defp transcribe(?G), do: ?C
    defp transcribe(?C), do: ?G
    defp transcribe(?T), do: ?A
    defp transcribe(?A), do: ?U

end