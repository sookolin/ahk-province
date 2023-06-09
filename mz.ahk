Greeting() {
    If (A_Hour >= 18) {
        greeting := "Добрый вечер!"
    }
    Else If (A_Hour >= 12) {
        greeting := "Добрый день!"
    }
    Else If (A_Hour >= 06) {
        greeting := "Доброе утро!"
    }
    Else If (A_Hour < 00) {
        greeting := "Доброй ночи!"
    }
}

Alt & Q::
{
    greeting := Greeting()
    SendChat("say " greeting " Я " rankName ", " fullName2 " " fullName3, "1000")
    SendChat("do На форме сотрудника висит бейдж: """ fullName ", " rankName " " postName ", " divisionNameLong ".", "0")
}