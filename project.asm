.model small
.stack 200h
.data
;-------------------------------------------------
;DECLARATION OF VARIABLES
;-------------------------------------------------
		newline		db		0ah, 0dh, '$'
		
		shapes		db		10,13,'Choose a number: ', 0ah, 0dh, '1. Rectangle ', 0ah, 0dh, '2. Triangle ', 0ah, 0dh, '3. Circle $'
		findRect_Tri	db		'What would you like to calculate? (please enter a number) ', 0ah, 0dh, '1. Area', 0ah, 0dh, '2. Perimeter $'
		
		;variables for rectangle
		rectA_formula 	db 	'A = a * b $', 0ah, 0dh
		rectP_formula 	db 	'P = a + b $', 0ah, 0dh
		side_a 		db 		'Enter a value for side a(numbers between 0-9): $'
		side_b		db 		'Enter a value for side b(numbers between 0-9): $'
		perimeter 	db		'The perimeter is: $'
		rectSide_a	db ?
		rectSide_b	db ?
		rectArea	db 5 dup(?)
		rectPerim 	dw ?
		
		;variables for triangle
		triA_formula 	db	'A = (1/2) * b * h $'
		base_str 	db 		'Enter a value for base(numbers between 0-9): $'
		height_str 	db		'Enter a value for height(numbers between 0-9): $'
		base	db ?
		height	db ?
		triArea dw ?
		
		triP_formula	db	'P = a + b + c $'
		side_c		db		'Enter a value for side c(numbers between 0-9): $'
		triSide_a 	db ?
		triSide_b	db ?
		triSide_c	db ?
		triPerim	dw ?
		
		
		quot	dw ?
		modu	dw ?
		
		x		db ?
		y		db ?
		baHe 	dw ?
		
		quot_str	db		 'The quotient for area of triangle = $'
		modu_str 	db		0ah, 0dh, 'The remainder for area of triangle = $'
		
	
		
		DECIMAL 	db '00000$'
		numError_msg db 'ERROR! Please enter a number between 0 and 9 $'
		
.code


;-------------------------------------------------
;CODE TO CALCULATE AREA OF RECTANGLE
;-------------------------------------------------
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
		
		;checks input if greater than 9
		cmp al, 9
		jg numError
		
		;checks input if less than 0
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
		mul bl				;product of register al and bl - stored in ax
		
		lea si, rectArea
		CALL number2string
		
		lea dx, rectArea	;display area
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
;CODE TO CALCULATE PERIMETER OF RECTANGLE
;-------------------------------------------------

rect_perim proc
		
reEnter1:
		CALL clear_screen
		mov ah,9
		mov dx, offset newline
		int 21h
		
		;display formula for perimeter of rectangle
		mov ah,9
		mov dx, offset rectP_formula
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
		sub al,48
		mov rectSide_a, al
		
		;checks input if greater than 9
		cmp al, 9
		jg numError1
		
		;checks input if less than 0
		cmp al,0
		jl numError1
		
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
		jg numError1
		
		cmp al,0
		jl numError1
		
		mov ah,9
		mov dx, offset newline
		int 21h
		
		xor ax,ax
		mov al, rectSide_a
		add al, rectSide_b
		adc ah, 0
		
		
		mov rectPerim, ax
		
		lea si, rectPerim
		CALL number2string
		
		lea dx, rectPerim
		mov ah,9
		int 21h

		mov dx,offset newline
		mov ah,9
		int 21h
		
		jmp return2
		
		
;error_check
numError1:
			
		CALL clear_screen
			
			mov ah,9
			mov dx, offset numError_msg
			int 21h
		user_enter1:	
			mov ah,1
			int 21h
			cmp al,13
			je goback1
			
			loop user_enter1
goback1:
jmp reEnter1
		
return2:		

		
		ret
rect_perim endp

;------------------------------------------------
;CODE TO CALCULATE AREA OF TRIANGLE
;-------------------------------------------------
triangle_area proc

