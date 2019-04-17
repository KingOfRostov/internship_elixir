defmodule HrBot do
    @moduledoc """
    Включает в себя функцию `hello/2`, которая приветствует нового сотрудника.
    """
    @doc """
    Печатает приветствие

    ## Параметры

        - name: Строка, в которой находится имя человека.
        - position: Строка, в которой находится профессия человека. По умолчанию имеет значение "сотрудник"
        
    ## Примеры

        iex> HrBot.hello("Сергей", "Elixir-программист")
        "Поприветствуйте Сергея, нашего нового Elixir-программиста!"

        iex> HrBot.hello("Оля")
        "Поприветствуйте Олю, нашего нового сотрудника!"

    """

    import HTTPoison
    def hello(name, position \\ "сотрудник") do
        if is_bitstring(name) and is_bitstring(position) do
            try do  
                # Генерируем форму для должности
                url_pos = "https://ws3.morpher.ru/russian/declension?s=" <> String.replace(position, " " , "%20")
                resp = HTTPoison.get! url_pos
                body = resp.body
                # <В> </В> В этом тэге заключена форма слова в винительном падеже
                form_position = 
                    Regex.run(~r/\<В\>[a-zA-Zа-яА-Я-\/0-9\s']+[ ]*<\/В\>/u, body)
                    |> List.to_string() 
                    # Избавляемся от тега <В> </В>
                    |> String.slice(3..-1)
                    |> String.slice(0..-5)

                # Генерируем форму для имени
                url_name = "https://ws3.morpher.ru/russian/declension?s=" <> String.replace(name, " " , "%20")
                resp = HTTPoison.get! url_name
                body = resp.body
                # <В> </В> В этом тэге заключена форма слова в винительном падеже
                form_name = 
                    Regex.run(~r/\<В\>[a-zA-Zа-яА-Я-\/0-9\s]+[ ]*<\/В\>/u, body)
                    |> List.to_string() 
                    # Избавляемся от тега <В> </В>
                    |> String.slice(3..-1)
                    |> String.slice(0..-5)
                
                # Если должность состоит из русских символов только. Так как сайт translate.ru другие не принимает 
                if position == String.replace(position, ~r/[^а-яА-ЯщцушхъфырэчстьюЩЦУШЧЪФЫРЭЧСТЬЮ]/, "") do

                    # Узнаем род должности (мужской или женский)
                    url_pos_gender = "https://www.translate.ru/Grammar/ru-en/" <> String.replace(position, " " , "%20")
                    resp = HTTPoison.get! url_pos_gender
                    body = resp.body
                    pos_gender = 
                        Regex.run(~r/м.р.|ж.р./, body)
                        |> List.to_string()

                    # Проверяем, если гендер имени и род должности - женские, то заменяем
                    # слова "нашего нового" на "нашу новую" 
                    if Petrovich.Detector.detect_gender(name, :firstname) == {:ok, "female"} and pos_gender == "ж.р." do
                        "Поприветствуйте #{form_name}, нашу новую #{form_position}!"
                    else 
                        "Поприветствуйте #{form_name}, нашего нового #{form_position}!"
                    end
                else 
                    "Поприветствуйте #{form_name}, нашего нового #{form_position}!"
                end
            rescue 
                # В случае, когда ответ от ws3.morpher.ru будет :nil - List.to_string() дает ошибку 
                e in FunctionClauseError -> "Поприветствуйте #{name}, нашего нового #{position}!"
            end
        else
             raise ArgumentError, message: "Invalid argument"
        end         
    end

end