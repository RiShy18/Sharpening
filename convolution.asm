segment .Data
        hello:  db -2,-2,-2,-2, 32,-2, -2, -2, -2, ;Kernel Sharpen

segment .text 
        Global vector

vector:
        mov eax,4       ;
        mov ebx,2       ;
        mov ecx,hello[2] ;
        mov edx,helloLen ;
        int 80h         ;
        ret