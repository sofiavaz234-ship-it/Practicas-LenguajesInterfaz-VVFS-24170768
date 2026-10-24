; Materia: Lenguajes de Interfaz
; Alumna: Frida Sofia Vega Vazquez
; Horario: 8 a 9 am
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 8. Operaciones aritméticas
; Descripción: Demostración de operaciones matemáticas básicas (suma, resta, multiplicación y división) con y sin signo, analizando el comportamiento de los registros EAX/EDX y las banderas de estado (CF y OF).
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------;
INCLUDE Irvine32.inc

.code
main PROC
	; OPERACIONES ADD Y SUB , la eflag CF se modifica, la de acarreo

	mov eax, 50			;Cargamos 50 en EAX
	mov ebx, 20			;Cargamos 20 en EBX

	add eax, ebx		;Sumamos eax y ebx
	sub eax, 15			;Restamos 15 a ebx

	nop		; Significa que no haya ninguna operacion, no realizar la operacion, se usa como punto para que se detenga y no ejecute una instruccion
			; No instruction/ No Operation

	; 2. CF : ACARREO EN UNA SUMA SIN SIGNO

	mov eax, 0                 ;Limpiamos EAX
    mov al, 255                ;AL es de 8 bits y 255 es su valor máximo sin signo
    add al, 1                  ;Al sumar 1, el valor supera los 8 bits. AL vuelve a 0 y se activa CF 

    nop

	; 3. OF: CONDICION DE DESBORADMIENTO, suma con signo

	mov eax, 0                  ; Limpiamos EAX
    mov al, 127                 ; 127 es el valor máximo positivo para 8 bits con signo 
    add al, 1                   ; Al sumar 1, se vuelve 128 y el bit más a la izquierda se enciende.
                                ; El procesador lo interpreta como un número negativo (-128) y activa la bandera OF.

    nop

	;El bit que se enciende hasta las izquierda nos indica si es valor negativo
	
	;4. MUL: MULTIPLICACION DE VALORES DENTRO DE 32 BITS

	mov eax, 25                 ;Movemos 25 al registro eax
    mov ebx, 3                  ;Movemos 3 al registro ebx

    mul ebx                     ;Multiplicamos EAX y EBX 

    nop
	;edx se encarga de almacenar los residuos

	;5. MUL; PRODUCTO QUE NECESITA MAS DE 32 BITS. 
	mov eax, 65537              ;Cargamos un número grande en EAX
    mov ebx, 65537              ;Cargamos el mismo número en EBX

    mul ebx                     ;EAX * EBX. El resultado es muy grande para caber solo en EAX de 32 bits.
                                ;Por lo tanto, la parte alta del resultado se guarda en EDX y la parte baja en EAX.

    nop


	;6. IMUL: MULTIPLICACION CON SIGNO

	mov eax, -5                 ;Cargamos un número negativo en EAX
    imul eax, eax, 3            ;Multiplicación con signo de 3 operandos

    nop

	;7, DIV : Division de numero sin signo
	mov eax, 125                ;Movemos el dividendo a EAX
    mov edx, 0                  ;DIV toma EDX:EAX como dividendo por lo que hay que limpiar EDX para que no altere el valor
    mov ebx, 12                 ;Movemos el divisor a EBX

    div ebx                     ;Divide EDX:EAX entre EBX. 
                                ;EAX guarda el cociente (10) y EDX guarda el residuo (5).

    nop

	;8 IDIV: DIVISION CON SIGNO, CON NUMEROS NEGATIVOS
	
	mov eax, -125               ;Movemos -125 al registro EAX
    
    cdq                         ;cdq toma el bit de signo de EAX y rellena todo EDX con él.
                                ;Como EAX es negativo, llena EDX con FFFFFFFF y esto prepara EDX:EAX para división con signo
    mov ebx, 12                 ;Movemos la cantidad de 12 a EBX
    
    idiv ebx                    ;Divide usando signo y EAX guarda el cociente (-10) y EDX guarda el residuo (-5).
    
    nop

    exit                        ;Finaliza la ejecución
	 
main ENDP

END main