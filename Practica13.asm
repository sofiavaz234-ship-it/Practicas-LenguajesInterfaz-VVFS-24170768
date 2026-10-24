; Materia: Lenguajes de Interfaz
; Alumna: Frida Sofia Vega Vazquez
; Horario: 8 a 9 am
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 13. Obtención de una cadena hexadecimal
; Descripción: Convertimos un valor hexadecimal en memoria a una cadena de texto para poder imprimirlo.
;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INCLUDE Irvine32.inc

.data
    NumeroHex DWORD 4BC56DF0h           ;El número que vamos a transformar 
    textoHex BYTE 9 DUP(0)                ;Buffer de 8 caracteres + 1 byte nulo para el final
    msgResultado BYTE "El resultado en Hex es: ", 0 ;Mensaje que se desplegara en consola

.code
main PROC
    ;Limpiamos registros
    mov eax, 0
    mov ebx, 0
    mov ecx, 0
    mov edx, 0

    mov eax, NumeroHex                  ;Pasamos el número a EAX para irlo desarmando
    mov esi, 7                          ;Vamos a escribir de derecha a izquierda así que empezamos en el índice 7
    mov ecx, 8                          ;Son 8 dígitos hexadecimales en 32 bits así que el ciclo dará 8 vueltas

cicloHex:
    mov ebx, eax                          ;Hacemos una copia a EBX para trabajar con el último dígito y no arruinar el original en EAX
    and ebx, 0Fh                          ;Aplicamos máscara AND con 15 (0Fh). Esto "apaga" todo excepto los últimos 4 bits (1 dígito hex)

    cmp ebx, 10                           ;Checamos si el dígito es del 0 al 9, o si ya es una letra (10 al 15)
    jl EsNumero                           ;jl indica si es menor a 10, brinca y sáltate el +7
    
    add ebx, 7                            ;Si llegó aquí es letra y le sumamos 7 porque en la tabla ASCII hay 7 símbolos raros entre el '9' y la 'A' y así nos los saltamos

EsNumero:
    add ebx, '0'                          ;Le sumamos el código del '0' para convertir el número en texto
    
    mov textoHex[esi], bl                 ;Guardamos el carácter listo en nuestro arreglo y usamos BL porque solo ocupamos 8 bits
    
    shr eax, 4                            ;Recorremos nuestro número original 4 bits a la derecha para que el siguiente dígito quede al final
    dec esi                               ;Nos movemos una casilla para atrás en el arreglo (de derecha a izq)
    loop cicloHex                         ;Le resta 1 a ECX y si no es 0, repite el ciclo

    mov edx, OFFSET msgResultado
    call WriteString
    
    mov textoHex[8], 0                    ;Le ponemos un 0 al final de la cadena para que WriteString sepa dónde parar
    mov edx, OFFSET textoHex
    call WriteString
    call Crlf

   

    exit
main ENDP

END main