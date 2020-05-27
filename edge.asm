segment .text
global edge
edge:
	push ebp
	mov ebp,esp                    ; Preparing all pointers
	sub esp,12
	mov ebx,[ebp+8]				; Pointer of image.
	mov eax,[ebp+12]			; Width of image.
	mov ecx,[ebp+16] 			; Height of image.
	mov dword[ebp-4],eax		; Holding value of width
	mov dword[ebp-8],ecx		; Holding value of height
	dec ecx						; Height - 1
	mul ecx						; size = width * ( height-1 )
	mov dword[ebp-12],eax		; Holding value of size
	xor ecx,ecx
loopEdge:	
	mov byte dl,byte[ebx]		; Value of image assigned to edx
	add ebx,dword[ebp-4]		; Setting above of the current pixel.
	mov byte cl,byte[ebx]		; Value of above of the current pixel.
	sub ebx,dword[ebp-4]		; Going back to current pixel
	cmp byte cl,byte dl			; comparing pixel of image[i] with image[i+width]
	jnae pixelWhite				; image[i] is not greater or equal to image[i+width] 
	mov byte[ebx],0				; set them black
	inc ebx						; do it for every pixel
	dec eax						; until the reaching top of the image.
	cmp eax,0
	jne loopEdge
pixelWhite:
	mov byte[ebx],230			;Assign 255 white
	inc ebx						;address increments
	dec eax						;loop counter decrements
	cmp eax,0
	jne loopEdge
	mov eax,[ebp+12]
pixelTop:						
	;mov byte[ebx],0				; if current pixel is reached to top
	;inc ebx						; set to 255. And do it every pixel
	;dec eax						; in this width.
	;cmp eax,100
	;jne pixelTop
	mov esp,ebp
	pop ebp
	ret