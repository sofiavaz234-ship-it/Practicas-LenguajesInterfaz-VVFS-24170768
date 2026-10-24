; Materia: Lenguajes de Interfaz
; Alumna: Frida Sofia Vega Vazquez
; Horario: 8 a 9 am
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 14. Captura y almacenamiento de datos numéricos
; Descripción:  Un almacén recibe un lote de tarjetas de desarrollo ESP32. Desarrolla un programa en MASM e Irvine32 que capture cuántas unidades llegaron y almacene esa cantidad.
; En este Programa que pide un número como texto, valida que sean dígitos válidos (del 1 al 99), lo convierte a valor numérico para sumarlo a un inventario base, y vuelve a convertir el total a texto para imprimirlo.
;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INCLUDE Irvine32.inc

.data
    msgPedirNum     BYTE "Ingresa cuantos articulos llegaron (1 a 99): ", 0  ;Mensaje para pedir la cantidad
    msgError        BYTE "Error: Entrada no valida. Intentalo de nuevo.", 0  ;Mensaje si el usuario se equivoca
    msgTotal        BYTE "El inventario total ahora es: ", 0                 ;Mensaje para imprimir el resultado
    
    
    textoEntrada    BYTE 10 DUP(0)      ;Espacio reservado para guardar lo que el usuario escribe (hasta 10 caracteres)
    textoSalida     BYTE 10 DUP(0)      ;Espacio reservado para guardar el número final convertido a texto
    
    cantidadRecibida    DWORD ?             ;Variable vacía para guardar el número final después de la conversión
    inventarioBase  DWORD 25            ;Valor inicial con 25 en almacen
    existenciaActual DWORD ?             ;Variable vacía donde guardaremos el resultado de la suma

.code
main PROC
PedirDatos:

    mov edx, OFFSET msgPedirNum         ;Cargamos la dirección del mensaje para pedir artículos
    call WriteString                    ;Imprimimos el mensaje
    
    mov edx, OFFSET textoEntrada        ;Apuntamos EDX a nuestro espacio vacío para guardar el texto
    mov ecx, SIZEOF textoEntrada        ;Le decimos a ECX el límite de caracteres que podemos aceptar
    call ReadString                     ;Pausamos para leer teclado y guarda el texto en memoria y la longitud en EAX
    
    cmp eax, 0                          ;Comparamos la longitud eax con 0 por si solo dio enter
    je MostrarError                     ;je indica que si es 0, brinca a mostrar error
    cmp eax, 2                          ;Comparamos la longitud con 2 (el máximo que queremos, 99)
    ja MostrarError                     ;Ja indica que si escribió más de 2 caracteres, brinca a mostrar error

    mov esi, OFFSET textoEntrada        ;Hacemos que ESI apunte al primer carácter de lo que escribió
    mov ecx, eax                        ;Usamos la longitud como contador para el ciclo LOOP

ValidarCaracteres:
    mov al, [esi]                       ;Extraemos el carácter actual y lo guardamos temporalmente en AL
    cmp al, '0'                         ;Comparamos el carácter con el '0' de la tabla ASCII
    jb MostrarError                     ;jb indica que si es menor, marca error
    cmp al, '9'                         ;Comparamos el carácter con el '9' de la tabla ASCII
    ja MostrarError                     ;Ja indica que si es mayor, es una letra y marca error
    inc esi                             ;Movemos el apuntador al siguiente carácter
    loop ValidarCaracteres              ;Resta 1 a ECX y repite hasta validar todos los caracteres

  
    mov esi, OFFSET textoEntrada        ;Volvemos a apuntar ESI al inicio del texto
    mov eax, 0                          ;Limpiamos EAX, aquí iremos construyendo nuestro valor final
    mov ebx, 10                         ;Guardamos el 10 en EBX (lo usaremos para multiplicar las decenas)
    mov ecx, 2                          ;Le damos a ECX un máximo de 2 iteraciones

