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
    Else If (A_Hour >= 00) {
        greeting := "Доброй ночи!"
    }
    Return greeting
}

Alt & Q::
{
    greeting := Greeting()
    fullNameShort := FullName(fullName)
    SendChat("say " greeting " Я " rankName ", " fullName2 " " fullName3 ".", "1000")
    SendChat("do На форме сотрудника висит бейдж: """ fullNameShort ", " rankName ", " deptName ", " divisionNameLong """.", "0")
    Return
}

Alt & 1::
{
    SendChat("say Для начала надо заполнить данные. Назовите ваше имя, фамилию и повод обращения?", "0")
    Return
}
!2:: Gosub, PressCount
!2(1):
{
    SendChat("do Бланки обращений и ручка на столе.", "500")
    SendChat("me взял один бланк и заполнил данные", "500")
    SendChat("say Всё готово. Перейдём к осмотру.", "0")
    Return
}
!21(2):
{
    SendChat("do Бланк обращений и ручка на полке АСМП.", "500")
    SendChat("me взял один бланк и заполнил данные", "500")
    SendChat("say Готово, теперь перейдем к осмотру.", "0")
    Return
}
Alt & 3::
{
    SendChat("say Как давно вы стали чувствовать боли?", "1000")
    SendChat("say Алкоголь или табачные средства употребляете?", "1000")
    SendChat("say Физической активностью занимаетесь?", "0")
    Return
}
Alt & X::
{
    SendChat("say Сейчас я вас осмотрю. Старайтесь дышать ровно и спокойно.", "1000")
    SendChat("do На поясе висит сумка, в которой лежат медицинские перчатки.", "500")
    SendChat("me открыв сумку, достал перчатки и надел их", "500")
    SendChat("me осмотрел пациента", "1500")
    SendChat("do Осмотр окончен.", "0")
    Return
}
:?:/helpmed::
{
	SendInput, {Esc}
	Sleep, 50
	SendInput, {F8}/helpmed{Space}
	Input, helpmed, V, {Enter}
	SendInput, {F8}{bs 17}
	Sleep, 500
	SendChat("say Пожалуйста, ожидайте, я выпишу вам заключение.", "500")
	SendChat("do На тумбочке лежат бланки выписных эпикризов, ручка с логотипом " divisionNameShort " и штамп.", "500")
	SendChat("me взяв с тумбочки ручку, заполнил эпикриз", "500")
	SendChat("me поставил дату и подпись", "500")
	SendChat("me взял штамп и поставил печать " divisionNameShort, "500")
	SendChat("do Выписной эпикриз заполнен.", "500")
	SendChat("do На поясе висит сумка с препаратами.", "500")
	SendChat("me открыв сумку, достал препарат и передал его пациенту", "500")
	SendChat("say Всего доброго, не болейте!", "500")
	SendChat("helpmed " helpmed "", "0")
	Sleep, 250
	Screen()
	Return
}
:?:/heal::
{
	SendInput, {Esc}
	Sleep, 50
	SendInput, {F8}/heal{Space}
	Input, heal, V, {Enter}
	SendInput, {F8}{bs 17}
	Sleep, 500
	SendChat("do На полке лежат бланки выписных эпикризов, ручка с логотипом " divisionNameShort " и штамп.", "500")
	SendChat("me взяв с полки ручку, заполнил эпикриз", "500")
	SendChat("me поставил дату и подпись", "500")
	SendChat("me взял штамп и поставил печать " divisionNameShort, "500")
	SendChat("do Выписной эпикриз заполнен.", "500")
	SendChat("do Рядом с сотрудником лежит аптечка.", "500")
	SendChat("me открыв аптечку, достал препарат и передал его гражданину", "500")
	SendChat("say Всего доброго, не болейте!", "500")
	SendChat("heal " heal "", "0")
	Sleep, 250
	Screen()
	Return
}
Alt & N::
{
	SendChat("say Хорошо, тогда лечитесь в стационаре!", "0")
	Return
}
:?:/голова::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Нурофен", "Спазмалгон", "Фармадол"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/мигрень::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Цитрамон П", "Спазмалгон", "Суматриптан"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/переедание::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Пангрол", "Панкреатин", "Мотилак"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/отравление::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Смекта", "Эспумизан", "Энтерофурил"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/гастрит::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Фосфалюгель", "Гастал", "Но-шпа"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/желудок::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Мезин", "Симет", "Линекс"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/тошнота::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Церукал", "Лоразепам", "Глицин"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/изжога::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Ретто", "Маалокс", "Гавискон"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/ушиб::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Финалгон", "Кетонал", "Диклак"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/обезболивающее::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Дексалгин", "Нимесил", "Баралгин"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/запор::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Гутталакс", "Фитолакс", "Микролакс"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/диарея::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Лоперамид", "Диара", "Имодиум"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/геморрой::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Релиф", "Анузол", "Анестезол"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/суставы::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Ибупрофен", "Парацетамол", "Пиаскледин"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/судороги::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Панангин", "Аспаркам", "Магнерот"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/витамины::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Центрум", "Компливит", "Витамикс"]
    SendChat("Я выпишу Вам витамины " Medication[Arr] ". Их стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/аллергия::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Аллегра", "Зодак", "Супрастин"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/простуда::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Терафлю", "Ранкоф", "Ринзасип"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/насморк::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Отривин", "Риностоп", "Тизин"]
    SendChat("Я выпишу Вам " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/горло::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Амбробене", "Гербион", "Коделак"]
    SendChat("Я выпишу Вам " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/сыпьзуд::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Супрастин", "Тавегил", "Зиртек"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/жар::
{
    Random, Arr, 1, 2
    Medication := ["Колдрекс", "Колдакт Флю Плюс"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/печень::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Овесол", "Расторопша", "Гепатрин"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/половойорган::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Тридерм", "Нистатин", "Клотримазол"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/сердце::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Валидол", "Корвалол", "Тиотриазолин"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/зубы::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Баралгин", "Нимесил", "Аэртал"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/глаза::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Алкаин", "Диклофенак", "Броксинак"]
    SendChat("Я выпишу Вам препарат . Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/ожог::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Фенистил", "Пантенол", "Аргосульфан"]
    SendChat("Я выпишу Вам препарат . Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/уши::
{
    SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Отипакс", "Отинум", "Лородекс"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/почки::
{
	SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Нефротин", "Уролесан", "Канефрон"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/давление::
{
	SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Небилет", "Эдарби", "Норваск"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/мочевой::
{
	SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 3
    Medication := ["Цистерол", "Фурагин", "Орципол"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}
:?:/снотворное::
{
	SendInput, {Enter}
	Sleep 500
    Random, Arr, 1, 2
    Medication := ["Доксиламин", "Мелатонин"]
    SendChat("Я выпишу Вам препарат " Medication[Arr] ". Его стоимость 450 рублей. Вы согласны на лечение?", "0")
    Return
}

!tab:: Gosub, PressCount
!tab(1):
{
    Return
}
!tab(2):
{
    WindowTipRight("/голова`n/мигрень`n/переедание`n/отравление`n/гастрит`n/желудок`n/тошнота`n/изжога`n/ушиб`n/обезболивающее`n/запор`n/диарея`n/геморрой`n/суставы`n/судороги`n/витамины`n/аллергия`n/простуда`n/насморк`n/горло`n/сыпьзуд`n/жар`n/печень`n/половойорган`n/сердце`n/зубы`n/глаза`n/ожог`n/уши`n/почки`n/давление`n/мочевой`n/снотворное", 5000)
    Return
}

PressCount:
	Pause_=500
	If not Second
	{
		Second=1
		SetTimer, DoublePress, -%Pause_%
	}
	Else {
		Second=0
		SetTimer, %A_ThisHotkey%(2), -1
	}
	Return

DoublePress:
	If not Second
	{
		Return
	}
	Second=0
	SetTimer, %A_ThisHotkey%(1), -1
	Return