; Materia: Lenguajes de Interfaz
; Alumna: Frida Sofia Vega Vazquez
; Horario: 8 a 9 am
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 12. Desplazamiento y rotación
; Descripción: Práctica para ver cómo se mueven y rotan los bits usando desplazamientos lógicos (SHL, SHR), aritméticos (SAR) y rotaciones (ROR, ROL, RCR, RCL).
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INCLUDE Irvine32.inc

.code
main PROC
;Dejamos los registros en 0
	mov eax, 0
	mov ebx, 0
	mov ecx, 0 
	mov edx, 0

	;1 - SHL: DESPLAZAR UN BIT HACIA LA IZQUIERDA
	mov al, 10000110b         ;Ponemos el valor en binario en el registro al
	shl al, 1                 ;Quiero que te desplaces 1 posición a la izquierda
							  ;SHL indica el desplazamiento a la izq y equivale a multiplicar por 2

	call DumpRegs             ;Para ver los registros y cómo queda la CF
	call WriteBin             ;Instrucción que nos deja ver los bits cómo se acomodaron
	call Crlf				  ;Salto de línea
	
	;2 - SHR: DESPLAZAR UN BIT HACIA LA DERECHA
	mov al, 00001101b
	shr al, 1                 ;Desplaza a la derecha, misma función anterior pero inversa, este divide entre 2
	
	call DumpRegs
	call WriteBin
	call Crlf
	

	; 3 - SAR: DESPLAZAMIENTO CON SIGNO
	mov eax, 0
	mov al, -8                ;Usamos un número negativo
	sar al, 1                 ;Desplaza a la derecha, pero MANTIENE el signo negativo rellenando con unos a la izquierda

	call DumpRegs
	call WriteBin
	call Crlf

	; 4 - SAR: DESPLAZAMIENTO CON VALOR IMPAR
	mov eax, 0
	mov al, -9
	sar al, 1                 ;Al dividir -9 entre 2 con SAR, el resultado se redondea hacia abajo (queda en -5)
							
	call DumpRegs             
	call WriteBin
	call Crlf

	; 5 -  CONTEO CONSTANTE: DESPLAZAR DOS POSICIONES
	mov al, 00001100b
	shl al, 2                 ;Le decimos directamente cuántos lugares moverse poniendo el 2

	call DumpRegs
	call WriteBin
	call Crlf

	; 6 - CONTEO CON CL: DESPLAZAR UTILIZANDO REGISTRO
	mov al, 00001100b
	mov cl, 2                 ;Guardamos el número de saltos en CL
	shr al, cl                ;Movemos los bits usando el registro CL

	call DumpRegs             
	call WriteBin
	call Crlf


	; 7 - ROR, ROL, RCR, RCL

	;ROR 
	clc                       ;con clc limpiamos la bandera de acarreo
	mov al, 10000001b
	mov cl, 2
	ror al, cl                ;Lo que sale por la derecha, da la vuelta y entra por la izquierda

	call DumpRegs
	call WriteBin
	call Crlf

	;ROL
	mov al, 10000001b
	mov cl, 2 
	rol al, cl                ;Lo que sale por la izquierda, entra por la derecha

	call DumpRegs
	call WriteBin
	call Crlf

	;RCR
	stc                       ;con stc encendemos la CF a propósito para ver qué pasa
	mov al, 10101010b
	rcr al, 1                 ; El bit que sale entra al CF, y el que estaba en el CF entra por el otro lado del registro

	call DumpRegs
	call WriteBin
	call Crlf

	; RCL
	stc                       ;Volvemos a encender el CF
	mov al, 10101010b
	rcl al, 1                 ;Igual que el RCR, pero girando hacia la izquierda usando el CF como puente

	call DumpRegs
	call WriteBin
	call Crlf


	exit				;Fin de ejecución
main ENDP

END main