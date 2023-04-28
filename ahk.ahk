/*



    █████╗ ██╗  ██╗██╗  ██╗    ██████╗ ██████╗  ██████╗ ██╗   ██╗██╗███╗   ██╗ ██████╗███████╗
   ██╔══██╗██║  ██║██║  ██║    ██╔══██╗██╔══██╗██╔═══██╗██║   ██║██║████╗  ██║██╔════╝██╔════╝
   ███████║███████║█████══╝    ██████═╝██████═╝██║   ██║██║   ██║██║██╔██╗ ██║██║     ███████╗
   ██╔══██║██╔══██║██╔══██╗    ██╔══╝  ██╔══██╗██║   ██║╚██  ██╔╝██║██║╚██╗██║██║     ██╔════╝
   ██║  ██║██║  ██║██║  ██║    ██║     ██║  ██║╚██████╔╝ ╚████╔╝ ██║██║ ╚████║╚██████╗███████╗
   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝╚══════╝



*/

version := 1

#NoEnv

files_img := ["close.png", "open.png", "ico_settings.png", "joy.png", "line.png", "logo_province.png", "rollup.png"]
files_render := ["interface.html", "style.profile.css"]
files_sounds := ["click.mp3"]

FileCreateShortcut,  %A_ScriptFullPath%, %A_Desktop%\AHK Province.lnk,,, AHK Province — самый лучший скрипт для взаимодейтсвия с Провинцией`, не правла ли?

/*
For index, file_name in files_img
{
	IfNotExist, %A_ScriptDir%/img/%file_name%
}
For index, file_name in files_sounds
{
	IfNotExist, %A_ScriptDir%/sounds/%file_name%
}
For index, file_name in files_render
{
	; IfNotExist, %A_ScriptDir%/sounds/%file_name%
}
*/

RegRead, vkID, HKEY_LOCAL_MACHINE, SOFTWARE\AutoHotkey\AHK Province\, vkID
global vkID
IniRead, gameFolder, data.profile, GAME, gameFolder
RegWrite, REG_DWORD, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Internet Explorer\Zoom, ZoomDisabled, 1

If (vkID == "ERROR") {
	vkID := ""
}

global fileLog := gameFolder "\MTA\MTA\logs\console.log"
;global proxy := "https://vk-api-proxy.xtrafrancyz.net/_/"

FileInstall, interface.html, interface.html
FileInstall, style.profile.css, style.profile.css
FileInstall, click.mp3, click.mp3
FileInstall, close.png, close.png
FileInstall, open.png, open.png
FileInstall, ico_settings.png, ico_settings.png
FileInstall, joy.png, joy.png
FileInstall, line.png, line.png
FileInstall, logo_province.png, logo_province.png
FileInstall, rollup.png, rollup.png

title = AHK Province
neutron := new NeutronWindow()
neutron.Load("interface.html")

neutron.qs("#mo").innerHTML := neutron.FormatHTML("<div class=""item default""><div onclick=""pageShow(event, 'moPanel')"" class=""name"">{}</div></div>", "МО")

vkLinkInput := neutron.doc.querySelectorAll("#vkLink")
If (vkID == "") {
	vkLinkInput[0].value := ""
}
Else {
	vkLinkInput[0].value := "https://vk.com/id"vkID

	get_data := GetData("https://vk.com/id"vkID)
	nickName := get_data.nickName
	fullName := get_data.fullName
	global fullName
	RegExMatch(fullName, "(.*) (.*) (.*)", fullName)
	global fullName1
	global fullName2
	global fullName3

	fracName := get_data.fracName
	If (fracName == "11") {
		fracName := "МО"
	}
	Else {
		fracName := ""
	}

	rankName := get_data.rankName
	If (rankName == "4") {
		rankName := "Прапорщик"
	}
	Else If (rankName == "5") {
		rankName := "Лейтенант"
	}
	Else If (rankName == "6") {
		rankName := "Старший лейтенант"
	}
	Else If (rankName == "7") {
		rankName := "Капитан"
	}
	Else If (rankName == "8") {
		rankName := "Майор"
	}
	Else If (rankName == "9") {
		rankName := "Полковник"
	}
	Else If (rankName == "10") {
		rankName := "Генерал"
	}
	Else If (rankName == "11") {
		rankName := "Маршал"
	}
	Else {
		rankName := ""
	}
	global rankName
	
	postName := get_data.postName
	deptName := get_data.deptName
	passID := get_data.passID
	cardID := get_data.cardID

	signName := get_data.signName
	If (signName == "   ") {
		signName := ""
	}

	dataText := "<p><b>Ник:</b> " nickName "</p>"
	dataText := dataText "<p><b>ФИО:</b> " fullName "</p>"
	dataText := dataText "<p><b>Фракция:</b> " fracName "</p>"
	dataText := dataText "<p><b>Должность/звание:</b> " rankName "</p>"
	dataText := dataText "<p><b>Отдел/взвод:</b> " deptName "</p>"
	dataText := dataText "<p><b>Паспорт:</b> " passID "</p>"
	dataText := dataText "<p><b>Удостоверение:</b> " cardID "</p>"
	dataText := dataText "<p><b>Позывной:</b> " signName "</p>"
	neutron.qs("#dataText").innerHTML := neutron.FormatHTML(dataText, "")
}

Loop, 5
{
	vk_post := VKpost(A_Index)
	post_text := vk_post.text
	post_date := vk_post.date
	post_photo := vk_post.photo
	post_id := vk_post.id

	If (post_date == "01.01.1970") {
		post_date := ""
	}

	If (post_photo == "") {
		post_photo :=
	}
	
	neutron.qs("#photo_" A_Index "").innerHTML := neutron.FormatHTML("<div class=""background"" onclick=""ahk.openPost(event, '{}')""><img src=""{}"" style=""width: auto; height: 100%;""></div>", "" post_id "", "" post_photo "")
	neutron.qs("#text_" A_Index "").innerHTML := neutron.FormatHTML("<span>{}</span>", "" post_text "")
	neutron.qs("#date_" A_Index "").innerHTML := neutron.FormatHTML("<span>{}</span>", "" post_date "")
}

vk_get := VKget(2000000008)
get_alert := vk_get.text
If RegExMatch(get_alert, "i)^!alert (.*)$", get_alert)
{
	alert := neutron.doc.querySelectorAll(".alert-header > div")
	For i, div in neutron.Each(alert)
	{
		div.className := "active"
		neutron.qs("#alert").innerHTML := neutron.FormatHTML("<div>{}</div>", "" get_alert1 "")
	}
}

If ((gameFolder == "ERROR") or (gameFolder == "")) {
	FileSelectFolder, gameFolder,, 0, Выберите папку, где установлена игра MTA Province!
	IniWrite, %gameFolder%, data.profile, GAME, gameFolder
}

vk_update := VKget(2000000010)
update_text := vk_update.text
If RegExMatch(update_text, "i)^!update (.*)$", update_text)
{
	RegExMatch(update_text1, "(.*) / (.*) / (.*)#(.*)", update_text)
	If (update_text1 >= version) {
		RegRead, msgUpdate, HKEY_LOCAL_MACHINE, SOFTWARE\AutoHotkey\AHK Province\, msgUpdate
		RegRead, msgUpdateVersion, HKEY_LOCAL_MACHINE, SOFTWARE\AutoHotkey\AHK Province\, msgUpdateVersion
		If (msgUpdateVersion < update_text1) {
			RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE, SOFTWARE\AutoHotkey\AHK Province\, msgUpdate, 0
			RegRead, msgUpdate, HKEY_LOCAL_MACHINE, SOFTWARE\AutoHotkey\AHK Province\, msgUpdate
		}
		If ((msgUpdate == "") || (msgUpdate == 0)) {
			msg := neutron.doc.querySelectorAll(".msg-box > div")
			neutron.qs(".msg.overlay .panel .title").innerHTML := neutron.FormatHTML("<div>ОБНОВЛЕНИЕ {} ОТ {}</div>", "" update_text2 "", "" update_text3 "")
			neutron.qs(".msg.overlay .panel .desc").innerHTML := neutron.FormatHTML("" update_text4 "{}", "")
			For i, div in neutron.Each(msg)
			{
				div.className := "active"
			}
			RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE, SOFTWARE\AutoHotkey\AHK Province\, msgUpdate, 1
			RegWrite, REG_SZ, HKEY_LOCAL_MACHINE, SOFTWARE\AutoHotkey\AHK Province\, msgUpdateVersion, %update_text1%
		}
	}
}

neutron.Gui("+LabelNeutron")
neutron.Show("w1290 h745")
neutron.Gui("+Lastfound")

IniRead, testFunction, data.profile, LAUNCHER, testFunction

If (testFunction == "1804") {
	SetTimer, Chat, 50
}
Return

Chat() {
	FileEncoding, UTF-8
	Loop, Read, % fileLog
	{
		lastRow := A_LoopReadLine
	}
	RegExMatch(lastRow, "\[(.*) (.*)\] \[Output\] : (.*)", chatText)

	If (chatText3 == "login: You successfully logged in") {
		Sleep, 500
		SendChat("fracvoice 2", "0")
	}
}

Alt & Z::
Chat()
Return

NeutronClose:
{
	ExitApp
	Return
}

NinjaFunction(neutron, event) {
	IniRead, numFunction, data.profile, LAUNCHER, numFunction
	If (numFunction == "ERROR") {
		numFunction := 0
	}
	numFunction += 1
	IniWrite, %numFunction%, data.profile, LAUNCHER, numFunction
	If (numFunction = 5) {
		msg := neutron.doc.querySelectorAll(".msg-box > div")
		neutron.qs(".msg.overlay .panel .title").innerHTML := neutron.FormatHTML("<div>{}</div>", "УВЕДОМЛЕНИЕ")
		neutron.qs(".msg.overlay .panel .desc").innerHTML := neutron.FormatHTML("<div>{}</div>", "Шалун, да?")
		For i, div in neutron.Each(msg)
		{
			div.className := "active"
		}
		IniWrite, 1804, data.profile, LAUNCHER, testFunction
	}
}

openPost(neutron, event, num) {
	url := "https://vk.com/provinceahk?w=wall-204021621_" num ""
	Run, % url
}

Submit(neutron, event)
{
	event.preventDefault()

	dataSettings := neutron.GetFormData(event.target)
	vkLink := % dataSettings.vkLink

	If (vkLink == "") {
		msg := neutron.doc.querySelectorAll(".msg-box > div")
		neutron.qs(".msg.overlay .panel .title").innerHTML := neutron.FormatHTML("<div>{}</div>", "ОШИБКА")
		neutron.qs(".msg.overlay .panel .desc").innerHTML := neutron.FormatHTML("<div>{}</div>", "Вы не указали ссылку на страницу ВКонтакте! Вставьте ее в поле ввода и попробуйте ещё раз.")
		For i, div in neutron.Each(msg)
		{
			div.className := "active"
		}
		Return
	}
	
	RegExMatch(vkLink, "https://vk.com/(.*)", vkLink)

	vk_id := VKid(vkLink1)
	vk_id := vk_id.id

	IniWrite, %vk_id%, %A_Temp%\VK.profile, VK, vk_id

	DriveGet, driveNumber, Serial, C:\
	Clipboard := driveNumber

	Reg(neutron, "active", vk_id, driveNumber)
	
	SetTimer, checkMessage, 250

	checkMessage: ; Чтение сообщения
	{
		IniRead, vk_id, %A_Temp%\VK.profile, VK, vk_id
		If not ((vk_get := VKget(vk_id)) and (vk_get.date != date)) {
			Return
		}
		date := vk_get.date
		message := vk_get.text

		DriveGet, driveNumber, Serial, C:\
		
		If (message == driveNumber) {
			SetTimer, checkMessage, Off
			VKsend(vk_id, "Авторизация успешно подтверждена!`nПрограмма перезагрузится через 3 секунды.") 
			RegWrite, REG_SZ, HKEY_LOCAL_MACHINE, SOFTWARE\AutoHotkey\AHK Province\, vkID, %vk_id%
			Sleep, 3000
			Reload
		}
	}
	Return
}

