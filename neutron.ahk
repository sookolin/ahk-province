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
		font-family: sans-serif;
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
	
	, HT_VALUES := [[13, 12, 14], [10, 1, 11], [16, 15, 17]]
	
	; Registry keys
	, KEY_FBE := "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\MAIN"
	. "\FeatureControl\FEATURE_BROWSER_EMULATION"
	
	, ACCENT_ENABLE_BLURBEHIND := 3
	, WCA_ACCENT_POLICY := 19
	
	; Other constants
	, EXE_NAME := A_IsCompiled ? A_ScriptName : StrSplit(A_AhkPath, "\").Pop()
	
	
	border_size := 6
	
	; The window size
	w := 800
	h := 600
	
	doc[]
	{
		get
		{
			return this.wb.Document
		}
	}
	
	wnd[]
	{
		get
		{
			return this.wb.Document.parentWindow
		}
	}
	
	
	__New(html:="", css:="", js:="", title:="Neutron")
	{
		static wb
		this.LISTENERS := [this.WM_DESTROY, this.WM_SIZE, this.WM_NCCALCSIZE
		, this.WM_KEYDOWN, this.WM_LBUTTONDOWN]
		
		this.bound := {}
		this.bound._OnMessage := this._OnMessage.Bind(this)
		
		for i, message in this.LISTENERS
			OnMessage(message, this.bound._OnMessage)
		
		Gui, New, +hWndhWnd -Resize -DPIScale
		this.hWnd := hWnd
		
		VarSetCapacity(margins, 16, 0)
		NumPut(1, &margins, 0, "Int")
		DllCall("Dwmapi\DwmExtendFrameIntoClientArea"
		, "UPtr", hWnd      ; HWND hWnd
		, "UPtr", &margins) ; MARGINS *pMarInset
		
		
		Gui, Color, 0, 0
		VarSetCapacity(wcad, A_PtrSize+A_PtrSize+4, 0)
		NumPut(this.WCA_ACCENT_POLICY, &wcad, 0, "Int")
		VarSetCapacity(accent, 16, 0)
		NumPut(this.ACCENT_ENABLE_BLURBEHIND, &accent, 0, "Int")
		NumPut(&accent, &wcad, A_PtrSize, "Ptr")
		NumPut(16, &wcad, A_PtrSize+A_PtrSize, "Int")
		DllCall("SetWindowCompositionAttribute", "UPtr", hWnd, "UPtr", &wcad)
		
		
		RegRead, fbe, % this.KEY_FBE, % this.EXE_NAME
		RegWrite, REG_DWORD, % this.KEY_FBE, % this.EXE_NAME, 0
		Gui, Add, ActiveX, vwb hWndhWB x0 y0 w800 h600, about:blank
		if (fbe = "")
			RegDelete, % this.KEY_FBE, % this.EXE_NAME
		else
			RegWrite, REG_DWORD, % this.KEY_FBE, % this.EXE_NAME, % fbe
		
		this.wb := wb
		this.hWB := hWB
		
		ComObjConnect(this.wb, new this.WBEvents(this))
		
		if !(html ~= "i)^<!DOCTYPE")
			html := Format(this.TEMPLATE, css, title, html, js)
		
		this.doc.write(html)
		this.doc.close()
		
		this.wnd.neutron := this
		this.wnd.ahk := new this.Dispatch(this)
		
		; Wait for the page to finish loading
		while wb.readyState < 4
			Sleep, 50
		
		
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
	
	
	_OnMessage(wParam, lParam, Msg, hWnd)
	{
		if (hWnd == this.hWnd)
		{
			
			if (Msg == this.WM_NCCALCSIZE)
			{
				if !DllCall("IsZoomed", "UPtr", hWnd)
					return 0
				
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
			else if (Msg == this.WM_SIZE)
			{
				; Extract size from LOWORD and HIWORD (preserving sign)
				this.w := w := lParam<<48>>48
				this.h := h := lParam<<32>>48
				
				DllCall("MoveWindow", "UPtr", this.hWB, "Int", 0, "Int", 0, "Int", w, "Int", h, "UInt", 0)
				
				return 0
			}
			else if (Msg == this.WM_DESTROY)
			{
				for i, message in this.LISTENERS
					OnMessage(message, this.bound._OnMessage, 0)
				this.bound := []
			}
		}
		else if (hWnd == this.hIES)
		{
			; Handle messages for the rendered Internet Explorer_Server
			
			if (Msg == this.WM_KEYDOWN)
			{
				; Accelerator handling code from AutoHotkey Installer
				
				if (Chr(wParam) ~= "[A-Z]" || wParam = 0x74) ; Disable Ctrl+O/L/F/N and F5.
					return
				Gui +OwnDialogs ; For threadless callbacks which interrupt this.
				pipa := ComObjQuery(this.wb, "{00000117-0000-0000-C000-000000000046}")
				VarSetCapacity(kMsg, 48), NumPut(A_GuiY, NumPut(A_GuiX
				, NumPut(A_EventInfo, NumPut(lParam, NumPut(wParam
				, NumPut(Msg, NumPut(hWnd, kMsg)))), "uint"), "int"), "int")
				Loop 2
					r := DllCall(NumGet(NumGet(1*pipa)+5*A_PtrSize), "ptr", pipa, "ptr", &kMsg)
				; Loop to work around an odd tabbing issue (it's as if there
				; is a non-existent element at the end of the tab order).
				until wParam != 9 || this.wb.document.activeElement != ""
				ObjRelease(pipa)
				if r = 0 ; S_OK: the message was translated to an accelerator.
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
		
		if (Msg == this.WM_NCHITTEST)
		{
			x := lParam<<48>>48, y := lParam<<32>>48
			
			; Get the window position for comparison
			WinGetPos, wX, wY, wW, wH, % "ahk_id" this.hWnd
			
			; Calculate positions in the lookup tables
			row := (x < wX + this.BORDER_SIZE) ? 1 : (x >= wX + wW - this.BORDER_SIZE) ? 3 : 2
			col := (y < wY + this.BORDER_SIZE) ? 1 : (y >= wY + wH - this.BORDER_SIZE) ? 3 : 2
			
			return this.HT_VALUES[col, row]
		}
		else if (Msg == this.WM_NCLBUTTONDOWN)
		{
			; Hoist nonclient clicks to main window
			return DllCall("SendMessage", "Ptr", this.hWnd, "UInt", Msg, "UPtr", wParam, "Ptr", lParam, "Ptr")
		}
		
		return DllCall("CallWindowProc"
		, "Ptr", this.pWndProcOld ; WNDPROC lpPrevWndFunc
		, "Ptr", hWnd             ; HWND    hWnd
		, "UInt", Msg             ; UINT    Msg
		, "UPtr", wParam          ; WPARAM  wParam
		, "Ptr", lParam           ; LPARAM  lParam
		, "Ptr") ; LRESULT
	}
	
	
	DragTitleBar()
	{
		PostMessage, this.WM_NCLBUTTONDOWN, 2, 0,, % "ahk_id" this.hWnd
	}
	
	Minimize()
	{
		Gui, % this.hWnd ":Minimize"
	}
	
	Maximize()
	{
		if DllCall("IsZoomed", "UPtr", this.hWnd)
			Gui, % this.hWnd ":Restore"
		else
			Gui, % this.hWnd ":Maximize"
	}
	
	Close()
	{
		WinClose, % "ahk_id" this.hWnd
	}
	
	; Hides the Nuetron window.
	Hide()
	{
		Gui, % this.hWnd ":Hide"
	}
	
	Destroy()
	{
		Gui, % this.hWnd ":Destroy"
	}
	
	; Shows a hidden Neutron window.
	Show(options:="")
	{
		w := RegExMatch(options, "w\s*\K\d+", match) ? match : this.w
		h := RegExMatch(options, "h\s*\K\d+", match) ? match : this.h
		
		; AutoHotkey sizes the window incorrectly, trying to account for borders
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
		
		Gui, % this.hWnd ":Show", %options% w%w% h%h%
	}
	
	Load(fileName)
	{
		; Complete the path based on compiled state
		if A_IsCompiled
			url := "res://" this.wnd.encodeURIComponent(A_ScriptFullPath) "/10/" fileName
		else
			url := A_WorkingDir "/" fileName
		
		; Navigate to the calculated file URL
		this.wb.Navigate(url)
		
		; Wait for the page to finish loading
		while this.wb.readyState < 3
			Sleep, 50
		
		; Inject the AHK objects into the JS scope
		this.wnd.neutron := this
		this.wnd.ahk := new this.Dispatch(this)
		
		; Wait for the page to finish loading
		while this.wb.readyState < 4
			Sleep, 50
	}
	
	qs(selector)
	{
		return this.doc.querySelector(selector)
	}
	
	qsa(selector)
	{
		return this.doc.querySelectorAll(selector)
	}
	
	Gui(subCommand, value1:="", value2:="", value3:="")
	{
		Gui, % this.hWnd ":" subCommand, %value1%, %value2%, %value3%
	}
	
	
	Each(htmlCollection)
	{
		return new this.Enumerable(htmlCollection)
	}
	
	GetFormData(formElement, useIdAsName:=True)
	{
		formData := new this.FormData()
		
		for i, field in this.Each(formElement.elements)
		{
			; Discover the field's name
			name := ""
			try ; fieldset elements error when reading the name field
				name := field.name
			if (name == "" && useIdAsName)
				name := field.id
			
			; Filter against fields which should be omitted
			if (name == "" || field.disabled
				|| field.type ~= "^file|reset|submit|button$")
				continue
			
			; Handle select-multiple variants
			if (field.type == "select-multiple")
			{
				for j, option in this.Each(field.options)
					if (option.selected)
						formData.add(name, option.value)
				continue
			}
			
			; Filter against unchecked checkboxes and radios
			if (field.type ~= "^checkbox|radio$" && !field.checked)
				continue
			
			; Return the field values
			formData.add(name, field.value)
		}
		
		return formData
	}
	
	EscapeHTML(unsafe)
	{
		unsafe := StrReplace(unsafe, "&", "&amp;")
		unsafe := StrReplace(unsafe, "<", "&lt;")
		unsafe := StrReplace(unsafe, ">", "&gt;")
		unsafe := StrReplace(unsafe, """", "&quot;")
		unsafe := StrReplace(unsafe, "''", "&#039;")
		return unsafe
	}
	
	; Wrapper for Format that applies EscapeHTML to each value before passing
	; them on. Useful for dynamic HTML generation.
	FormatHTML(formatStr, values*)
	{
		for i, value in values
			values[i] := this.EscapeHTML(value)
		return Format(formatStr, values*)
	}
	

	class Dispatch
	{
		__New(parent)
		{
			this.parent := parent
		}
		
		__Call(params*)
		{
			; Make sure the given name is a function
			if !(fn := Func(params[1]))
				throw Exception("Unknown function: " params[1])
			
			; Make sure enough parameters were given
			if (params.length() < fn.MinParams)
				throw Exception("Too few parameters given to " fn.Name ": " params.length())
			
			; Make sure too many parameters weren't given
			if (params.length() > fn.MaxParams && !fn.IsVariadic)
				throw Exception("Too many parameters given to " fn.Name ": " params.length())
			
			; Change first parameter from the function name to the neutron instance
			params[1] := this.parent
			
			; Call the function
			return fn.Call(params*)
		}
	}
	
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
			if (this.i >= this.collection.length)
				return False
			i := this.i
			elem := this.collection.item(this.i++)
			return True
		}
	}
	
	class FormData
	{
		names := []
		values := []
		
		Add(name, value)
		{
			this.names.Push(name)
			this.values.Push(value)
		}
		
		All(name)
		{
			values := []
			for i, v in this.names
				if (v == name)
					values.Push(this.values[i])
			return values
		}
		
		__Get(name, n := 1)
		{
			for i, v in this.names
				if (v == name && !--n)
					return this.values[i]
		}
		
		_NewEnum()
		{
			return {"i": 0, "base": this}
		}
		Next(ByRef name, ByRef value)
		{
			if (++this.i > this.names.length())
				return False
			name := this.names[this.i]
			value := this.values[this.i]
			return True
		}
	}
}
