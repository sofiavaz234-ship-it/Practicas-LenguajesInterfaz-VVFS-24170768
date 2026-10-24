; Materia: Lenguajes de Interfaz
; Alumna: Frida Sofia Vega Vazquez
; Horario: 8 a 9 am
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 5. Condicionales
; Descripción: Programa que simula el uso de While y Do-While mediante el uso de banderas, comparaciones y saltos condicionales para iterar del 1 al 100.
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------;
INCLUDE Irvine32.inc

.code
main PROC

; WHILE
    mov ebx, 1              ;Valor inicial de la condicion

cicloWhile:
    cmp ebx, 100            ;Compara para ejecutar la condicion de salida haciendo una resta interna

    jg fin                  ;Jg indica que Si EBX > 100, la condición falla y salta a la etiqueta fin rompiendo el ciclo


    mov eax, ebx                    ;Transfiere el valor del registro EBX a EAX para mostrarlo
    call WriteDec                   ;Despliega en consola el valor decimal almacenado en EAX
    call Crlf                       ;Realiza un salto de linea

    inc ebx                         ;Incremento de +1 en el registro ebx
    jmp cicloWhile                  ;Regresa al ciclo while con un salto incondicional

fin:
    call Crlf                       ;Realiza otro salto de línea adicional para separar ambos ciclos en la consola

;DO WHILE
    mov ebx, 1                      ;Reinicializa el contador EBX en 1 para el siguiente ciclo

cicloDoWhile:

    mov eax, ebx                    ;Copia el valor de ebx en eax para mostrarlo
    call WriteDec                   ;Despliega en consola el valor que esta almacenado en eax
    call Crlf                       ;Realiza un salto de línea

    inc ebx                         ; Incrementa el registro ebx +1

    cmp ebx, 100                    ;Compara para verificar si el ciclo continua

    jle cicloDoWhile                ;Jle Regresa a cicloDoWhile mientras EBX <= 100

    exit                            ;Termina la ejecucion del programa
main ENDP

END main