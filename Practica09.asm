; Materia: Lenguajes de Interfaz
; Alumna: Frida Sofia Vega Vazquez
; Horario: 8 a 9 am
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 9. PUSH y POP
; Descripción: Programa que demuestra el funcionamiento de la Pila. Se aborda el comportamiento básico de PUSH/POP, el principio LIFO (Último en entrar, primero en salir), la preservación de registros y el uso de CALL y RET.
;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INCLUDE Irvine32.inc

.code
main PROC

	;BLOQUE 1: PUSH Y POP
	mov eax, 40                 ;Guardamos el valor 40 en EAX

    push eax                    ;Metemos el valor de EAX en la parte superior de la Pila

    nop                         ;Pausa para el depurador

    mov eax, 0                  ;Limpiamos EAX para comprobar que el valor sigue en la Pila y no en el registro
    pop ebx                     ;Sacamos el último valor de la Pila y lo guardamos en EBX
    
    nop                         ;No operation

	;BLOQUE 2: ORDEN DE LIFO
	mov eax, 10					;Guardamos 10 al registro EAX
    push eax                    ;Metemos 10 a la pila
    
    mov eax, 20					;Guardamos 20 al registro EAX
    push eax                    ;Metemos 20 y la pila tiene 20, 10

    mov eax, 30					;Guardamos 30 al registro EAX
    push eax                    ;Metemos 30 y la pila tiene 30, 20, 10 (30 está hasta arriba)

    nop 

    ;Al hacer POP, los datos salen en orden inverso (el último en entrar es el primero en salir)
    pop eax                     ;Saca el 30 y lo guarda en EAX
    pop ebx                     ;Saca el 20 y lo guarda en EBX
    pop ecx                     ;Saca el 10 y lo guarda en ECX

    nop

	;BLOQUE 3: CONSERVAR REGISTROS

	mov eax, 100                ;Le damos un valor a EAX
    mov ebx, 200                ;Le damos un valor a EBX

    push eax                    ;Guardamos EAX en la Pila
    push ebx                    ;Guardamos EBX en la Pila (EBX está arriba de EAX)

    ;Aqui los extraemos para que salgan en orden correcto
    pop ebx                     ;Sacamos el valor de EBX (que fue el último en entrar)
    pop eax                     ;Sacamos el valor de EAX

    nop

	;BLOQUE 4: CALL Y RET

	mov eax, 50                 ;Le damos un valor a EAX
    mov ebx, 100                ;Le damos un valor a EBX

    call aumentarDiez           ;Llamamos a aumentarDiez y esto internamente hace un PUSH de la dirección de retorno

    nop                         

    exit                        ;Finaliza el programa
main ENDP

aumentarDiez PROC
    push ebx                    ;Guardamos el valor original de EBX (100) en la Pila

    mov ebx, 10                 ;Usamos EBX temporalmente con el valor 10
    add eax, ebx                ;Le sumamos EBX a EAX y EAX ahora es 60.

    pop ebx                     ;Regresamos a EBX su valor original (100) que guardamos en la Pila

    ret                         ;Retorna al flujo principal del programa (desapilando la dirección de retorno)
aumentarDiez ENDP

END main