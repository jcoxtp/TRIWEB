;*************************************************
;*                                               *
;*   Produced by Dimac                           *
;*                                               *
;*   More examples can be found at               *
;*   http://tech.dimac.net                       *
;*                                               *
;*   Support is available at our helpdesk        *
;*   http://support.dimac.net                    *
;*                                               *
;*   Our main website is located at              *
;*   http://www.dimac.net                        *
;*                                               *
;*************************************************

; JMailSend.asm
; Example of using Jmail in assembly.

; This example builds with tasm32 and tlink32.

; Tasm32 /ml jmailsend.asm
; Tlink32 -Tpe -aa -c jmailsend.obj,jmailsend,exe,,import32.lib

; This should produce an output file called jmailsend.exe, ready to execute.



.386
.MODEL FLAT,STDCALL
locals
jumps

UNICODE = 0

;//////////////////////////////////////////////////////////
; External functions needed from the win32 API

SysAllocString 	PROCDESC	WINAPI	:DWORD
SysFreeString 		PROCDESC WINAPI 	:DWORD
CoInitialize		PROCDESC WINAPI 	:DWORD
CoUninitialize    PROCDESC WINAPI
CoCreateInstance  PROCDESC WINAPI   :GUID,  : DWORD, :DWORD, :DWORD, :DWORD
CLSIDFromProgID  	PROCDESC	WINAPI  	:DWORD, : DWORD
MessageBoxA       PROCDESC WINAPI   :DWORD, : DWORD, :DWORD, :DWORD
ExitProcess			PROCDESC	WINAPI	:DWORD
;//////////////////////////////////////////////////////////
; Types and constants needed from the win32 API
	GUID STRUCT
    	D1 DD 0
    	D2 DW  0
    	D3 DW  0
    	D41 DD 0  ; --- D4 QWORD
    	D42 DD 0
	GUID ENDS


	MB_OK							equ 00000000h


  	REGDB_E_CLASSNOTREG 		equ 80040154h ; Returned by CoCreateInstance if class is not registered.

	; Options for CoCreateInstance

   CLSCTX_INPROC_SERVER    equ 1
   CLSCTX_INPROC_HANDLER   equ 2
   CLSCTX_LOCAL_SERVER     equ 4
   CLSCTX_REMOTE_SERVER    equ 16
   CLSCTX_NO_CODE_DOWNLOAD equ 400
   CLSCTX_NO_FAILURE_LOG   equ 4000
;//////////////////////////////////////////////////////////
; The interface used to communicate with JMail

	ISpeedMailer STRUCT
		; IUnknown
			QueryInterface 	DD 0
			AddRef				DD 0
			Release				DD 0
		; IDispatch
			GetTypeInfoCount	DD 0
			GetTypeInfo       DD 0
			GetIDsOfNames     DD 0
			Invoke            DD 0
		; ISpeedMailer
			SendMail				DD 0
	ISpeedMailer ENDS

.DATA


classGUID      GUID ?     ; GUID of class
ifaceGUID      GUID ?     ; GUID of interface ISpeedMailer
ISm            dd ?       ; Interface pointer stored here

mailserverBSTR DD 0
senderBSTR 		DD 0
recipientBSTR 	DD 0
subjectBSTR 	DD 0
bodyBSTR 		DD 0

mailserver     db 'mymailserver.mydomain.com',0   ; Edit this!
sender         db 'me@mydomain.com',0             ; Edit this!
recipient      db 'theRecipient@hisdomain.com',0  ; Edit this!
subject        db 'Hello JMail!',0
body           db 'This is an example mail sent with jmail.',0Dh,0Ah,'Assembly rocks!',0

errorcap       db 'Error',0
errorMsg       db 'Class not registered.',0

bstrLen        dd 0
buffer         db 256 dup(0) ; Some space..
result         dd 0

.CODE

bstr2char proc near ; pointer to BSTR in ESI, destination pointer in EDI
	cld
again:
	lodsw
	or ax,ax
	jz getOut
	stosb
	jmp again
getOut:
	stosb ; Put a last zero to terminate string
	ret
bstr2char endp

char2olestr proc near ; charstr in ESI, destination in EDI

	cld
	xor eax,eax
	xor edx,edx

again2:
	lodsb
	or al,al
	jz getOut2
	stosw
	inc edx
	jmp again2
getOut2:
	stosw
	mov bstrLen,edx
	ret

char2olestr endp

gimmeBSTR proc near ; charstr in ESI

	mov edi,offset buffer
	call char2olestr
	push offset buffer
	call SysAllocString
						  ; BSTR in EAX
  	ret
gimmeBSTR endp

main:

	push dword 0
	call CoInitialize

	; {90D0A753-AD45-40FD-8C6E-555600EE5EB4}


	mov classGUID.D1,90D0A753h  ; Initializing the GUIDs the hard way..
	mov classGUID.D2,0AD45h
	mov classGUID.D3,40FDh
	mov classGUID.D41,56556E8Ch
	mov classGUID.D42,0B45EEE00h

	 ; {821AAFE5-2F19-47EB-ACA9-3B4C1D64AC27}

	mov ifaceGUID.D1,821AAFE5h
	mov ifaceGUID.D2,2F19h
	mov ifaceGUID.D3,47EBh
	mov ifaceGUID.D41,4C3BA9ACh
	mov ifaceGUID.D42,27AC641Dh

	push offset ISm
	push offset ifaceGUID
	push (CLSCTX_INPROC_SERVER or CLSCTX_LOCAL_SERVER)
	push 0
	push offset classGUID

	call CoCreateInstance

	cmp eax,REGDB_E_CLASSNOTREG
	je error
	or eax,eax  ; S_OK ?
	jnz error

	mov esi,offset mailserver
	call gimmeBSTR
	push eax
	mov mailserverBSTR,eax

	mov esi,offset body
	call gimmeBSTR
	push eax
	mov bodyBSTR,eax

	mov esi,offset subject
	call gimmeBSTR
	push eax
	mov subjectBSTR,eax

	mov esi,offset recipient
	call gimmeBSTR
	push eax
	mov recipientBSTR,eax

	mov esi,offset sender
	call gimmeBSTR
	push eax
	mov senderBSTR,eax

	mov  eax, ISm
   push eax
   mov  eax, [eax]
   call [eax + ISpeedMailer.SendMail]

	mov eax,result

	mov eax,offset senderBSTR
	push eax
	call SysFreeString

	mov eax,offset recipientBSTR
	push eax
	call SysFreeString

	mov eax,offset subjectBSTR
	push eax
	call SysFreeString

	mov eax,offset bodyBSTR
	push eax
	call SysFreeString

	mov eax,offset mailserverBSTR
	push eax
	call SysFreeString

   mov eax, ISm
   push eax
   mov eax, [eax]
   call [eax + Release]

final:
	call CoUninitialize
	push dword 0
	call ExitProcess

error:
	push MB_OK
	push offset errorcap
	push offset errorMsg
	push 0
	call MessageBoxA
	jmp final
ends
end main