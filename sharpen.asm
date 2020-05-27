segment .bss
heightx resd 1
widthx resd 1
segment .text
global convo
convo:
	push ebp
	mov ebp,esp
	mov ebx,[ebp+8] 		;image pointer
	mov ecx,[ebp+16]		;height of image
	mov [heightx],ecx 		;counter for outerloop
	mov ecx,[ebp+12] 		;width of image
	mov [widthx],ecx 		;counter for innerloop
							; Kernel is loaded as an expansion fo the original file
							; there is an actual expansion
outerLoopBlur:
	mov ecx,[ebp+12] 		;ecx includes width of image for a newloop
	mov [widthx],ecx 		;counter for innerloop
    cmp dword[heightx],0	;comparison for outerloop
    je done		
innerLoopBlur:
	xor eax,eax				;eax = 0
	xor edx,edx				;edx = 0
	mov dl,byte[ebx]		;dl holds current pixel value
    add eax,edx				;eax holds value of the current pixels
    mov dl,byte[ebx+1]		;dl holds the pixel after the current
	add eax,edx				;eax holds sum of these two pixels
	mov dl,byte[ebx+ecx]	;dl hols above pixel the current pixel value
	add eax,edx				;eax hold total value of these three pixels
	mov dl,byte[ebx+ecx+1]	;dl holds above next pixel
	add eax,edx				;eax holds sum of these four
	shr eax,2				;dividing 4 to find average
	mov byte[ebx],al		;assign average
	mov byte[ebx+1],al		;to these four
	mov byte[ebx+ecx],al
	mov byte[ebx+ecx+1],al
	add ebx,2				;going to next two
    cmp dword[widthx],0		;comparison for loop
    je innerLoopDone
	sub dword[widthx],2		;-2 for innerloop
    jmp innerLoopBlur
innerLoopDone:
    sub dword[heightx],2	;-2 for outerloop
	add ebx,[ebp+12]		;going to above pixel
    jmp outerLoopBlur
done:
	mov esp,ebp
	pop ebp
	ret