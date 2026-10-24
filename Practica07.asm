; Materia: Lenguajes de Interfaz
; Alumna: Frida Sofia Vega Vazquez
; Horario: 8 a 9 am
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 7. Validación de formato
; Descripción: Programa que valida que una cadena ingresada por el usuario cumpla estrictamente con el formato de 3 letras mayúsculas, un guion y 3 números (Ejemplo: TEC-123).
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------;
INCLUDE Irvine32.inc

.data 
	msgInicio BYTE "Ingresa el msj con el siguiente formato (TEC-123): ", 0   ;Mensaje principal para pedir la cadena
    cadena BYTE 20 DUP(0)                                                     ;Buffer en memoria para guardar hasta 20 caracteres
    msgError BYTE "Tu cadena no es valida, utiliza el formato correcto ", 0   ;Mensaje de si hay un error
    msgValido BYTE "Formato valido", 0                                        ;Mensaje de éxito si la cadena cumple el formato

.code
main PROC
	
	;Mostrar el mensaje al usuario

	pedirtexto:
	mov edx, OFFSET msgInicio	;Carga la dirección del mensaje inicial en EDX
	call WriteString			;Imprime el mensaje en la consola
	
	mov edx, OFFSET cadena		;Direccion hacia donde va a apuntar el primer caracter
	mov ecx, SIZEOF cadena		;Sizeof da el numero de caracteres que se almacenan en la etiqueta
	
	call ReadString				;ReadString para ver lo que esat escrito en el buffer

    cmp eax, 7                      ;Compara EAX que es longitud de la cadena con 7 porque es el numero total de caracteres
    jne error                       ;jne indica que si la longitud no es exactamente 7, salta directo a error

    mov esi, 0                      ;Inicializa ESI en 0 y sirve índice para recorrer la cadena (cadena[0])

	validarL:
    cmp ESI, 3                      ;Compara nuestro índice actual con 3
    je guion                        ;Si ya revisamos las posiciones 0, 1 y 2 (ESI=3), terminamos con las letras y saltamos a revisar el guion
    
    mov AL, cadena[ESI]             ;Copia el caracter actual de la cadena (el que está en la posición ESI) al registro de 8 bits AL
    
    cmp AL, 'A'                     ;Compara el caracter actual con la letra 'A' mayuscula 
    jb error                        ;jb indica que si el caracter es menor a 'A' en la tabla ASCII, no es letra valida y salta a error
    
    cmp AL, 'Z'                     ;Compara el caracter actual con la letra 'Z' mayuscula
    ja error                        ;ja indica que si el caracter es mayor a 'Z' en la tabla ASCII, tampoco es valido y salta a error

    inc esi                         ;Incrementa el índice en 1 para pasar al siguiente caracter
    jmp validarL                    ;Regresa al inicio del ciclo para validar la siguiente letra

guion:
  
    cmp cadena[3], '-'              ;Compara directamente el caracter en la posición 3 con un guion '-'
    jne error                       ;jne indica que si no es un guion, el formato está mal y salta a error

    mov esi, 4                      ;Si pasó la prueba del guion, ajustamos nuestro índice a 4 para empezar a revisar los números

digitos:
    cmp esi, 7                      ;Compara el índice con 7 (que es el final de nuestra cadena valida)
    je valido                       ;Si ya llegamos al índice 7 sin errores salta a valido

    mov al, cadena[esi]             ;Copia el caracter actual al registro AL
    
    cmp al, '0'                     ;Compara el caracter con el número '0' (en ASCII)
    jb error                        ;jb indica que si es menor que '0' en ASCII, no es un número valido y salta a error
    
    cmp al, '9'                     ;Compara el caracter con el número '9'
    ja error                        ;ja indica que si es mayor que '9' en ASCII, tampoco es un número valido y salta a error

    inc esi                         ;Incrementa el índice en 1 para pasar al siguiente número
    jmp digitos                     ;Regresa al inicio del ciclo de dígitos para validar el siguiente

error:
    mov edx, OFFSET msgError        ;Prepara el mensaje de error 
    call WriteString                ;Lo imprime en pantalla
    call Crlf                       ;Inserta un salto de línea
    jmp pedirtexto                  ;Regresa hasta arriba para volver a pedirle la cadena al usuario

valido:
    mov edx, OFFSET msgValido       ;Prepara el mensaje de que el formato es correcto
    call WriteString                ;Lo imprime en pantalla
    call Crlf                       ;Inserta un salto de línea

    exit                            ;Finaliza el programa 

main ENDP

END main