ConvertirANumero:
    mov edx, 0                          ;Limpiamos EDX
    mov dl, [esi]                       ;Tomamos el carácter actual en la posición ESI y lo guardamos en DL
    
    cmp dl, 0                           ;Revisamos si el carácter es el byte nulo (0), que indica fin de cadena
    je FinConversion                    ;Je indica que si ya se acabó la cadena, brinca al final de esta fase
    
    sub dl, '0'                         ;Le restamos el valor ASCII del '0' para que se vuelva número 
    
    
    push edx                            ;mul ebx sobrescribe EDX asi que guardamos nuestro dígito a salvo en la Pila.
    mul ebx                             ;Multiplicamos EAX (que lleva nuestro total temporal) por 10 (EBX)
    pop edx                             ;Recuperamos nuestro dígito de la Pila, sano y salvo.
    

    add eax, edx                        ;Sumamos nuestro dígito recién convertido al total acumulado
    inc esi                             ;Avanzamos al siguiente carácter
    loop ConvertirANumero               ;Repetimos el proceso

FinConversion:
   
    cmp eax, 1                          ;Comparamos el resultado final en EAX con 1
    jb MostrarError                     ;Si ingresó un 0, lo saltamos
    cmp eax, 99                         ;Comparamos el resultado con 99
    ja MostrarError                     ;ja indica que si ingresó algo mayor brinca a error, aunque seria raro por el limite de caracteres

   
    mov cantidadRecibida, eax               ;Guardamos nuestro valor en memoria
    mov ebx, inventarioBase             ;Copiamos los 25 que ya teníamos a EBX
    add eax, ebx                        ;Hacemos la suma de lo que entró + lo que había
    mov existenciaActual, eax            ;Respaldamos el total en la variable final

    mov edx, OFFSET msgTotal            ;Preparamos el texto final
    call WriteString                    ;Lo mostramos en pantalla

   
    mov eax, existenciaActual            ;Pasamos el total final a EAX 
    mov edi, OFFSET textoSalida         ;Apuntamos EDI hacia el arreglo vacío donde queremos que aparezca el resultado
    call ConvertirNumATexto             ;Llamamos a la instruccion ConvertirNumATexto

   
    mov edx, OFFSET textoSalida         ;Ahora EDX apunta al buffer que se acaba de llenar
    call WriteString                    ;Imprimimos el resultado convertido
    call Crlf                           ;Salto de línea 
    jmp fin                             ;Brincamos al final incondicionalmente para evitar la zona de error

MostrarError:
    
    call Crlf                           ;Salto de línea
    mov edx, OFFSET msgError            ;Preparamos mensaje de error
    call WriteString                    ;Lo imprimimos
    call Crlf                           ;Salto de línea
    jmp PedirDatos                      ;Salto incondicional hasta el principio para que vuelva a intentar

fin:
    exit                                ;Cierra el programa
main ENDP


ConvertirNumATexto PROC
    
    push eax                            ;Guardamos el total para no perderlo
    push ebx                            ;Guardamos el divisor
    push ecx                            ;Guardamos el contador
    push edx                            ;Guardamos temporal de residuos

    mov ecx, 0                          ;Limpiamos ECX que servirá como contador de los dígitos que vayamos sacando
    mov ebx, 10                         ;Ponemos el 10 en EBX porque dividiremos entre 10 para sacar unidad, decena, etc.

CicloDividir:
    mov edx, 0                          ;Limpiamos EDX obligatoriamente antes de hacer un DIV
    div ebx                             ;Divide EAX / 10
    add dl, '0'                         ;Le sumamos el '0' al dígito (EDX) para que se convierta en ASCII
    push edx                            ;Lo metemos a la pila porque la división saca los números de derecha a izquierda
    inc ecx                             ;Aumentamos el contador de dígitos
    cmp eax, 0                          ;Revisamos si el cociente ya llegó a cero 
    jne CicloDividir                    ;jne indica que si todavía hay números, repite la división

CicloSacarPila:
    pop edx                             ;Sacamos el número de la pila y ahora salen ordenados
    mov [edi], dl                       ;Metemos el carácter (DL) en la posición actual de nuestro buffer de salida (EDI)
    inc edi                             ;Movemos el apuntador una posición a la derecha
    loop CicloSacarPila                 ;Repetimos el loop basado en la cantidad de veces que guardamos en ECX

 
    mov al, 0                           ;Preparamos un byte nulo
    mov [edi], al                       ;Lo metemos al final del arreglo para que WriteString sepa que ahí termina

   
    pop edx                             ;Sacamos lo que era EDX
    pop ecx                             ;Sacamos lo que era ECX
    pop ebx                             ;Sacamos lo que era EBX
    pop eax                             ;Sacamos lo que era EAX
    
    ret                                 ;Regresamos el control a Call
ConvertirNumATexto ENDP

END main