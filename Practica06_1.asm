; Materia: Lenguajes de Interfaz
; Alumna: Frida Sofia Vega Vazquez
; Horario: 8 a 9 am
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 6.1. Control de ocupación de un estacionamiento
; Descripción: Programa que simula el control de un estacionamiento permitiendo el ingreso o salida de múltiples autos a la vez. Utiliza ciclos con las instrucciones INC y DEC para actualizar los espacios disponibles y valida la capacidad.
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------;
INCLUDE Irvine32.inc

.data 
    ;Mensajes que aparecen una vez que se inicia el programa
    msgDisp BYTE "Espacios disponibles: ", 0
    msgMenu1 BYTE "1. Ingresar auto(s)", 0
    msgMenu2 BYTE "2. Retirar auto(s)", 0
    msgMenu3 BYTE "3. Salir", 0
    msgOpcion BYTE "Elige una opcion: ", 0
    
    ;Mensajes que aparecen para capturar los datos solicitados
    msgCantEntra BYTE "Cuantos autos van a ingresar?: ", 0
    msgCantSale BYTE "Cuantos autos van a salir?: ", 0
    
    ;Mensajes que aparecen en consola para mostrar el estado del estacionamiento
    msgSinEspacio BYTE "No hay suficientes espacios para tantos autos.", 0
    msgSinAutos BYTE "No hay tantos autos adentro para retirar.", 0
    msgExitoEntrada BYTE "Autos ingresados correctamente.", 0
    msgExitoSalida BYTE "Autos retirados correctamente.", 0
    msgError BYTE "Opcion no valida.", 0

    capacidadMax = 20               ;Se define la capacidad max de el estacionamiento

.code
main PROC
    mov ebx, capacidadMax           ;Inicializamos ebx con el cupo máximo de 20 espacios al arrancar el programa
                                    ;para usarlo como contador
menu:
    
    call Crlf                       ;Inserta un salto de línea 
    mov edx, OFFSET msgDisp         ;Carga la dirección del mensaje "Espacios disponibles: "
    call WriteString                ;Imprime el mensaje en consola
    mov eax, ebx                    ;Copiamos el valor de ebx a eax porque WriteDec solo imprime eax
    call WriteDec                   ;Imprime el número de espacios que quedan
    call Crlf                       ;Inserta saltos de línea
    call Crlf                      


    mov edx, OFFSET msgMenu1        ;Prepara el texto de la opción 1
    call WriteString                ;Lo imprime
    call Crlf                       ;Salto de línea
    mov edx, OFFSET msgMenu2        ;Prepara el texto de la opción 2
    call WriteString                ;Lo imprime
    call Crlf                       ;Salto de línea
    mov edx, OFFSET msgMenu3        ;Prepara el texto de la opción 3
    call WriteString                ;Lo imprime
    call Crlf                       ;Salto de línea
    
    
    mov edx, OFFSET msgOpcion       ;Prepara el mensaje "Elige una opcion: "
    call WriteString                ;Lo imprime
    call ReadInt                    ;Lee el número que teclea el usuario y lo guarda en eax
    call Crlf                       ;Salto de línea

    ;Se evalua la opción del usuario
                                    
    cmp eax, 1                      ;Aquí se compara constantemente la entrada del usuario que se manda a
    je ingresarautos                ;eax y si coincide con la comparación salta a su respectiva 
    cmp eax, 2                      ;etiqueta con sus instrucciones a realizar               
    je retirarautos                      
    cmp eax, 3                
    je fin 
    

    mov edx, OFFSET msgError        ;Prepara el mensaje de error de opción inválida
    call WriteString                ;Lo imprime
    jmp menu                        ;Salto incondicional de regreso al menú para que vuelva a intentar

ingresarautos:
    
    mov edx, OFFSET msgCantEntra    ;Prepara el mensaje preguntando cuántos autos entran
    call WriteString                ;Lo imprime
    call ReadInt                    ;Captura la cantidad y la guarda en eax
    
    cmp eax, 0                      ;Compara la cantidad ingresada con 0
    jle menu                        ;jle indica que Si ingresa 0 o negativo, regresamos al inicio

    cmp ebx, eax                    ;Comparamos espacios disponibles en ebx y solicitados que hay en eax
    jl sinespacio                   ;jl indica que Si los disponibles son menores a los solicitados, salta a su etiqueta

    
    mov ecx, eax                    ;El número de autos a entrar eax será nuestro contador del ciclo ecx
cicloingreso:
    dec ebx                         ;Decrementa 1 a ebx por cada auto que entra
    loop cicloingreso               ;Decrementa ecx y si no es cero, repite dec ebx

    mov edx, OFFSET msgExitoEntrada ;Prepara el mensaje de éxito
    call WriteString                ;Lo imprime
    jmp menu                        ;Regresa al menú principal

sinespacio:
    
    mov edx, OFFSET msgSinEspacio   ;Prepara el mensaje de que no caben
    call WriteString                ;Lo imprime
    jmp menu                        ;Regresa al menú principal

retirarautos:
 
    mov edx, OFFSET msgCantSale     ;Prepara el mensaje preguntando cuántos autos salen
    call WriteString                ;Lo imprime
    call ReadInt                    ;Captura la cantidad y la guarda en eax
    
    cmp eax, 0                      ;Compara la cantidad ingresada con 0
    jle menu                        ;jle indica que Si ingresa 0 o negativo, lo ignoramos y vamos al menú

    
    mov edi, capacidadMax           ;Movemos la capacidad total a un registro temporal EDI
    sub edi, ebx                    ;Restamos a EDI los espacios vacíos EBX para saber cuántos autos hay adentro
    
    cmp edi, eax                    ;Comparamos autos adentro edi y los que el usuario quiere sacar en eax
    jl sinautos                     ;Jul indica que Si hay menos autos adentro de los que piden sacar, salta a la etiqueta correspondiente

    
    mov ecx, eax                    ;El número de autos a salir eax será nuestro contador del ciclo ecx
cicloretiro:
    inc ebx                         ; Incrementa 1 a EBX por cada auto que sale
    loop cicloretiro               ; Decrementa ECX y si no es cero, repite inc ebx

    mov edx, OFFSET msgExitoSalida  ;Prepara el mensaje de éxito
    call WriteString                ;Lo imprime
    jmp menu                        ;Regresa al menú principal

sinautos:
    mov edx, OFFSET msgSinAutos     ;Prepara el mensaje de error 
    call WriteString                ;Lo imprime
    jmp menu                        ;Regresa al menú principal

fin:
    exit                            ;Finaliza el programa 

main ENDP

END main