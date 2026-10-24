; Materia: Lenguajes de Interfaz
; Alumna: Frida Sofia Vega Vazquez
; Horario: 8 a 9 am
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 11. Operaciones lógicas
; Descripción: Práctica para entender cómo usar las compuertas lógicas (AND, OR, XOR) para manipular bits individuales, simulando los estados de un dispositivo.
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INCLUDE Irvine32.inc

.code
main PROC
;0-ENCENDIDO
;1-ALARMA
;2-CONECTADO
;ESTADO INICIAL; 00000101b (Significa que está encendido y conectado, pero sin alarma)

;1 - AND; EXTRAER EL ESTADO DE ENCENDIDO
	mov eax, 0
	mov ebx, 0 
	
	mov al, 00000101b         ;Cargo mi estado inicial en AL
	mov bl, al                ;Hago una copia en BL para trabajar con ella y no perder el original
	
	and bl, 00000001b         ;Aplico AND con la máscara del bit 0,esto apaga todo lo demás y me deja ver solo si está encendido
	nop                       

; 2- OR: ENCENDER ALARMA
	mov al, 00000101b         ;Regreso a mi estado inicial
	or al, 00000010b      ;Aplico OR con la máscara del bit 1, el OR fuerza a que ese bit se encienda sin importar cómo estaba

	call dumpRegs         ;Imprimo para ver el cambio (AL debería quedar en 00000111b)
	nop

;3 - XOR - DESCONECTAR Y CONECTAR COMPUTADOR
	mov al, 00000101b         ;Parto de mi estado inicial otra vez (Conectado)
	
	xor al, 00000100b         ;Como el bit 2 estaba en 1, el XOR lo invierte a 0 (Se desconectó)
	call dumpRegs             ;Reviso los registros
	nop
	
	xor al, 00000100b         ;Ahora estaba en 0, así que lo regresa a 1 (Se volvió a conectar)
	call dumpRegs             ;Lo verifico de nuevo
	nop

	

	exit	;Fin de la ejecución
main ENDP

END main