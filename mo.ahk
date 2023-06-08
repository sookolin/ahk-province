#IfWinActive MTA: Province

Alt & Q::
{
	SendChat("animarmy 3", "250")
	SendChat("say Здравия желаю!", "1500")
	Return
}

Alt & R::
{
	SendChat("s Всем лежать, мордой в пол! Работает ССО ""Затмение""", "500")
	SendChat("do На спине надпись ""ССО «Затмение»"".", "0")
	Return
}


:?:/setprison::
{
	SendInput, {Esc}
	Sleep 50
	SendInput, {F8}/setprison{Space}
	Input, setprison, V, {Enter}
	SendInput, {F8}{bs 17}
	Sleep, 500
	SendChat("say Товарищ военнослужащий! Вы задержаны за нарушение УМО!", "1000")
	SendChat("do Наручники на поясе.", "500")
	SendChat("me снял наручники с пояса, затем застегнул их на запястьях военнослужащего", "500")
	SendChat("do Военнослужащий в наручниках.", "2000")
	SendChat("say Товарищ военнослужащий, сейчас мы составим протокол вашего задержания.", "500")
	SendChat("do На плече офицера висит сумка.", "500")
	SendChat("me открыл сумку, затем достал бланк протокола и ручку", "500")
	SendChat("do Протокол заполнен.", "500")
	SendChat("me поставил галочку о невозможности получения подписи обвиняемого", "500")
	SendChat("do Галочка поставлена.", "1500")
	SendChat("say И так, пора вас конвоиру передавать.", "1500")
	SendChat("say Документы и личные вещи изъятые в ходе досмотра при заключении,..", "500")
	SendChat("say ...заберете у дежурного, при выходе из карцера.", "2000")
	SendChat("do Конвоир подошёл к задержанному.", "500")
	SendChat("me передал задержанного военнослужащего конвоиру", "500")
	SendChat("do Конвоир увёл задержанного.", "500")
	SendChat("setprison " setprison "", "0")
	Return
}
:?:/givetask::
{
	SendInput, {Esc}
	Sleep 50
	SendInput, {F8}/givetask{Space}
	Input, givetask, V, {Enter}
	SendInput, {F8}{bs 17}
	Sleep, 500
	SendChat("say Товарищ военнослужащий! Вы нарушили УМО!", "250")
	SendChat("say В виде наказания вам выдан наряд вне очереди, приступайте к выполнению!", "250")
	SendChat("say За невыполнение приказа вы будете отправлены в карцер согласно УМО!", "250")
	SendChat("givetask " givetask "", "0")
	Return
}

:?:/пред1::
{
	SendInput, {Enter}
	Sleep 500
	GetMegafon()
	Sleep, 250
	SendChat("m Водитель, остановитесь и прижмитесь к обочине!", "0")
	Sleep, 250
	RemoveMegafon()
	Return
}
:?:/пред2::
{
	SendInput, {Enter}
	Sleep 500
	GetMegafon()
	Sleep, 250
	SendChat("m Водитель, остановитесь!  Либо мы применим табельное оружие!", "0")
	Sleep, 250
	RemoveMegafon()
	Return
}
:?:/уступ::
{
	SendInput, {Enter}
	Sleep 500
	GetMegafon()
	Sleep, 250
	SendChat("m Уступите дорогу армейскому транспорту!", "0")
	Sleep, 250
	RemoveMegafon()
	Return
}

:?:/увал+::
{
	SendInput, {Esc}
	Sleep 50
	SendInput, {F8}/giveuval{Space}
	Return
}
:?:/увал-::
{
	SendInput, {Esc}
	Sleep 50
	SendInput, {F8}/removeuval{Space}
	Return
}

:?:/маска+::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("do В кармане кителя лежит балаклава.", "250")
	SendChat("me резким движением руки достал балаклаву из кармана и надел её на лицо", "250")
	SendChat("do Балаклава на лице.", "0")
	Return
}
:?:/маска-::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("do Балаклава на лице.", "250")
	SendChat("me резким движением руки снял балаклаву и положил её в карман кителя", "250")
	SendChat("do Балаклава в кармане кителя.", "0")
	Return
}

