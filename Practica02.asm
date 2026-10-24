; Materia: Lenguajes de Interfaz
; Alumna: Frida Sofia Vega Vazquez
; Horario: 8 a 9 am
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 2. Captura y desplegado de mensajes
; Descripción: Programa que solicita al usuario que ingrese su nombre, captura la entrada desde el teclado y la imprime nuevamente en pantalla.
;------------------------------------------------------------------------------------------------------------------------------------------------------

INCLUDE Irvine32.inc

.data
    mensaje BYTE "Escribe tu nombre: ", 0 ; Mensaje de interrucpción para el usuario
    nombre BYTE 30 DUP(0) ; Reservamos un espacio de memoria llamado buffer para el limite de caracteres

.code
main PROC
    ; Despliega la solicitud de nombre al usuario
    mov edx, OFFSET mensaje ; Entrega la direccion de memoria donde inicia el mensaje
    call WriteString ; Imprime la cadena de texto almacenada en mensaje

    mov edx, OFFSET nombre ; Entrega la direccion del primer caracter del buffer
    mov ecx, SIZEOF nombre ; Entrega la cantidad de bytes que se pueden escribir

    call ReadString ; Permite el ingreso de datos mediante consola (Lee lo que escribio el usuario)

    ; Retorna lo escrito en el buffer
    mov edx, OFFSET nombre ; Entrega la direccion de memoria donde se almaceno la cadena ingresada
    call WriteString ; Imprime la cadena de texto almacenada en nombre
    call Crlf ; Realiza salto de linea

    exit ; Termina la ejecucion del programa

main ENDP

END main