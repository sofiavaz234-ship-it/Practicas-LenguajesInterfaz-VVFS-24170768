; Materia: Lenguajes de Interfaz
; Alumna: Frida Sofia Vega Vazquez
; Horario: 8 a 9 am
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 10. Obtención de una cadena decimal
; Descripción: Programa que convierte un número entero a una cadena de texto en decimal usando divisiones entre 10 y guardando los dígitos en la pila.
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------
INCLUDE Irvine32.inc

.data 
	numero DWORD 125                           ;Este es el número que quiero convertir a texto
	bufferDecimal BYTE 11 DUP(0)               ;Aquí voy a guardar mi cadena resultante (hasta 10 dígitos + el 0 nulo)
	mensaje BYTE "Cadena Decimal: ",0          ;Mensaje para mostrar en consola


.code
main PROC
	mov eax, numero         ;Paso el número a EAX para guardarlo ahi
	mov ebx, 10             ;Pongo el 10 en EBX porque dividiré entre 10 para sacar cada dígito
	mov ecx, 0				;Inicializo mi contador en 0 para saber cuántos dígitos voy sacando

extraerDigitos:
	mov edx,0				;Limpio EDX porque la división usa EDX:EAX y si no lo limpio, falla.
	div ebx					;Divido entre 10 y EAX guarda el cociente, EDX guarda el residuo (el dígito)
	push edx				;Meto el dígito a la pila (los meto al revés para sacarlos en orden)
	inc ecx                 ;Le sumo 1 a mi contador de dígitos

	nop						; Observar EAX, EDX, ECX y [ESP]
							

	test eax,eax			;Examino los bits con test y aqui checo si el cociente ya llegó a cero
	jnz extraerDigitos		;jnz indica que si el cociente no es cero me regreso a seguir dividiendo

	;Para 125: cima= 1; [ESP+4] = 2; [ESP+8] = 5.
	mov esi, 0              ;ESI me va a servir como índice para moverme por el bufferDecimal

construirCadena:
	pop edx                 ;Saco el dígito de la pila (ahora sí salen en el orden correcto, de izq a der)
	nop					    ;EDX contiene un digito entre 0 y 9

	add dl, '0'						;Le sumo el ASCII del '0' para que el número se convierta en carácter de texto
	mov bufferDecimal[esi], dl		;Meto ese carácter en la posición actual de mi arreglo
	inc esi							;Avanzo a la siguiente posición del arreglo para el próximo dígito
	nop								;Observar el buffer en memoria 1

	dec ecx                 ;Le resto 1 a mi contador de dígitos para saber cuántos me faltan
	jnz ConstruirCadena     ;Si todavía me faltan dígitos (ECX no es 0) repito este ciclo

	mov bufferDecimal[esi], 0 ;Pongo el byte nulo (0) al final para que la cadena sea válida
	nop						  ;buffer: 31h 32h 35h 00h
						      ;esi=3; la pila esta equilibrada

	
	mov edx, OFFSET mensaje			
	call WriteString				;Imprimo "Cadena Decimal: "
	mov edx, OFFSET bufferDecimal
	call WriteString				;Imprimo ya mi número convertido a texto
	call crlf


	exit						;Fin del programa
main ENDP

END main