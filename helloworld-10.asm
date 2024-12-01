%include        'functions.asm'

SECTION .bss
buffer: resb 4  ; buffer para almacenar hasta 3 caracteres más un terminador nulo

SECTION .text
global _start

_start:
    mov ecx, 1  ; inicializamos el contador en 1

nextNumber:
    mov eax, ecx  ; copiamos el número actual en eax
    lea edi, [buffer + 3]  ; apuntamos al final del buffer
    mov byte [edi], 0  ; terminador nulo

convert:
    xor edx, edx
    mov ebx, 10
    div ebx  ; dividimos eax por 10
    add dl, 48  ; convertimos el residuo (dígito) a ASCII
    dec edi
    mov [edi], dl  ; almacenamos el carácter en el buffer
    test eax, eax
    jnz convert  ; si aún hay más dígitos, continuamos

    mov eax, edi  ; pasamos la dirección del número convertido
    call sprintLF  ; imprimimos el número con un salto de línea

    inc ecx  ; incrementamos el contador
    cmp ecx, 11
    jne nextNumber  ; seguimos si no hemos llegado al número 10

    call quit  ; terminamos el programa