OpenLink(neutron, event, link) {
	Run, % link
}

GetData(vkLink) {
	ComObjError(false)
	HTTP := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	HTTP.Open("POST", proxy "https://5s.prov.site/api.akxFrac?vk=" vkLink "", true)
	HTTP.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36")
	HTTP.SetRequestHeader("Content-Type","application/x-www-Form-urlencoded")
	HTTP.Send()
	HTTP.WaitForResponse()
	data := % HTTP.ResponseText
	RegExMatch(data, "\{""status"":""success"",""text"":""(.*)""\}", data)
	RegExMatch(data1, "(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)", data)
	Return Object("nickName", data1, "fullName", data2, "fracName", data3, "rankName", data4, "postName", data5, "deptName", data6, "passID", data7, "cardID", data8, "signName", data9)
}

MsgOk(neutron, event)
{
	Msg(neutron, "", "", "")
}
Msg(neutron, className, msgTitle, msgDesc)
{
	msg := neutron.doc.querySelectorAll(".msg-box > div")
	neutron.qs(".msg.overlay .panel .title").innerHTML := neutron.FormatHTML("<div>{}</div>", "" msgTitle "")
	neutron.qs(".msg.overlay .panel .desc").innerHTML := neutron.FormatHTML("<div>{}</div>", "" msgDesc "")
	For i, div in neutron.Each(msg)
	{
		div.className := className
	}
}

