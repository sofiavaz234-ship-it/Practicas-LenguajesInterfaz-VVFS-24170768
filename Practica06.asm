; Materia: Lenguajes de Interfaz
; Alumna: Frida Sofia Vega Vazquez
; Horario: 8 a 9 am
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 6. Decremento e incremento
; Descripción: Programa que simula un sistema de validación de PIN. Utiliza la instrucción DEC para restar el número de intentos permitidos (máximo 3) y bloquea el acceso si el contador llega a cero.
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------;
INCLUDE Irvine32.inc

.data 
	msgPIN BYTE "Ingrese la clave: ", 0                 ;Mensaje para solicitar el PIN al usuario
    msgError BYTE "Clave Incorrecta.", 0                ;Mensaje de error cuando el PIN no coincide
    msgAcceso BYTE "Acceso permitido", 0                ;Mensaje de éxito al ingresar el PIN correcto
    msgBloqueo BYTE "Sistema Bloqueado", 0              ;Mensaje de bloqueo al agotar los intentos
    msgIntentos BYTE "Intentos restantes: ", 0          ;Mensaje para mostrar el contador actual

    claveCorrecta = 1234                                ;Definimos el PIN de acceso correcto

.code
main PROC
	mov ebx, 3					;Definimos el numero de intentos iniciales 

intentar:
	mov edx, OFFSET msgPIN          ;Carga la dirección del msgPIN en EDX
    call WriteString                ;Muestra el mensaje en consola
    call ReadInt                    ;Captura el PIN tecleado por el usuario y lo guarda en EAX

	cmp eax, claveCorrecta          ;Compara el PIN ingresado guardado en EAX con claveCorrecta haciendo una resta interna sin modificar nada
    je acceso                       ;je indica que Si coinciden, salta a la etiqueta acceso


	mov edx, OFFSET msgError        ;Carga la dirección del mensaje de error
    call WriteString                ;Imprime "Clave Incorrecta."
    call crlf                       ;Realiza salto de línea

	dec ebx                         ;Decrementa en 1 el valor de EBX (intentos restantes)
    jz bloqueado                    ;jz indica que Si al decrementar EBX llega a 0 (ZF=1), salta a bloqueado

	mov edx, OFFSET msgIntentos     ;Carga la dirección del mensaje de intentos restantes
    call WriteString                ;Lo imprime en pantalla

	mov eax, ebx                    ;Se mueve el dato de ebx a eax
    call WriteDec                   ;Muestra en formato decimal los intentos que quedan

    call crlf                       ; Realizan salto de línea
    call crlf                       

    jmp intentar                    ;Salto incondicional para volver a pedir el PIN

acceso:
	mov edx, OFFSET msgAcceso       ;Prepara el mensaje de acceso
    call WriteString                ;Lo muestra en pantalla
    jmp fin                         ;Salta al final para evitar ejecutar la intrucción de bloqueo

bloqueado:
	mov edx, OFFSET msgBloqueo      ;Prepara el mensaje de bloqueo
    call WriteString                ;Lo muestra en pantalla
    jmp fin                         ;Salta al final
fin:
	exit                            ;Termina la ejecución del programa
main ENDP

END main