reEnter2:
		CALL clear_screen
		mov ah,9
		mov dx, offset newline
		int 21h
		
		mov ah,9
		mov dx, offset triA_formula ;display formula
		int 21h
		
		mov ah,9
		mov dx, offset newline
		int 21h
		
		;display message to enter base
		lea dx, base_str
		mov ah,9
		int 21h

		;input digit from user
		mov ah,1
		int 21h
		sub al,48
		mov base, al
		
		;checks input if greater than 9
		cmp al, 9
		jg numError2

		;checks input if less than 0
		cmp al,0
		jl numError2
		
		mov ah,9
		mov dx, offset newline
		int 21h
		
		;display message to enter height
		lea dx, height_str
		mov ah,9
		int 21h
			
		;input digit from user
		mov ah,1
		int 21h	
		sub al,48
		mov height, al
	
		;error check
		cmp al, 9
		jg numError2
		
		cmp al,0
		jl numError2
		
		mov ah,9
		mov dx, offset newline
		int 21h

		xor ax,ax
		mov bl, base
		mov al, height
		mul bl ; base * height
		
		mov dx,0h ;set dividend
		mov bx, 2 ;divisor
		div bx
		
		push dx ;push dx register to store remainder 
		push ax ;push ax register to store quotient
		
		mov ah,9
		mov dx, offset quot_str ;display "quotient is ="
		int 21h
		
		pop ax ;retrieve ax
		
		lea si,baHe 
		CALL number2string
		
		lea dx, baHe ;display quotient
		mov ah,9
		int 21h
		
		pop dx ;retrieve dx
		
		mov modu, dx
		mov ax, modu ;store value of modu in ax register
		
		lea si, modu
		CALL number2string
		
		mov ah,9
		mov dx, offset modu_str ;display "remainder is ="
		int 21h
		
		lea dx, modu ;display remainder
		mov ah,9
		int 21h	
		
		jmp return3 ;if no error
		
		;error_check
numError2:
			
		CALL clear_screen
			
			mov ah,9
			mov dx, offset numError_msg
			int 21h
		user_enter2:	
			mov ah,1
			int 21h
			cmp al,13
			je goback2
			
			loop user_enter2
goback2:
jmp reEnter2
		
return3:		
		ret
triangle_area endp

;------------------------------------------------
;CODE TO CALCULATE PERIMETER OF TRIANGLE
;-------------------------------------------------
triangle_perim proc

reEnter3:
		CALL clear_screen
		mov ah,9
		mov dx, offset newline
		int 21h
		
		mov ah,9
		mov dx, offset triP_formula ;display formula
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
		sub al,48
		mov triSide_a, al
		
		;checks input if greater than 9
		cmp al, 9
		jg numError3

		;checks input if less than 0
		cmp al,0
		jl numError3
		
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
		mov triSide_b, al
	
		;error check
		cmp al, 9
		jg numError3
		
		cmp al,0
		jl numError3
		
		mov ah,9
		mov dx, offset newline
		int 21h
		
		;display message to enter side c
		lea dx, side_c
		mov ah,9
		int 21h
			
		;input digit from user
		mov ah,1
		int 21h	
		sub al,48
		mov triSide_c, al
	
		;error check
		cmp al, 9
		jg numError3
		
		cmp al,0
		jl numError3
		
		mov ah,9
		mov dx, offset newline
		int 21h
		
		xor ax,ax
		mov bl, triSide_a
		mov al, triSide_b
		add al,bl
		adc ah,0
		
		mov y, al
		
		mov bl, triSide_c
		add al, bl
		adc ah,0
		
		mov triPerim, ax
		
		lea si, triPerim
		CALL number2string
		
		lea dx, triPerim
		mov ah,9
		int 21h
		
		
		mov dx,offset newline
		mov ah,9
		int 21h
		
		jmp return4 ;if no error
		
		;error_check
numError3:
			
		CALL clear_screen
			
			mov ah,9
			mov dx, offset numError_msg
			int 21h
		user_enter3:	
			mov ah,1
			int 21h
			cmp al,13
			je goback3
			
			loop user_enter3
goback3:
jmp reEnter3
		
return4:		
		ret
triangle_perim endp

;------------------------------------------------
;CODE TO CONVERT NUMBER TO STRING
;-------------------------------------------------

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
;CODE TO CLEAR SCREEN
;-------------------------------------------------

clear_screen proc

		mov ah,2
		mov bh,0
		mov dh,1
		mov dl,1
		int 10h

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

;-------------------------------------------------

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
		
		mov ah,1 ;ask user to choose which shape
		int 21h
		
		cmp al,'1'
		je jump_rect
		
		cmp al,'2'
		je jump_triangle
		
		
		
		

jump_rect:

		CALL clear_screen
		
		mov ah,9
		lea dx, findRect_Tri
		int 21h
		
		
		mov ah,9
		mov dx, offset newline
		int 21h
		
		mov ah,1
		int 21h
		
		cmp al,'1'
		je rA
		
		cmp al,'2'
		je rP
		
		
		
rA:		CALL rect_area

jmp exit1

rP:		CALL rect_perim		
		
		
jmp exit1

jump_triangle:

		CALL clear_screen
		
		mov ah,9
		mov dx, offset findRect_Tri
		int 21h
		
		mov ah,9
		mov dx, offset newline
		int 21h
		
		mov ah,1
		int 21h
		
		cmp al,'1'
		je tA
		
		cmp al,'2'
		je tP


tA: 	CALL triangle_area

jmp exit1

tP:		CALL triangle_perim	
		
exit1:		mov ah,4ch
		int 21h
main endp
end main
