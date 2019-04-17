defmodule InternshipTasksTest do
  use ExUnit.Case
  doctest InternshipTasks

  test "greets the world" do
    assert InternshipTasks.hello() == :world
  end

  test "greets new employee" do
    assert HrBot.hello("Сергей", "Elixir-разработчик") == "Поприветствуйте Сергея, нашего нового Elixir-разработчика!"
    assert HrBot.hello("Максим") == "Поприветствуйте Максима, нашего нового сотрудника!"
    assert HrBot.hello("Мария", "полицейский") == "Поприветствуйте Марию, нашего нового полицейского!"
    assert HrBot.hello("Саша", "строитель") == "Поприветствуйте Сашу, нашего нового строителя!"
    assert HrBot.hello("Камару", "актер") == "Поприветствуйте Камару, нашего нового актера!"
    assert HrBot.hello("Андрей", "UX/UI-дизайнер") == "Поприветствуйте Андрея, нашего нового UX/UI-дизайнера!"
  end

  test "conversation with ella" do
    assert Ella.say("Как оно?") == "Мрак"
    assert Ella.say("") == "Подумаешь!"
    assert Ella.say() == "Подумаешь!"
    assert Ella.say("КРИК") == "Хамите, парниша!"
    assert Ella.say("nothing SpeCIal") == "Хо-хо!"
    assert Ella.say("@&%*^QQWT") == "Хамите, парниша!"
    assert Ella.say("@&%*^QQWT?") == "Не учите меня жить!"
    assert Ella.say("  ") == "Подумаешь!"
    assert Ella.say("@&%*???") == "Мрак"
    assert Ella.say("@&%*?^QQWT") == "Хамите, парниша!"
  end

  test "count words" do
    assert Words.count("one fish two fish red fish blue fish") == %{"one" => 1, "fish" => 4, "two" => 1, "red" => 1, "blue" => 1}
    assert Words.count("car : carpet as java : javascript!!&@$%^&") == %{"car" => 1, "carpet" => 1, "as" => 1, "java" => 1, "javascript" => 1}
    assert Words.count("go Go GO") == %{"go" => 3}
    assert Words.count("two_words") == %{"two" => 1, "words" => 1}
    assert Words.count("") == %{}
  end

  test "leap year check" do
    assert Year.leap?(1904) == true
    assert Year.leap?(2000) == true
    assert Year.leap?(2100) == false
    assert Year.leap?(1912) == true
    assert Year.leap?(1905) == false
  end

  test "dna to rna" do
    assert RNATranscription.to_rna("A") == "U"
    assert RNATranscription.to_rna("ACGTGGTCTTAA") == "UGCACCAGAAUU"
    assert RNATranscription.to_rna("") == ""
    assert RNATranscription.to_rna("TTTAAA") == "AAAUUU"
  end
end
