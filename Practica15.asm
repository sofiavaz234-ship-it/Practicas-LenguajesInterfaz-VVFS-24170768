; Materia: Lenguajes de Interfaz
; Alumna: Frida Sofia Vega Vazquez
; Horario: 8 a 9 am
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 15. Manipulación de archivos
; Descripción: Programa que crea un archivo de texto llamado "Inventario.txt", escribe un valor en él, cierra el archivo y notifica al usuario si el proceso fue exitoso o falló.
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INCLUDE Irvine32.inc

.data 
	nombreArchivo BYTE "Inventario.txt",0                    ;Nombre del archivo físico que se va a crear
	texto BYTE "125",0                                       ;Cadena de texto que vamos a escribir dentro del archivo
	archivoHandle DWORD ?									 ;Almacenar cada vez que creamos un archivo, tipo DWORD ? porque no sabemos el valor a asignar
	
	mensajeExito BYTE "Archivo guardado correctamente.", 0 ;Mensajes si se guardo o no correctamente	
	mensajeError BYTE "No se pudo guardar el archivo.",0   

.code
main PROC
	; 1. Crear archivo txt.
	mov edx, OFFSET nombreArchivo                   ;Pasa la dirección del nombre del archivo al registro EDX
	call CreateOutputFile							;Cambia o asigna un valor al eax

	cmp eax, INVALID_HANDLE_VALUE					;Compara un valor igual al invalid handle value
	je error ;si es igual da error

	mov archivoHandle, eax                          ;Respalda el identificador válido (handle) del archivo en nuestra variable

	;hasta aqui ya se creo nuestro archivo

	;2. Escribir caracteres en archivo txt.
	;operacion para poder escribir, necesita que el identificador este el eax

	mov eax, archivoHandle                  ;Prepara EAX con el manejador del archivo que acabamos de abrir
	mov edx, OFFSET texto					;Que es lo que escribira
	mov ecx, SIZEOF texto -1				;Ve y encuentra el tamaño de caracteres, el -1 le quito el ultimo valor del 00h
	call WriteToFile						;Decimos que escriba en el archivo que esta en handle el texto que tiene tal tamaño

	jc errorEscritura ;jc brinca si la bandera esta encendida, carry flag es el que marca si se hizo una escritura correcta 

	cmp eax, SIZEOF texto -1            ;Compara los bytes que realmente se escribieron (EAX) con los que queríamos escribir
	jne errorEscritura					;En caso de que sea diferente de cero brinca a error de escritura

	;3. Cerrar archivo txt
	mov eax, archivoHandle             ;Cargamos de nuevo el manejador en EAX para la función de cierre
	call CloseFile                     ;Llama a la función de Irvine32 que cierra el archivo y libera la memoria

	test eax, eax  ;comparar sin modificar nada
	jz error                           ;jz indica que si EAX es 0, falló al cerrar, brinca a error

	mov edx, OFFSET mensajeExito       ;Prepara EDX con la dirección del mensaje de éxito
	call WriteString                   ;Imprime que todo salió bien en la consola
	jmp fin                            ;Brinca incondicionalmente al final para no ejecutar la parte de los errores

	errorEscritura:                    ;Etiqueta para manejar problemas exclusivos de la escritura
		mov eax, archivoHandle         ;Recuperamos el manejador del archivo
		call CloseFile                 ;Lo cerramos por seguridad para que no se quede trabado en memoria
	error:                             ;Etiqueta general para cualquier error
		mov edx, OFFSET mensajeError   ;Prepara EDX con el mensaje de error
		call WriteString               ;Imprime el error en pantalla
	fin:                               ;Etiqueta final
		exit                           ;Termina el programa 
main ENDP

END main