:?:/кпп1::
{
	SendInput, {Enter}
	Sleep 500
	Duty("КПП", 1)
	Sleep, 250
	Screen()
	Return
}
:?:/кпп2::
{
	SendInput, {Enter}
	Sleep 500
	Duty("КПП", 2)
	Sleep, 250
	Screen()
	Return
}
:?:/кпп3::
{
	SendInput, {Enter}
	Sleep 500
	Duty("КПП", 3)
	Sleep, 250
	Screen()
	Return
}
:?:/казарма1::
{
	SendInput, {Enter}
	Sleep 500
	Duty("казармы", 1)
	Sleep, 250
	Screen()
	Return
}
:?:/казарма2::
{
	SendInput, {Enter}
	Sleep 500
	Duty("казармы", 2)
	Sleep, 250
	Screen()
	Return
}
:?:/казарма3::
{
	SendInput, {Enter}
	Sleep 500
	Duty("казармы", 3)
	Sleep, 250
	Screen()
	Return
}
:?:/мед1::
{
	SendInput, {Enter}
	Sleep 500
	Duty("мед. пункта", 1)
	Sleep, 250
	Screen()
	Return
}
:?:/мед2::
{
	SendInput, {Enter}
	Sleep 500
	Duty("мед. пункта", 2)
	Sleep, 250
	Screen()
	Return
}
:?:/мед3::
{
	SendInput, {Enter}
	Sleep 500
	Duty("мед. пункта", 3)
	Sleep, 250
	Screen()
	Return
}
:?:/парк1::
{
	SendInput, {Enter}
	Sleep 500
	Duty("парка", 1)
	Sleep, 250
	Screen()
	Return
}
:?:/парк2::
{
	SendInput, {Enter}
	Sleep 500
	Duty("парка", 2)
	Sleep, 250
	Screen()
	Return
}
:?:/парк3::
{
	SendInput, {Enter}
	Sleep 500
	Duty("парка", 3)
	Sleep, 250
	Screen()
	Return
}
:?:/столовая1::
{
	SendInput, {Enter}
	Sleep 500
	Duty("столовой", 1)
	Sleep, 250
	Screen()
	Return
}
:?:/столовая2::
{
	SendInput, {Enter}
	Sleep 500
	Duty("столовой", 2)
	Sleep, 250
	Screen()
	Return
}
:?:/столовая3::
{
	SendInput, {Enter}
	Sleep 500
	Duty("столовой", 3)
	Sleep, 250
	Screen()
	Return
}
:?:/склад1::
{
	SendInput, {Enter}
	Sleep 500
	Duty("склада", 1)
	Sleep, 250
	Screen()
	Return
}
:?:/склад2::
{
	SendInput, {Enter}
	Sleep 500
	Duty("склада", 2)
	Sleep, 250
	Screen()
	Return
}
:?:/склад3::
{
	SendInput, {Enter}
	Sleep 500
	Duty("склада", 3)
	Sleep, 250
	Screen()
	Return
}
:?:/штаб1::
{
	SendInput, {Enter}
	Sleep 500
	Duty("штаба", 1)
	Sleep, 250
	Screen()
	Return
}
:?:/штаб2::
{
	SendInput, {Enter}
	Sleep 500
	Duty("штаба", 2)
	Sleep, 250
	Screen()
	Return
}
:?:/штаб3::
{
	SendInput, {Enter}
	Sleep 500
	Duty("штаба", 3)
	Sleep, 250
	Screen()
	Return
}

Duty(location, stage) {
	If (stage == 1) {
		stage := " Дежурство принял. "
	}
	Else If (stage == 2) {
		stage := " "
	}
	Else If (stage == 3) {
		stage := " Дежурство сдал. "
	}
	SendChat("r [Дежурный " location "]" stage "Код-1. " rankName " " fullName1 ".", "0")
}

