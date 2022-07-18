.model small
.stack 100h
.data

		newline		db		0ah, 0dh, '$'
		
		shapes		db		10,13,'Choose a number: ', 0ah, 0dh, '1. Rectangle ', 0ah, 0dh, '2. Triangle ', 0ah, 0dh, '3. Circle $'
		findRect_Tri	db		'What would you like to calculate? (please enter a number) ', 0ah, 0dh, '1. Area', 0ah, 0dh, '2. Perimeter $'
		
		rectA_formula 	db 	'A = a * b $', 0ah, 0dh
		side_a 		db 		'Enter a value for side a(numbers from 0-9): $'
		side_b		db 		'Enter a value for side b(numbers from 0-9): $'
		rectSide_a	db ?
		rectSide_b	db ?
		rectArea	db 5 dup(?)
		
		numError_msg db 'ERROR! Please enter a number between 0 and 9 $'
		
.code



;function to calculate area for rectangle
rect_area proc
		
reEnter:
		CALL clear_screen
		mov ah,9
		mov dx, offset newline
		int 21h
		
		;display formula for area of rectangle
		mov ah,9
		mov dx, offset rectA_formula
		int 21h
		
		mov ah,9
		mov dx, offset newline
		int 21h
		
		;display message to enter side a
		lea dx, side_a
		mov ah,9
		int 21h

		;input digit from user
		mov ah,1
		int 21h
		sub al,48 ;convert char to number
		mov rectSide_a, al
		
		cmp al, 9
		jg numError
		
		cmp al,0
		jl numError
		
		mov ah,9
		mov dx, offset newline
		int 21h
		
		;display message to enter side b
		lea dx, side_b
		mov ah,9
		int 21h
		
		;input digit from user
		mov ah,1
		int 21h		
		sub al,48
		mov rectSide_b, al
		
		;error check
		cmp al, 9
		jg numError
		
		cmp al,0
		jl numError
		
		mov ah,9
		mov dx, offset newline
		int 21h
		
		xor bx,bx
		mov bl, rectSide_b
		mov al, rectSide_a
		mul bl
		
		lea si, rectArea
		CALL number2string
		
		lea dx, rectArea
		mov ah,9
		int 21h
		
		mov dx,offset newline
		mov ah,9
		int 21h
		
		jmp return1
		
		
;error_check
numError:
			
		CALL clear_screen
			
			mov ah,9
			mov dx, offset numError_msg
			int 21h
		user_enter:	
			mov ah,1
			int 21h
			cmp al,13
			je goback
			
			loop user_enter
goback:
jmp reEnter
		
return1:		ret
rect_area endp

;------------------------------------------------

number2string proc
		mov bx, 10          ;; storing 2 digits number as character in string
		xor cx, cx
division: xor dx,dx
		div bx
		push dx
		inc cx
		cmp ax, 0
		jne division
store:	pop dx
		add dl, 48
		mov [si], dl
		inc si
		loop store
		mov [si], '$ ' 

  ret
number2string endp  

;-------------------------------------------------

clear_screen proc

		mov ah,6 
		mov al,0
		mov bh,00000111b
		mov ch,0
		mov cl,0
		mov dh,24
		mov dl,79
		int 10h
		
		ret
clear_screen endp

main proc

		CALL clear_screen
		
		;-------------------
		
		mov ax,@data
		mov ds,ax
		
		;code to display prompt
		mov ah,9
		mov dx, offset shapes
		int 21h
		
		mov ah,9
		mov dx, offset newline
		int 21h
		
		mov ah,1
		int 21h
		
		mov ah,9
		mov dx, offset newline
		int 21h
		
		CALL clear_screen
		
		cmp al,'1'
		je jump
		
jump:
		mov ah,9
		mov dx, offset findRect_Tri
		int 21h
		
		mov al,0
		
		mov ah,9
		mov dx, offset newline
		int 21h
		
		mov ah,1
		int 21h
		
		CALL clear_screen
		
		cmp al,'1'
		CALL rect_area
		
		mov ah,4ch
		int 21h
main endp
end main