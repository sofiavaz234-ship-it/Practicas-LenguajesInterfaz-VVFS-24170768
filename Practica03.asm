; Materia: Lenguajes de Interfaz
; Alumna: Frida Sofia Vega Vazquez
; Horario: 8 a 9 am
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 3. Comparación y prueba
; Descripción: Programa que compara dos valores numéricos predefinidos en registros y muestra un mensaje en pantalla indicando si son idénticos o distintos.
;-----------------------------------------------------------------------------------------------------------------------------------------------------------------;
INCLUDE Irvine32.inc

.data
    msgIguales BYTE "Los numeros son iguales", 0            ;Texto a mostrar si la comparación resulta verdadera
    msgDiferentes BYTE "Los numeros son diferentes", 0      ;Texto a mostrar en caso de que los valores no coincidan

.code
main PROC

    mov eax, 180                    ;Asignamos el primer valor (180) al registro EAX
    mov ebx, 181                    ;Asignamos el segundo valor (181) al registro EBX

    cmp eax, ebx                    ;Evalúa EAX y EBX (resta interna que actualiza las banderas del procesador)

    je iguales                      ;je indica que si la bandera zf está activa, salta a iguales
    mov edx, OFFSET msgDiferentes   ;Carga la dirección de msgDiferentes en EDX
    call WriteString                ;Imprime la cadena correspondiente en la consola

    jmp fin                         ;Salto incondicional a fin para no ejecutar las siguientes líneas

iguales: 
    mov edx, OFFSET msgIguales      ;Carga la direccion de memoria de msgIguales en EDX
    call WriteString                ;Muestra en pantalla que los números coinciden

fin: 
    exit                            ;Termina la ejecucion del programa

main ENDP

END main