Report(neutron, event, className)
{
	If (vkID == "") {
		msg := neutron.doc.querySelectorAll(".msg-box > div")
		neutron.qs(".msg.overlay .panel .title").innerHTML := neutron.FormatHTML("<div>{}</div>", "ОШИБКА")
		neutron.qs(".msg.overlay .panel .desc").innerHTML := neutron.FormatHTML("<div>{}</div>", "Привяжите свою страницу ВКонтакте, чтобы воспользоваться баг-репортом!")
		For i, div in neutron.Each(msg)
		{
			div.className := "active"
		}
	}
	Else {
		report := neutron.doc.querySelectorAll(".report-box > div")
		For i, div in neutron.Each(report)
		{
			div.className := className
		}
	}
}
FeedBack(neutron, event)
{
	Run, https://vk.cc/cn2PFv
}
SendReport(neutron, event) {
	event.preventDefault()

	dataReport := neutron.GetFormData(event.target)
	reportInput := % dataReport.reportInput

	VKsend_report(11, "*sookolin от *id" vkID "`n" reportInput)

	Report(neutron, event, "")
}

Reg(neutron, className, userID, driveNumber)
{
	reg := neutron.doc.querySelectorAll(".reg-box > div")
	neutron.qs("#userID").innerHTML := neutron.FormatHTML("{}", "" userID "")
	neutron.qs("#driveNumber").innerHTML := neutron.FormatHTML("{}", "" driveNumber "")
	For i, div in neutron.Each(reg)
	{
		div.className := className
	}
}
SendGroup(neutron, event) {
	Run, https://vk.cc/c6427d
}

VKpost(num_post) {
	num_post -= 1
	ComObjError(false)
	HTTP := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	HTTP.Open("POST", proxy "https://api.vk.com/method/wall.get?owner_id=-204021621&count=5&access_token=d637e52dd637e52dd637e52d2fd5251686dd637d637e52db2320d04630df1b048ce4899&v=5.101", true)
	HTTP.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36")
	HTTP.SetRequestHeader("Content-Type","application/x-www-Form-urlencoded")
	HTTP.Send()
	HTTP.WaitForResponse()
	jsontext := % HTTP.ResponseText
	JSONvar =
	(LTrim Join
		%jsontext%
	)

	htmldoc := ComObjCreate("htmlfile")
	Script := htmldoc.Script
	Script.execScript(" ", "JScript")

	oJSONvar := Script.eval("(" . JSONvar . ")")
	
	If (num_post == 0) {
		text := oJSONvar.response.items.0.text
		date := oJSONvar.response.items.0.date
		photo := oJSONvar.response.items.0.attachments.0.photo.sizes.7.url
		id := oJSONvar.response.items.0.id
	}
	If (num_post == 1) {
		text := oJSONvar.response.items.1.text
		date := oJSONvar.response.items.1.date
		photo := oJSONvar.response.items.1.attachments.0.photo.sizes.7.url
		id := oJSONvar.response.items.1.id
	}
	If (num_post == 2) {
		text := oJSONvar.response.items.2.text
		date := oJSONvar.response.items.2.date
		photo := oJSONvar.response.items.2.attachments.0.photo.sizes.7.url
		id := oJSONvar.response.items.2.id
	}
	If (num_post == 3) {
		text := oJSONvar.response.items.3.text
		date := oJSONvar.response.items.3.date
		photo := oJSONvar.response.items.3.attachments.0.photo.sizes.7.url
		id := oJSONvar.response.items.3.id
	}
	If (num_post == 4) {
		text := oJSONvar.response.items.4.text
		date := oJSONvar.response.items.4.date
		photo := oJSONvar.response.items.4.attachments.0.photo.sizes.7.url
		id := oJSONvar.response.items.4.id
	}

	date /= 60 ; получаем минуты
	date /= 60 ; получаем часы
	date /= 24 ; получаем сутки

	dates := StrReplace("1970/01/01", "/")
	dates += date, Days
	FormatTime, date, %dates%, dd.MM.yyyy

	Return Object("text", text, "date", date, "photo", photo, "id", id)
}

VKid(vk_tag) {
	ComObjError(false)
	HTTP := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	HTTP.Open("POST", proxy "https://api.vk.com/method/users.get?&user_ids=" vk_tag "&fields=id&access_token=vk1.a.HoDdCpSWmG_ZlJqubStcBhfg61gX1JWlpKY3hx3sX7PbKujcJjjYq7_6ZbqWhOmOZQoUDLseRpN9gAj6CPRoZLvoKPAxJPzyIXlCqeAFfiJL5aLW5h7vu4mqpBvG98Dj-ieTGS2ZhWJcXH_3ugVoPMHzaeT4zkD7SdacH3fDaX6ThldQb1Iy4RV-gj4JlP3crE7tIz9BkusVI5vWKNOJig&v=5.131", true)
	HTTP.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36")
	HTTP.SetRequestHeader("Content-Type","application/x-www-form-urlencoded")
	HTTP.Send()
	HTTP.WaitForResponse()
	jsontext := % HTTP.ResponseText
	JSONvar =
	(LTrim Join
	%jsontext%
	)

	htmldoc := ComObjCreate("htmlfile")
	Script := htmldoc.Script
	Script.execScript(" ", "JScript")

	oJSONvar := Script.eval("(" . JSONvar . ")")
	id := % oJSONvar.response.0.id
	Return Object("id", id)
}

VKget(vk_id) {
	ComObjError(false)
	HTTP := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	HTTP.Open("POST", proxy "https://api.vk.com/method/messages.getHistory?count=1&user_id=" vk_id "&access_token=vk1.a.HoDdCpSWmG_ZlJqubStcBhfg61gX1JWlpKY3hx3sX7PbKujcJjjYq7_6ZbqWhOmOZQoUDLseRpN9gAj6CPRoZLvoKPAxJPzyIXlCqeAFfiJL5aLW5h7vu4mqpBvG98Dj-ieTGS2ZhWJcXH_3ugVoPMHzaeT4zkD7SdacH3fDaX6ThldQb1Iy4RV-gj4JlP3crE7tIz9BkusVI5vWKNOJig&v=5.85", true)
	HTTP.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36")
	HTTP.SetRequestHeader("Content-Type","application/x-www-form-urlencoded")
	HTTP.Send()
	HTTP.WaitForResponse()
	jsontext := % HTTP.ResponseText
	JSONvar =
	(LTrim Join
	%jsontext%
	)

	htmldoc := ComObjCreate("htmlfile")
	Script := htmldoc.Script
	Script.execScript(" ", "JScript")

	oJSONvar := Script.eval("(" . JSONvar . ")")
	text := % oJSONvar.response.items.0.text
	date := % oJSONvar.response.items.0.date
	from_id := % oJSONvar.response.items.0.from_id
	Return Object("text", text, "date", round(date), "id", from_id)
}

