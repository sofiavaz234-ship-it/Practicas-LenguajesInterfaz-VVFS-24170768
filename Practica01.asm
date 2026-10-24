; Materia: Lenguajes de Interfaz
; Alumna: Frida Sofia Vega Vazquez
; Horario: 8 a 9 am
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 1. Ciclos numéricos
; Descripción: Programa que utiliza la instrucción LOOP para iterar 5 veces, imprimiendo el valor del contador en forma descendente.
;-------------------------------------------------------------------------------------------------------------------------------------------;
INCLUDE Irvine32.inc

.code
main PROC
	mov ecx,5				;indica el numero de iteraciones que hacen falta
	jecxz fin_ciclo			;Salta a la etiqueta 'fin_ciclo' si ECX es igual a cero 

ciclo:
	mov eax, ecx			;Movemos el valor al registro principal que lo va a tomar
							
	call WriteDec			;call es para llamar a una funcion
							;Apunta hacia el eax para imprimir el valor que esta ahi 
	
	call Crlf				;se llama con call a un salto de linea con crlf
							;Llama a la función que inserta un salto de línea en la consola
	
	loop ciclo				;Loop hace un decremento de ecx
							;Decrementa ECX en 1 y si ECX > 0, salta automáticamente a la etiqueta ciclo
	fin_ciclo:
	exit					;Termina la ejecución del programa
main ENDP

END main