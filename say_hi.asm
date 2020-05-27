segment .Data
        hello:  db "hello world",10
        helloLen: equ $-hello

segment .text 
        Global say_hi

say_hi:
        mov eax,4       ;
        mov ebx,1       ;
        mov ecx,hello
        mov edx,helloLen
        int 80h         ;
        ret