; Jose Isaac SUAREZ Guzman
; NIP
.org 0000h
  ld a,89h
  out (CW),a
  ld SP, 27ffh
  ld hl,text2
  call disp_text
  call read_pasw
  call comprobar
  call com

   halt

; sub rutinas
disp_text:
repeat1:
  ld a,(hl)
  cp "&"
  jp z, end1
  out (LCD), a
  inc hl
  jp repeat1

end1:
     ret

read_pasw:
    ld hl,passw
    ld b,4


readt_other:

        in a,(KEYB)
        cp 29h
        jp P, M1
        halt
M1:
	cp 39h
	jp C, readt_other
	jr error
	ret
	halt
M2:
	cp 30h
	jp C, readt_other

	ld (hl),a
	ld a, 2ah
	out (LCD), a
	inc hl
        djnz readt_other
        ret

comprobar:
	  ld hl, passw
          ld de, patron
	  ld b,4
ciclo_comprobador:
          ld a, (de)
          cp (hl)
          jp nz, error
	  inc hl
	  inc de
	djnz ciclo_comprobador
	jp mensaje


com:
mensaje:
         ld hl,text3
repite:
	ld a,(hl)
         cp "&"
         jp z, fin3
         out (LCD), a
         inc hl
         jp repite
fin3:
         ret
error:

	ld hl,text4
repite2:
	ld a, (hl)
	cp "&"
	jp z,finerror
 	out (LCD),a
	inc hl
	jp repite2
finerror:
	jp read_pasw
;segmento de datos
 .org 2000h
text2:  .db "Introducir NIP &"
patron  .db "1234"
passw   .db 00h,00h,00h,00h
text3:  .db "Acceso Exitoso &"
text4:	.db "No valido &"


;constantes

LCD: .equ 00h
KEYB: .equ 01h
CW:    .equ 03h


end