:?:/гп1::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("r [ГП. " cardID "] Код-1. НГ-ВЧ-00. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}
:?:/гп2::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("r [ГП. " cardID "] Код-1. НГ-ВЧ-01. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}
:?:/гп3::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("r [ГП. " cardID "] Код-1. НГ-ВЧ-02. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}
:?:/гп4::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("r [ГП. " cardID "] Код-1. НГ-ВЧ-05. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}
:?:/гп5::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("r [ГП. " cardID "] Код-1. НГ-ВЧ-10. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}

:?:/нто1::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("r [НТО. " cardID "] Код-1. М1-00. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}
:?:/нто2::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("r [НТО. " cardID "] Код-1. М1-01. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}
:?:/нто3::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("r [НТО. " cardID "] Код-1. М1-02. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}
:?:/нто4::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("r [НТО. " cardID "] Код-1. М1-03. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}
:?:/нто5::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("r [НТО. " cardID "] Код-1. М1-05. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}
:?:/нто6::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("r [НТО. " cardID "] Код-1. М1-10. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}

:?:/док1::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("say С какой целью прибыли к территории воинской части?", "0")
	Return
}
:?:/док2::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("say Будьте добры, предъявите ваши документы.", "0")
	Return
}
Alt & F1::
{
	SendChat("s Я вас предупреждаю, данная территория является закрытой и охраняемой!", "3000")
	SendChat("s Служащие имеют право открыть огонь на поражение!", "3000")
	SendChat("s Покиньте зону прямой видимости ВЧ немедленно! В противном случае я отдам приказ!", "0")
	Return
}
Alt & F2::
{
	SendChat("s Ваши действия могут быть расценены как провокационные и/или действия с целью разведки!", "0")
	Return
}
Alt & F3::
{
	GetRadio()
	Sleep, 250
	SendChat("r КПП, привести оружие в боевое положение и приготовиться к стрельбе по нарушителю! Ждем приказ!", "0")
	Sleep, 250
	RemoveRadio()
	Return
}
Alt & F4::
{
	GetRadio()
	Sleep, 250
	SendChat("r КПП, открыть огонь по нарушителю!", "0")
	Sleep, 250
	RemoveRadio()
	Return
}

Alt & -::
{
	GetRadio()
	Return
}
Alt & =::
{
	RemoveRadio()
	Return
}

GetRadio() {
	SendChat("do Рация висит на нагрудном кармане.", "500")
	SendChat("me снял рацию с нагрудного кармана и нажал кнопку для переговоров", "500")
	SendChat("do Военнослужащий говорит что-то в рацию.", "0")
}
RemoveRadio() {
	SendChat("me сказал что-то в рацию и повесил ее на нагрудный карман", "500")
	SendChat("do Рация висит на нагрудном кармане.", "0")
}
GetMegafon() {
	SendChat("me сказал что-то в рацию и повесил ее на нагрудный карман", "500")
	SendChat("me взяв мегафон в руки, сказал что-то в него", "0")
}
RemoveMegafon() {
	SendChat("me повесил обратно рацию на торпеду", "500")
	SendChat("do Рация висит на торпеде.", "0")
}

:?:/регистратор::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("do На нагрудном кармане висит видеорегистратор.", "250")
	SendChat("do Запись идет.", "0")
	Sleep, 250
	Screen()
	Return
}

F12::
{
	Screen()
	Return
}

Alt & PgUp::
{
	SendChat("r [" postName ". " cardID "] Код-1. Заступил на смену.", "0")
	Return
}
Alt & PgDn::
{
	SendChat("r [" postName ". " cardID "] Код-1. Сдал смену.", "0")
	Return
}

:?:/c1::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("say Вы пришли на собеседование для вступления в ряди Армии?", "0")
	Return
}
:?:/c2::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("say Назовите ваше ФИО, а также возраст.", "0")
	Return
}
:?:/c3::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("say Сколько лет проживаете в Республике, а также в каком населенном пункте?", "0")
	Return
}
:?:/c4::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("say Передайте мне ваш паспорт.", "250")
	SendChat("b РП отыгровка и /pass ID", "0")
	Return
}
:?:/c5::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("me взял паспорт из рук человека напротив", "2500")
	SendChat("do Паспорт в руках.", "2500")
	SendChat("me изучает данные паспорта и сам документ", "0")
	Return
}
:?:/c6::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("do Паспорт изучен.", "2500")
	SendChat("me отдал паспорт обратно человеку напротив", "0")
	Return
}
:?:/c7::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("say Медицинскую комиссию проходили?", "0")
	Return
}
:?:/c8::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("say Позвольте ознакомиться с вашим медицинским заключением.", "0")
	Return
}
:?:/c9::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("me взял медицинское заключение из рук человека напротив", "2500")
	SendChat("do Медицинское заключение в руках.", "2500")
	SendChat("me изучает медицинское заключение", "2500")
	SendChat("do Медицинское заключение изучено.", "2500")
	SendChat("me отдал медицинское заключение обратно человеку напротив", "0")
	Return
}
:?:/c10::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("say Какое у вас образование?", "0")
	Return
}
:?:/c11::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("say Позвольте ознакомиться с вашим дипломом об образовании.", "0")
	Return
}
:?:/c12::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("me взял диплом из рук человека напротив", "2500")
	SendChat("do Диплом в руках.", "2500")
	SendChat("me изучает диплом", "2500")
	SendChat("do Диплом изучен.", "2500")
	SendChat("me отдал диплом обратно человеку напротив", "0")
	Return
}
:?:/c13::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("say Передайте мне ваше транспортное удостоверение.", "250")
	SendChat("b РП отыгровка и /lic ID", "0")
	Return
}
:?:/c14::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("me взял транспортное удостоверение из рук человека напротив", "2500")
	SendChat("do Транспортное удостоверение в руках.", "2500")
	SendChat("me изучает данные транспортное удостоверения и сам документ", "0")
	Return
}
:?:/c15::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("do Транспортное удостоверение изучено.", "2500")
	SendChat("me отдал транспортное удостоверение обратно человеку напротив", "0")
	Return
}
:?:/c16::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("say Передайте мне ваш военный билет.", "250")
	SendChat("b РП отыгровка и /vb ID", "0")
	Return
}
:?:/c17::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("me взял военный билет из рук человека напротив", "2500")
	SendChat("do Военный билет в руках.", "2500")
	SendChat("me изучает данные военного билета и сам документ", "0")
	Return
}
:?:/c18::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("do Военный билет изучен.", "2500")
	SendChat("me отдал военный билет обратно человеку напротив", "0")
	Return
}
:?:/c19::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("say Передайте мне вашу трудовую книжку.", "250")
	SendChat("b РП отыгровка и /tk ID", "0")
	Return
}
:?:/c20::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("me взял трудовую книжку из рук человека напротив", "2500")
	SendChat("do Трудовая книжка в руках.", "2500")
	SendChat("me изучает данные трудовой книжки", "0")
	Return
}
:?:/c21::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("do Трудовая книжка изучена.", "2500")
	SendChat("me отдал трудовую книжку обратно человеку напротив", "0")
	Return
}


:?:/дпг1::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("[ДпГ] Заступил в дежурство. Код-1. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}
:?:/дпг2::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("[ДпГ] КПП. Код-1. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}
:?:/дпг3::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("[ДпГ] Вышка-1	. Код-1. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}
:?:/дпг4::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("[ДпГ] Вышка-2. Код-1. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}
:?:/дпг5::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("[ДпГ] Вышка-3. Код-1. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}
:?:/дпг6::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("[ДпГ] Вышка-4. Код-1. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}
:?:/дпг7::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("[ДпГ] Ангар. Код-1. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}
:?:/дпг8::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("[ДпГ] Склад. Код-1. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}
:?:/дпг9::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("[ДпГ] Столовая. Код-1. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}
:?:/дпг10::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("[ДпГ] Медицинский пункт. Код-1. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}
:?:/дпг11::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("[ДпГ] Казарма. Код-1. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}
:?:/дпг12::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("[ДпГ] Штаб. Код-1. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}
:?:/дпг13::
{
	SendInput, {Enter}
	Sleep 500
	SendChat("[ДпГ] Сдал дежурство. Код-1. " rankName " " fullName1 ".", "0")
	Sleep, 250
	Screen()
	Return
}