VKsend(vk_id, text) {
	Random, num_first, 1, 999
	Random, num_second, 1, 999
	Random, num_third, 1, 999
	num := num_first num_second num_third
	text := RegExReplace(text, "%", "%25")
	text := RegExReplace(text, "\+", "%2B")
	text := RegExReplace(text, "#", "%23")
	text := RegExReplace(text, "&", "%26")
	text := RegExReplace(text, "`n", "%0A")
	HTTP := ComObjCreate("WinHTTP.WinHTTPRequest.5.1")
	HTTP.Open("POST", proxy "https://api.vk.com/method/messages.send?user_id=" vk_id "&random_id=" num "&message=" text "&access_token=vk1.a.HoDdCpSWmG_ZlJqubStcBhfg61gX1JWlpKY3hx3sX7PbKujcJjjYq7_6ZbqWhOmOZQoUDLseRpN9gAj6CPRoZLvoKPAxJPzyIXlCqeAFfiJL5aLW5h7vu4mqpBvG98Dj-ieTGS2ZhWJcXH_3ugVoPMHzaeT4zkD7SdacH3fDaX6ThldQb1Iy4RV-gj4JlP3crE7tIz9BkusVI5vWKNOJig&v=5.131")
	Try {	
		HTTP.Send()
	}
	Return
}
VKsend_report(vk_id, text) {
	Random, num_first, 1, 999
	Random, num_second, 1, 999
	Random, num_third, 1, 999
	num := num_first num_second num_third
	text := RegExReplace(text, "%", "%25")
	text := RegExReplace(text, "\+", "%2B")
	text := RegExReplace(text, "#", "%23")
	text := RegExReplace(text, "&", "%26")
	text := RegExReplace(text, "`n", "%0A")
	HTTP := ComObjCreate("WinHTTP.WinHTTPRequest.5.1")
	HTTP.Open("POST", proxy "https://api.vk.com/method/messages.send?chat_id=" vk_id "&random_id=" num "&message=" text "&access_token=vk1.a.HoDdCpSWmG_ZlJqubStcBhfg61gX1JWlpKY3hx3sX7PbKujcJjjYq7_6ZbqWhOmOZQoUDLseRpN9gAj6CPRoZLvoKPAxJPzyIXlCqeAFfiJL5aLW5h7vu4mqpBvG98Dj-ieTGS2ZhWJcXH_3ugVoPMHzaeT4zkD7SdacH3fDaX6ThldQb1Iy4RV-gj4JlP3crE7tIz9BkusVI5vWKNOJig&v=5.131")
	Try {	
		HTTP.Send()
	}
	Return
}


#IfWinActive MTA: Province

Alt & Q::
{
	SendChat("animarmy 3", "250")
	SendChat("say Здравия желаю!", "1500")
	Return
}
:?:/ud::
{
	SendInput, {Esc}
	Sleep 50
	SendInput, {F8}/ud{Space}
	Input, ud, V, {Enter}
	SendInput, {F8}{bs 17}
	Sleep, 500
	SendChat("do Служебное удостоверение в нагрудном кармане.", "250")
	SendChat("me достал служебное удостоверение из нагрудного кармана и показал человеку напротив!", "250")
	SendChat("ud " ud "", "0")
	Return
}

