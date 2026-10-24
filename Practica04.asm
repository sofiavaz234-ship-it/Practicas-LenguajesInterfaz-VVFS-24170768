; Materia: Lenguajes de Interfaz
; Alumna: Frida Sofia Vega Vazquez
; Horario: 8 a 9 am
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 4. Saltos
; Descripción: Programa que demuestra el uso de un salto incondicional (JMP) para omitir la ejecución de un bloque de código.
;----------------------------------------------------------------------------------------------------------------------------------;
INCLUDE Irvine32.inc
.code
main PROC
	mov eax, 5				;Asigna el valor incial de 5 al registro EAX
	
	jmp continuar			;Ejecuta un salto incondicional hacia la etiqueta continuar
	mov eax, 10				;Instrucción omitida por el salto; nunca se ejecutará en el flujo del programa

	continuar: 
	call DumpRegs			;Call llama a la función de la librería para imprimir/desplegar el estado de los registros en consola

	exit					;Termina la ejecución del programa
main ENDP

END main