; Materia: Lenguajes de Interfaz
; Alumna: Frida Sofia Vega Vazquez
; Horario: 8 a 9 am
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 5.1. Repetir hasta que el usuario ingrese cero
; Descripción: Programa que solicita iterativamente números al usuario mediante un ciclo, el cual se rompe únicamente cuando el valor capturado es igual a cero.
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------;
INCLUDE Irvine32.inc

.data
    numero BYTE "Escribe un numero: ", 0                ;Mensaje inicial para solicitar el dato numérico
    msg1 BYTE "Ingrese otro numero: ", 0                ;Mensaje que se muestra para pedir de nuevo un número
    msg2 BYTE "Programa terminado, se ingreso el 0", 0  ;Mensaje que se muestra en consola que el programa termino

.code
main PROC

ciclo:
    mov edx, OFFSET numero          ;Carga en EDX la dirección de memoria del mensaje inicial
    call WriteString                ;Despliega la cadena en consola

    call ReadInt                    ;Pausa la ejecución y captura un número entero en el registro EAX

    cmp eax, 0                      ;Compara el valor del registro de eax con 0
    je fin                          ;Je indica que Si EAX es igual a 0, salta a la etiqueta fin para romper el ciclo

    call Crlf                       ; Llama un salto de linea
    mov edx, OFFSET msg1            ;Carga en EDX la dirección del mensaje para solicitar un nuevo ingreso
    call WriteString                ;Muestra el mensaje en pantalla
    call Crlf                       ;Llama a un salto de linea

    jmp ciclo                       ;Salto incondicional al inicio de la etiqueta ciclo para repetir el proceso


fin:
    call Crlf                       ;Llama a un salto de linea
    mov edx, OFFSET msg2            ;Prepara EDX con el mensaje de terminación del programa
    call WriteString                ;Imprime el mensaje indicando que se detectó el cero

    exit                            ; Termina la ejecución del programa
main ENDP

END main