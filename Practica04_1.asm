; Materia: Lenguajes de Interfaz
; Alumna: Frida Sofia Vega Vazquez
; Horario: 8 a 9 am
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 4.1. Mayor, menor o igual con entrada del usuario
; Descripción: Programa que solicita dos valores numéricos al usuario, los compara y determina si el primero es mayor, menor o igual al segundo.
;-------------------------------------------------------------------------------------------------------------------------------------------------------;
INCLUDE Irvine32.inc

.data 
	PrimerValor BYTE "Ingresa el primer valor: ",0              ;Mensaje que aparece en consola para solicitar el primer número
    SegundoValor BYTE "Ingresa el segundo valor: ",0            ;Mensaje que aparece en consola para solicitar el segundo número
    msgIguales BYTE "Los valores son iguales", 0                ;Mensaje que aparece en consola si los valores coinciden
    msgMayor BYTE "El primer valor es mayor que el segundo", 0  ;Mensaje si el primer número es mayor
    msgMenor BYTE "El primer valor es menor que el segundo", 0  ;Mensaje si el primer número es menor

.code
main PROC

	;Leer primer valor
    mov edx, OFFSET PrimerValor     ;Carga la dirección de memoria del primer valor en EDX
    call WriteString                ;Despliega la cadena en la consola 
    call ReadInt                    ;Captura el número ingresado por el teclado y lo almacena en EAX


    ;Guardar primer valor en otro registro
    mov ebx, eax                    ;Transfiere el valor de EAX a EBX para liberar EAX para la siguiente lectura

    ;Leer segundo valor            
    mov edx, OFFSET SegundoValor    ;Carga la dirección de memoria del segundo valor en EDX
    call WriteString                ;Despliega la cadena en la consola
    call ReadInt                    ;Captura el segundo número y lo sobrescribe en EAX

    ;Comparar
    cmp ebx, eax                    ;Compara el primer valor (EBX) contra el segundo valor (EAX), realizando una resta interna
    jg mayor                        ;jg Salta a la etiqueta 'mayor' si EBX > EAX
    jl menor                        ;Jl Salta a la etiqueta 'menor' si EBX < EAX
    je iguales                      ;Je Salta a la etiqueta 'iguales' si EBX == EAX (bandera ZF activada)

mayor:
    mov edx, OFFSET msgMayor        ;Prepara EDX con la dirección de memoria del mensaje correspondiente
    call WriteString                ;Imprime el resultado
    jmp fin                         ;Salto incondicional a la etiqueta 'fin' para evitar la ejecución de las siguientes instrucciones

menor:
    mov edx, OFFSET msgMenor          ;Prepara EDX con la dirección de memoria del mensaje correspondiente
    call WriteString                  ;Imprime el resultado
    jmp fin                           ;Salto incondicional a la etiqueta 'fin'

iguales:
    mov edx, OFFSET msgIguales        ;Prepara EDX con la dirección de memoria de msgIguales
    call WriteString                  ;Imprime el resultado

fin:
    call Crlf                          ;Llamado a un salto de linea
    exit                               ;Termina la ejecución del programa

main ENDP
END main