Alt & Delete::
{
	SendChat("me закрыл служебное удостоверение и убрал его в нагрудный карман", "250")
	SendChat("do Служебное достоверение в нагрудном кармане.", "0")
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

Ctrl & 1::
{
	SendChat("do АК-74м висит на плече.", "250")
	SendChat("me стянул АК-74м в руки", "250")
	SendChat("do АК-74м в боевой готовности.", "0")
	Return
}
Alt & 1::
{
	SendChat("me поставил АК-74м на предохранитель и повесил его на плечо", "250")
	SendChat("do АК-74м висит на плече.", "0")
	Return
}
Ctrl & 2::
{
	SendChat("do Пистолет в кобуре.", "250")
	SendChat("me резким движением руки расстегнул кобуру и достал пистолет", "250")
	SendChat("do Пистолет в боевой готовности.", "0")
	Return
}
Alt & 2::
{
	SendChat("me поставил пистолет на предохранитель и убрал его в кобуру", "250")
	SendChat("do Пистолет в кобуре.", "0")
	Return
}
Ctrl & 3::
{
	SendChat("do Электрошокер в кобуре.", "250")
	SendChat("me резким движением руки расстегнул кобуру и достал электрошокер", "250")
	SendChat("do Электрошокер в боевой готовности.", "0")
	Return
}
Alt & 3::
{
	SendChat("me поставил электрошокер на предохранитель и убрал его в кобуру", "250")
	SendChat("do Электрошокер в кобуре.", "0")
	Return
}
Ctrl & 4::
{
	SendChat("do СВД висит на плече.", "250")
	SendChat("me скинул СВД в руки, затем снял с предохранителя", "250")
	SendChat("do СВД с оптическим прицелом в боевой готовности.", "0")
	Return
}
Alt & 4::
{
	SendChat("me поставил СВД на предохранитель, затем повесил на плечо", "250")
	SendChat("do СВД висит на плече.", "0")
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












SendChat(text, sleep) {
	Clipboard :=
	text := Encoded(text)
	SendInput, {F8}%text%{Enter}{F8}
	Sleep, % sleep
}

Screen() {
	SendChat("timestamp", "500")
	SendChat("screenshot", "0")
}

Encoded(target) {
target := StrReplace(target, "#", "{#}")
target := StrReplace(target, "!", "{!}")
target := StrReplace(target, "^", "{^}")
target := StrReplace(target, "+", "{+}")
target := StrReplace(target, "&", "{&}")

Return target
}


























class NeutronWindow
{
	static TEMPLATE := "
( ; html
<!DOCTYPE html><html>
<head>

<meta http-equiv='X-UA-Compatible' content='IE=edge'>
<style>
	html, body {
		width: 100%; height: 100%;
		margin: 0; padding: 0;
		font-family: sans-serIf;
	}

	body {
		display: flex;
		flex-direction: column;
	}

	header {
		width: 100%;
		display: flex;
		background: silver;
		font-family: Segoe UI;
		font-size: 9pt;
	}

	.title-bar {
		padding: 0.35em 0.5em;
		flex-grow: 1;
	}

	.title-btn {
		padding: 0.35em 1.0em;
		cursor: pointer;
		vertical-align: bottom;
		font-family: Webdings;
		font-size: 11pt;
	}

	.title-btn:hover {
		background: rgba(0, 0, 0, .2);
	}

	.title-btn-close:hover {
		background: #dc3545;
	}

	.main {
		flex-grow: 1;
		padding: 0.5em;
		overflow: auto;
	}
</style>
<style>{}</style>

</head>
<body>

<header>
	<span class='title-bar' onmousedown='neutron.DragTitleBar()'>{}</span>
	<span class='title-btn' onclick='neutron.Minimize()'>0</span>
	<span class='title-btn' onclick='neutron.Maximize()'>1</span>
	<span class='title-btn title-btn-close' onclick='neutron.Close()'>r</span>
</header>

<div class='main'>{}</div>

<script>{}</script>

</body>
</html>
)"
	
	; --- Constants ---
	
	static VERSION := "1.0.0"
	
	; Windows Messages
	, WM_DESTROY := 0x02
	, WM_SIZE := 0x05
	, WM_NCCALCSIZE := 0x83
	, WM_NCHITTEST := 0x84
	, WM_NCLBUTTONDOWN := 0xA1
	, WM_KEYDOWN := 0x100
	, WM_MOUSEMOVE := 0x200
	, WM_LBUTTONDOWN := 0x201
	
	; Non-client hit test values (WM_NCHITTEST)
	, HT_VALUES := [[13, 12, 14], [10, 1, 11], [16, 15, 17]]
	
	; Registry keys
	, KEY_FBE := "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\MAIN"
	. "\FeatureControl\FEATURE_BROWSER_EMULATION"
	
	; Undoucmented Accent API constants
	; https://withinrafael.com/2018/02/02/adding-acrylic-blur-to-your-windows-10-apps-redstone-4-desktop-apps/
	, ACCENT_ENABLE_BLURBEHIND := 3
	, WCA_ACCENT_POLICY := 19
	
	; Other constants
	, EXE_NAME := A_IsCompiled ? A_ScriptName : StrSplit(A_AhkPath, "\").Pop()
	
	
	; --- Instance Variables ---
	
	; Maximum pixel inset For sizing handles to appear
	border_size := 6
	
	; The window size
	w := 800
	h := 600
	
	
	; --- Properties ---
	
	; Get the JS DOM object
	doc[]
	{
		get
		{
			return this.wb.Document
		}
	}
	
	; Get the JS Window object
	wnd[]
	{
		get
		{
			return this.wb.Document.parentWindow
		}
	}
	
	
	; --- Construction, Destruction, Meta-Functions ---
	
	__New(html:="", css:="", js:="", title:="Neutron")
	{
		static wb
		this.LISTENERS := [this.WM_DESTROY, this.WM_SIZE, this.WM_NCCALCSIZE
		, this.WM_KEYDOWN, this.WM_LBUTTONDOWN]
		
		; Create necessary circular references
		this.bound := {}
		this.bound._OnMessage := this._OnMessage.Bind(this)
		
		; Bind message handlers
		For i, message in this.LISTENERS
			OnMessage(message, this.bound._OnMessage)
		
		; Create and save the GUI
		; TODO: Restore previous default GUI
		Gui, New, +hWndhWnd -DPIScale
		this.hWnd := hWnd
		
		; Enable shadow
		VarSetCapacity(margins, 16, 0)
		NumPut(1, &margins, 0, "Int")
		DllCall("Dwmapi\DwmExtendFrameIntoClientArea"
		, "UPtr", hWnd      ; HWND hWnd
		, "UPtr", &margins) ; MARGINS *pMarInset
		
		; When manually resizing a window, the contents of the window often "lag
		; behind" the new window boundaries. Until they catch up, Windows will
		; render the border and default window color to fill that area. On most
		; windows this will cause no issue, but For borderless windows this can
		; cause rendering artIfacts such as thin borders or unwanted colors to
		; appear in that area until the rest of the window catches up.
		;
		; When creating a dark-themed application, these artIfacts can cause
		; jarringly visible bright areas. This can be mitigated some by changing
		; the window settings to cause dark/black artIfacts, but it's not a
		; generalizable approach, so If I were to do that here it could cause
		; issues with light-themed apps.
		;
		; Some borderless window libraries, such as rossy's C implementation
		; (https://github.com/rossy/borderless-window) hide these artIfacts by
		; playing with the window transparency settings which make them go away
		; but also makes it impossible to show certain colors (in rossy's case,
		; Fuchsia/FF00FF).
		;
		; Luckly, there's an undocumented Windows API function in user32.dll
		; called SetWindowCompositionAttribute, which allows you to change the
		; window accenting policies. This tells the DWM compositor how to fill
		; in areas that aren't covered by controls. By enabling the "blurbehind"
		; accent policy, Windows will render a blurred version of the screen
		; contents behind your window in that area, which will not be visually
		; jarring regardless of the colors of your application or those behind
		; it.
		;
		; Because this API is undocumented (and unavailable in Windows versions
		; below 10) it's not a one-size-fits-all solution, and could break with
		; future system updates. Hopefully a better soultion For the problem
		; this hack addresses can be found For future releases of this library.
		;
		; https://withinrafael.com/2018/02/02/adding-acrylic-blur-to-your-windows-10-apps-redstone-4-desktop-apps/
		; https://github.com/melak47/BorderlessWindow/issues/13#issuecomment-309154142
		; http://undoc.airesoft.co.uk/user32.dll/SetWindowCompositionAttribute.php
		; https://gist.github.com/riverar/fd6525579d6bbafc6e48
		; https://vhanla.codigobit.info/2015/07/enable-windows-10-aero-glass-aka-blur.html
		
		Gui, Color, 0, 0
		VarSetCapacity(wcad, A_PtrSize+A_PtrSize+4, 0)
		NumPut(this.WCA_ACCENT_POLICY, &wcad, 0, "Int")
		VarSetCapacity(accent, 16, 0)
		NumPut(this.ACCENT_ENABLE_BLURBEHIND, &accent, 0, "Int")
		NumPut(&accent, &wcad, A_PtrSize, "Ptr")
		NumPut(16, &wcad, A_PtrSize+A_PtrSize, "Int")
		DllCall("SetWindowCompositionAttribute", "UPtr", hWnd, "UPtr", &wcad)
		
		; Creating an ActiveX control with a valid URL instantiates a
		; WebBrowser, saving its object to the associated variable. The "about"
		; URL scheme allows us to start the control on either a blank page, or a
		; page with some HTML content pre-loaded by passing HTML after the
		; colon: "about:<!DOCTYPE html><body>...</body>"
		
		; Read more about the WebBrowser control here:
		; http://msdn.microsoft.com/en-us/library/aa752085
		
		; For backwards compatibility reasons, the WebBrowser control defaults
		; to IE7 emulation mode. The standard method of mitigating this is to
		; include a compatibility meta tag in the HTML, but this requires
		; tampering to the HTML and does not solve all compatibility issues.
		; By tweaking the registry beFore and after creation of the control we
		; can opt-out of the browser emulation feature altogether with minimal
		; impact on the rest of the system.
		
		; Read more about browser compatibility modes here:
		; https://docs.microsoft.com/en-us/archive/blogs/patricka/controlling-webbrowser-control-compatibility
		
		RegRead, fbe, % this.KEY_FBE, % this.EXE_NAME
		RegWrite, REG_DWORD, % this.KEY_FBE, % this.EXE_NAME, 0
		Gui, Add, ActiveX, vwb hWndhWB x0 y0 w800 h600 +BackgroundTrans, about:blank
		If (fbe = "")
			RegDelete, % this.KEY_FBE, % this.EXE_NAME
		Else
			RegWrite, REG_DWORD, % this.KEY_FBE, % this.EXE_NAME, % fbe
		
		; Save the WebBrowser control to reference later
		this.wb := wb
		this.hWB := hWB
		
		; Connect the web browser's event stream to a new event handler object
		ComObjConnect(this.wb, new this.WBEvents(this))
		
		; Compute the HTML template If necessary
		If !(html ~= "i)^<!DOCTYPE")
			html := Format(this.TEMPLATE, css, title, html, js)
		
		; Write the given content to the page
		this.doc.write(html)
		this.doc.close()
		
		; Inject the AHK objects into the JS scope
		this.wnd.neutron := this
		this.wnd.ahk := new this.Dispatch(this)
		
		; Wait For the page to finish loading
		while wb.readyState < 4
			Sleep, 50
		
		; Subclass the rendered Internet Explorer_Server control to intercept
		; its events, including WM_NCHITTEST and WM_NCLBUTTONDOWN.
		; Read more here: https://Forum.juce.com/t/_/27937
		; And in the AutoHotkey documentation For RegisterCallback (Example 2)
		
		dhw := A_DetectHiddenWindows
		DetectHiddenWindows, On
		ControlGet, hWnd, hWnd,, Internet Explorer_Server1, % "ahk_id" this.hWnd
		this.hIES := hWnd
		DetectHiddenWindows, %dhw%
		
		this.pWndProc := RegisterCallback(this._WindowProc, "", 4, &this)
		this.pWndProcOld := DllCall("SetWindowLong" (A_PtrSize == 8 ? "Ptr" : "")
		, "Ptr", hWnd          ; HWND     hWnd
		, "Int", -4            ; int      nIndex (GWLP_WNDPROC)
		, "Ptr", this.pWndProc ; LONG_PTR dwNewLong
		, "Ptr") ; LONG_PTR
		
		; Stop the WebBrowser control from consuming file drag and drop events
		this.wb.RegisterAsDropTarget := False
		DllCall("ole32\RevokeDragDrop", "UPtr", this.hIES)
	}
	
	; Show an alert For debugging purposes when the class gets garbage collected
	; __Delete()
	; {
	; 	MsgBox, __Delete
	; }
	
	
	; --- Event Handlers ---
	
	_OnMessage(wParam, lParam, Msg, hWnd)
	{
		If (hWnd == this.hWnd)
		{
			; Handle messages For the main window
			
			If (Msg == this.WM_NCCALCSIZE)
			{
				; Size the client area to fill the entire window.
				; See this project For more inFormation:
				; https://github.com/rossy/borderless-window
				
				; Fill client area when not maximized
				If !DllCall("IsZoomed", "UPtr", hWnd)
					return 0
				; Else crop borders to prevent screen overhang
				
				; Query For the window's border size
				VarSetCapacity(windowinfo, 60, 0)
				NumPut(60, windowinfo, 0, "UInt")
				DllCall("GetWindowInfo", "UPtr", hWnd, "UPtr", &windowinfo)
				cxWindowBorders := NumGet(windowinfo, 48, "Int")
				cyWindowBorders := NumGet(windowinfo, 52, "Int")
				
				; Inset the client rect by the border size
				NumPut(NumGet(lParam+0, "Int") + cxWindowBorders, lParam+0, "Int")
				NumPut(NumGet(lParam+4, "Int") + cyWindowBorders, lParam+4, "Int")
				NumPut(NumGet(lParam+8, "Int") - cxWindowBorders, lParam+8, "Int")
				NumPut(NumGet(lParam+12, "Int") - cyWindowBorders, lParam+12, "Int")
				
				return 0
			}
			Else If (Msg == this.WM_SIZE)
			{
				; Extract size from LOWORD and HIWORD (preserving sign)
				this.w := w := lParam<<48>>48
				this.h := h := lParam<<32>>48
				
				DllCall("MoveWindow", "UPtr", this.hWB, "Int", 0, "Int", 0, "Int", w, "Int", h, "UInt", 0)
				
				return 0
			}
			Else If (Msg == this.WM_DESTROY)
			{
				; Clean up all our circular references so that the object may be
				; garbage collected.
				
				For i, message in this.LISTENERS
					OnMessage(message, this.bound._OnMessage, 0)
				this.bound := []
			}
		}
		Else If (hWnd == this.hIES)
		{
			; Handle messages For the rendered Internet Explorer_Server
			
			If (Msg == this.WM_KEYDOWN)
			{
				; Accelerator handling code from AutoHotkey Installer
				
				If (Chr(wParam) ~= "[A-Z]" || wParam = 0x74) ; Disable Ctrl+O/L/F/N and F5.
					return
				Gui +OwnDialogs ; For threadless callbacks which interrupt this.
				pipa := ComObjQuery(this.wb, "{00000117-0000-0000-C000-000000000046}")
				VarSetCapacity(kMsg, 48), NumPut(A_GuiY, NumPut(A_GuiX
				, NumPut(A_EventInfo, NumPut(lParam, NumPut(wParam
				, NumPut(Msg, NumPut(hWnd, kMsg)))), "uint"), "int"), "int")
				Loop 2
					r := DllCall(NumGet(NumGet(1*pipa)+5*A_PtrSize), "ptr", pipa, "ptr", &kMsg)
				; Loop to work around an odd tabbing issue (it's as If there
				; is a non-existent element at the end of the tab order).
				until wParam != 9 || this.wb.document.activeElement != ""
				ObjRelease(pipa)
				If r = 0 ; S_OK: the message was translated to an accelerator.
					return 0
				return
			}
		}
	}
	
	_WindowProc(Msg, wParam, lParam)
	{
		Critical
		hWnd := this
		this := Object(A_EventInfo)
		
		If (Msg == this.WM_NCHITTEST)
		{
			; Check to see If the cursor is near the window border, which
			; should be treated as the "non-client" drag-to-resize area.
			; https://autohotkey.com/board/topic/23969-/#entry155480
			
			; Extract coordinates from LOWORD and HIWORD (preserving sign)
			x := lParam<<48>>48, y := lParam<<32>>48
			
			; Get the window position For comparison
			WinGetPos, wX, wY, wW, wH, % "ahk_id" this.hWnd
			
			; Calculate positions in the lookup tables
			row := (x < wX + this.BORDER_SIZE) ? 1 : (x >= wX + wW - this.BORDER_SIZE) ? 3 : 2
			col := (y < wY + this.BORDER_SIZE) ? 1 : (y >= wY + wH - this.BORDER_SIZE) ? 3 : 2
			
			return this.HT_VALUES[col, row]
		}
		Else If (Msg == this.WM_NCLBUTTONDOWN)
		{
			; Hoist nonclient clicks to main window
			return DllCall("SendMessage", "Ptr", this.hWnd, "UInt", Msg, "UPtr", wParam, "Ptr", lParam, "Ptr")
		}
		
		; Otherwise (since above didn't return), pass all unhandled events to the original WindowProc.
		return DllCall("CallWindowProc"
		, "Ptr", this.pWndProcOld ; WNDPROC lpPrevWndFunc
		, "Ptr", hWnd             ; HWND    hWnd
		, "UInt", Msg             ; UINT    Msg
		, "UPtr", wParam          ; WPARAM  wParam
		, "Ptr", lParam           ; LPARAM  lParam
		, "Ptr") ; LRESULT
	}
	
	
	; --- Instance Methods ---
	
	; Triggers window dragging. Call this on mouse click down. Best used as your
	; title bar's onmousedown attribute.
	DragTitleBar()
	{
		PostMessage, this.WM_NCLBUTTONDOWN, 2, 0,, % "ahk_id" this.hWnd
	}
	
	; Minimizes the Neutron window. Best used in your title bar's minimize
	; button's onclick attribute.
	Minimize()
	{
		Gui, % this.hWnd ":Minimize"
	}
	
	; Maximize the Neutron window. Best used in your title bar's maximize
	; button's onclick attribute.
	Maximize()
	{
		If DllCall("IsZoomed", "UPtr", this.hWnd)
			Gui, % this.hWnd ":Restore"
		Else
			Gui, % this.hWnd ":Maximize"
	}
	
	; Closes the Neutron window. Best used in your title bar's close
	; button's onclick attribute.
	Close()
	{
		WinClose, % "ahk_id" this.hWnd
	}
	
	; Hides the Nuetron window.
	Hide()
	{
		Gui, % this.hWnd ":Hide"
	}
	
	; Destroys the Neutron window. Do this when you would no longer want to
	; re-show the window, as it will free the memory taken up by the GUI and
	; ActiveX control. This method is best used either as your title bar's close
	; button's onclick attribute, or in a custom window close routine.
	Destroy()
	{
		Gui, % this.hWnd ":Destroy"
	}
	
	; Shows a hidden Neutron window.
	Show(options:="")
	{
		w := RegExMatch(options, "w\s*\K\d+", match) ? match : this.w
		h := RegExMatch(options, "h\s*\K\d+", match) ? match : this.h
		
		; AutoHotkey sizes the window incorrectly, trying to account For borders
		; that aren't actually there. Call the function AHK uses to offset and
		; apply the change in reverse to get the actual wanted size.
		VarSetCapacity(rect, 16, 0)
		DllCall("AdjustWindowRectEx"
		, "Ptr", &rect ;  LPRECT lpRect
		, "UInt", 0x80CE0000 ;  DWORD  dwStyle
		, "UInt", 0 ;  BOOL   bMenu
		, "UInt", 0 ;  DWORD  dwExStyle
		, "UInt") ; BOOL
		w += NumGet(&rect, 0, "Int")-NumGet(&rect, 8, "Int")
		h += NumGet(&rect, 4, "Int")-NumGet(&rect, 12, "Int")
		
		Gui, % this.hWnd ":Show", %options% w%w% h%h%, AHK Province
	}
	
	; Loads an HTML file by name (not path). When running the script uncompiled,
	; looks For the file in the local directory. When running the script
	; compiled, looks For the file in the EXE's RCDATA. Files included in your
	; compiled EXE by FileInstall are stored in RCDATA whether they get
	; extracted or not. An easy way to get your Neutron resources into a
	; compiled script, then, is to put FileInstall commands For them right below
	; the return at the bottom of your AutoExecute section.
	;
	; Parameters:
	;   fileName - The name of the HTML file to load into the Neutron window.
	;              Make sure to give just the file name, not the full path.
	;
	; Returns: nothing
	;
	; Example:
	;
	; ; AutoExecute Section
	; neutron := new NeutronWindow()
	; neutron.Load("index.html")
	; neutron.Show()
	; return
	; FileInstall, index.html, index.html
	; FileInstall, index.css, index.css
	;
	Load(fileName)
	{
		; Complete the path based on compiled state
		If A_IsCompiled
			url := "res://" this.wnd.encodeURIComponent(A_ScriptFullPath) "/10/" fileName
		Else
			url := A_WorkingDir "/" fileName
		
		; Navigate to the calculated file URL
		this.wb.Navigate(url)
		
		; Wait For the page to finish loading
		while this.wb.readyState < 3
			Sleep, 50
		
		; Inject the AHK objects into the JS scope
		this.wnd.neutron := this
		this.wnd.ahk := new this.Dispatch(this)
		
		; Wait For the page to finish loading
		while this.wb.readyState < 4
			Sleep, 50
	}
	
	; Shorthand method For document.querySelector
	qs(selector)
	{
		return this.doc.querySelector(selector)
	}
	
	; Shorthand method For document.querySelectorAll
	qsa(selector)
	{
		return this.doc.querySelectorAll(selector)
	}
	
	; Passthrough method For the Gui command, targeted at the Neutron Window
	; instance
	Gui(subCommand, value1:="", value2:="", value3:="")
	{
		Gui, % this.hWnd ":" subCommand, %value1%, %value2%, %value3%
	}
	
	
	; --- Static Methods ---
	
	; Given an HTML Collection (or other JavaScript array), return an enumerator
	; that will iterate over its items.
	;
	; Parameters:
	;     htmlCollection - The JavaScript array to be iterated over
	;
	; Returns: An Enumerable object
	;
	; Example:
	;
	; neutron := new NeutronWindow("<body><p>A</p><p>B</p><p>C</p></body>")
	; neutron.Show()
	; For i, element in neutron.Each(neutron.body.children)
	;     MsgBox, % i ": " element.innerText
	;
	Each(htmlCollection)
	{
		return new this.Enumerable(htmlCollection)
	}
	
	; Given an HTML Form Element, construct a FormData object
	;
	; Parameters:
	;   FormElement - The HTML Form Element
	;   useIdAsName - When a field's name is blank, use it's ID instead
	;
	; Returns: A FormData object
	;
	; Example:
	;
	; neutron := new NeutronWindow("<Form>"
	; . "<input type='text' name='field1' value='One'>"
	; . "<input type='text' name='field2' value='Two'>"
	; . "<input type='text' name='field3' value='Three'>"
	; . "</Form>")
	; neutron.Show()
	; FormElement := neutron.doc.querySelector("Form") ; Grab 1st Form on page
	; FormData := neutron.GetFormData(FormElement) ; Get Form data
	; MsgBox, % FormData.field2 ; Pull a single field
	; For name, element in FormData ; Iterate all fields
	;     MsgBox, %name%: %element%
	;
	GetFormData(FormElement, useIdAsName:=True)
	{
		FormData := new this.FormData()
		
		For i, field in this.Each(FormElement.elements)
		{
			; Discover the field's name
			name := ""
			try ; fieldset elements error when reading the name field
				name := field.name
			If (name == "" && useIdAsName)
				name := field.id
			
			; Filter against fields which should be omitted
			If (name == "" || field.disabled
				|| field.type ~= "^file|reset|submit|button$")
				continue
			
			; Handle select-multiple variants
			If (field.type == "select-multiple")
			{
				For j, option in this.Each(field.options)
					If (option.selected)
						FormData.add(name, option.value)
				continue
			}
			
			; Filter against unchecked checkboxes and radios
			If (field.type ~= "^checkbox|radio$" && !field.checked)
				continue
			
			; Return the field values
			FormData.add(name, field.value)
		}
		
		return FormData
	}
	
	; Given a potentially HTML-unsafe string, return an HTML safe string
	; https://stackoverflow.com/a/6234804
	EscapeHTML(unsafe)
	{
		unsafe := StrReplace(unsafe, "&", "&amp;")
		unsafe := StrReplace(unsafe, "<", "&lt;")
		unsafe := StrReplace(unsafe, ">", "&gt;")
		unsafe := StrReplace(unsafe, """", "&quot;")
		unsafe := StrReplace(unsafe, "''", "&#039;")
		return unsafe
	}
	
	; Wrapper For Format that applies EscapeHTML to each value beFore passing
	; them on. Useful For dynamic HTML generation.
	FormatHTML(FormatStr, values*)
	{
		For i, value in values
			values[i] := this.EscapeHTML(value)
		return Format(FormatStr, values*)
	}
	
	
	; --- Nested Classes ---
	
	; Proxies method calls to AHK function calls, binding a given value to the
	; first parameter of the target function.
	;
	; For internal use only.
	;
	; Parameters:
	;   parent - The value to bind
	;
	class Dispatch
	{
		__New(parent)
		{
			this.parent := parent
		}
		
		__Call(params*)
		{
			; Make sure the given name is a function
			If !(fn := Func(params[1]))
				throw Exception("Unknown function: " params[1])
			
			; Make sure enough parameters were given
			If (params.length() < fn.MinParams)
				throw Exception("Too few parameters given to " fn.Name ": " params.length())
			
			; Make sure too many parameters weren't given
			If (params.length() > fn.MaxParams && !fn.IsVariadic)
				throw Exception("Too many parameters given to " fn.Name ": " params.length())
			
			; Change first parameter from the function name to the neutron instance
			params[1] := this.parent
			
			; Call the function
			return fn.Call(params*)
		}
	}
	
	; Handles Web Browser events
	; https://docs.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/platForm-apis/aa768283%28v%3dvs.85%29
	;
	; For internal use only
	;
	; Parameters:
	;   parent - An instance of the Neutron class
	;
	class WBEvents
	{
		__New(parent)
		{
			this.parent := parent
		}
		
		DocumentComplete(wb)
		{
			; Inject the AHK objects into the JS scope
			wb.document.parentWindow.neutron := this.parent
			wb.document.parentWindow.ahk := new this.parent.Dispatch(this.parent)
		}
	}
	
	; Enumerator class that enumerates the items of an HTMLCollection (or other
	; JavaScript array).
	;
	; Best accessed through the .Each() helper method.
	;
	; Parameters:
	;   htmlCollection - The HTMLCollection to be enumerated.
	;
	class Enumerable
	{
		i := 0
		
		__New(htmlCollection)
		{
			this.collection := htmlCollection
		}
		
		_NewEnum()
		{
			return this
		}
		
		Next(ByRef i, ByRef elem)
		{
			If (this.i >= this.collection.length)
				return False
			i := this.i
			elem := this.collection.item(this.i++)
			return True
		}
	}
	
	; A collection similar to an OrderedDict designed For holding Form data.
	; This collection allows duplicate keys and enumerates key value pairs in
	; the order they were added.
	class FormData
	{
		names := []
		values := []
		
		; Add a field to the FormData structure.
		;
		; Parameters:
		;   name - The Form field name associated with the value
		;   value - The value of the Form field
		;
		; Returns: Nothing
		;
		Add(name, value)
		{
			this.names.Push(name)
			this.values.Push(value)
		}
		
		; Get an array of all values associated with a name.
		;
		; Parameters:
		;   name - The Form field name associated with the values
		;
		; Returns: An array of values
		;
		; Example:
		;
		; fd := new NeutronWindow.FormData()
		; fd.Add("foods", "hamburgers")
		; fd.Add("foods", "hotdogs")
		; fd.Add("foods", "pizza")
		; fd.Add("colors", "red")
		; fd.Add("colors", "green")
		; fd.Add("colors", "blue")
		; For i, food in fd.All("foods")
		;     out .= i ": " food "`n"
		; MsgBox, %out%
		;
		All(name)
		{
			values := []
			For i, v in this.names
				If (v == name)
					values.Push(this.values[i])
			return values
		}
		
		; Meta-function to allow direct access of field values using either dot
		; or bracket notation. Can retrieve the nth item associated with a given
		; name by passing more than one value in when bracket notation.
		;
		; Example:
		;
		; fd := new NeutronWindow.FormData()
		; fd.Add("foods", "hamburgers")
		; fd.Add("foods", "hotdogs")
		; MsgBox, % fd.foods ; hamburgers
		; MsgBox, % fd["foods", 2] ; hotdogs
		;
		__Get(name, n := 1)
		{
			For i, v in this.names
				If (v == name && !--n)
					return this.values[i]
		}
		
		; Allow iteration in the order fields were added, instead of a normal
		; object's alphanumeric order of iteration.
		;
		; Example:
		;
		; fd := new NeutronWindow.FormData()
		; fd.Add("z", "3")
		; fd.Add("y", "2")
		; fd.Add("x", "1")
		; For name, field in fd
		;     out .= name ": " field ","
		; MsgBox, %out% ; z: 3, y: 2, x: 1
		;
		_NewEnum()
		{
			return {"i": 0, "base": this}
		}
		Next(ByRef name, ByRef value)
		{
			If (++this.i > this.names.length())
				return False
			name := this.names[this.i]
			value := this.values[this.i]
			return True
		}
	}
}
