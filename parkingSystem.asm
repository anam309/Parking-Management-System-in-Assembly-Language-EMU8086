.model small
.stack 100h
.data


data1 db 0dh,0ah,0, 'enter user name:$'
data2 db 0dh,0ah,0, 'enter user ID:$'
;username db 100,0    
;userid db 100,0
  BUFFER DB 100 DUP('$') 
  HANDLE dw ?    
BUFFER1 db 100 dup('$')
    HANDLE1 dw ?
filename db "mydata.txt", 0
username db "$",80 dup(0)   
rickshaw db "$",80 dup(0)
carr db "$",80 dup(0)   
bbus db "$",80 dup(0)
userid db "$",80 dup(0)
newline db 0dh, 0ah, '$' ; 
menu db  0dh,0ah,0, '*MENU*$'
menu1 db 'Press 1 for rikshw$'
menu2 db 'Press 2 for cars$'
menu3 db 'Press 3 for bus$'
menu4 db 'Press 4 to show the record$'
menu5 db 'Press 5 to delete the record$'
menu6 db 'Press 6 to exit$'
msg1 db 'Parking Is Full$'
msg2 db 'Wrong input$'
msg3 db 'car$'
msg4 db 'bus$'
msg5 db 'record$'
msg6 db 'there is more space$'
msg7 db 'the total amount is=$'
msg8 db 'the total numbers of vehicles parked=$'
msg9 db 'the total number of rikshws parked=$'
msg10 db 'the total number of cars parked=$'
msg11 db 'the total number of buses parked=$'
msg12 db 'Record deleted successfully$'

amount dw 0
count dw  '0'
am1 dw ?
am2 dw ?
am3 dw ?


r dw '0'
c db '0'
b db '0'
.code
main proc
mov ax,@data
mov ds,ax

;mov cx,count

;mov cx,0

while_:


;display name

 mov dx,offset data1
mov ah,9
int 21h
mov ah, 0Ah ; function code for reading string
mov dx, offset username ; buffer address
mov al, 20 ; maximum number of characters to read
int 21h  

; open existing file or create new file
   mov ah, 3dh ; open file
    lea dx, filename
    mov cx,0
    mov al, 2 ; open mode (read/write)
    int 21h ; returns file handle in AX
    
    
 mov bx, ax ; save file handle
    
    ; seek to end of file
   mov ah, 42h ; move file pointer
    mov al, 2 ; offset mode (from end of file)
    mov cx, 0 ; high word of offset (not used)
    mov dx, 0 ; low word of offset (0 bytes from end of file)
    int 21h
; write input to file
    mov ah, 40h ; write to file
    mov cx, 79 ; number of bytes to write
    lea dx, username ; address of buffer   
    inc dx
    inc dx
    int 21h 
  ;read data in file 
  mov ax, @data
    mov ds, ax
  mov HANDLE, ax
  mov ah, 3fh
    mov bx, HANDLE
    lea dx, BUFFER
    mov cx, 100
    int 21h
     
    mov ah, 9h
    lea dx, BUFFER
    int 21h


 ;display ID       
 mov dx,offset data2
mov ah,9
int 21h
mov ah, 0Ah ; function code for reading string
        mov dx, offset userid ; buffer address
        mov al, 20 ; maximum number of characters to read
        int 21h   
        ; seek to end of file
    mov ah, 42h ; move file pointer
    mov al, 2 ; offset mode (from end of file)
    mov cx, 0 ; high word of offset (not used)
    mov dx, 0 ; low word of offset (0 bytes from end of file)
    int 21h
        ; write input to file
    mov ah, 40h ; write to file
    mov cx, 79 ; number of bytes to write
    lea dx, userid ; address of buffer   
    inc dx
    inc dx
    int 21h 
     

   ; close file
    mov ah, 3eh
    mov bx, ax ; file handle
    int 21h 
    
     
 ;Menu
mov dx,offset menu
mov ah,9
int 21h

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h


mov dx,offset menu1
mov ah,9
int 21h

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h


mov dx,offset menu2
mov ah,9
int 21h

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h


mov dx,offset menu3
mov ah,9
int 21h
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h




mov dx,offset menu4
mov ah,9
int 21h
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h



mov dx,offset menu5
mov ah,9
int 21h
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h


mov dx,offset menu6
mov ah,9
int 21h
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h




  ;userinput

mov ah,1
int 21h
mov bl,al
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h

  ;now compare
mov al,bl
cmp al,'1'
je rikshw
cmp al,'2'
je car


cmp al,'3'
je bus
cmp al,'4'
je rec
cmp al,'5'
je del
cmp al,'6'
je end_


mov dx,offset msg2
mov ah,9
int 21h

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h
jmp while_

rikshw:
call rikshaw 

car:
call caar

rec:
call recrd

del:
call delt

bus:
call buss


end_:
mov ah,4ch
int 21h    


main endp
 


read_file proc
    ; Open the file
    mov ah, 3dh
    mov al, 0
    lea dx, filename
    int 21h
    jc error

    ; Store the file handle
    mov HANDLE1, ax

    ; Read the file
    mov ah, 3fh
    mov bx, HANDLE1
    lea dx, BUFFER1
    mov cx, 100
    int 21h
    jc error

    ; Close the file
    mov ah, 3eh
    mov bx, HANDLE1
    int 21h
    jc error

    ; Return the buffer
    ret


error:
    ; Handle any errors here
    ret


rikshaw proc
cmp count,'8'
jle rikshw1
mov dx,offset msg1
mov ah,9
int 21h
jmp while_
jmp end_

rikshw1:
mov ax,200
add amount, ax
mov dx,0 ; remainder is 0
mov bx,10 
mov cx,0
l2:
        div bx
        push dx
        mov dx,0
        mov ah,0
        inc cx
        cmp ax,0
        jne l2
   
l3:
        pop dx
        add dx,48
        mov ah,2
        int 21h
loop l3
;mov am1,dx
inc count
;mov dx,count
inc r

jmp while_
jmp end_


caar proc
cmp count,'8'
jle car1
mov dx,offset msg1
mov ah,9
int 21h


jmp while_
jmp end_
         
         
car1:
mov ax,300
add amount, ax
 
 

mov dx,0
mov bx,10
mov cx,0


l22:
        div bx
        push dx
        mov dx,0
        mov ah,0
        inc cx
        cmp ax,0
       jne l22
   
l33:
        pop dx
        add dx,48
        mov ah,2
        int 21h
loop l33

;mov am2,amount

inc count
inc c
   
jmp while_
jmp end_




buss proc
cmp count,'8'
jle bus1
mov dx,offset msg1
mov ah,9
int 21h
jmp while_
jmp end_

bus1:
mov ax,400
add amount, ax
mov dx,0
mov bx,10
mov cx,0
l222:
        div bx
        push dx
        mov dx,0
        mov ah,0
        inc cx
        cmp ax,0
       jne l222
   
l333:
        pop dx
        add dx,48
        mov ah,2
        int 21h
loop l333
;mov am3,amount

inc count
inc b
jmp while_
jmp end_


recrd proc
mov dx,offset msg7
mov ah,9
int 21h


; print here the whole amount
mov ax, amount

mov dx,0
mov bx,10
mov cx,0
totalpush:
        div bx
        push dx
        mov dx,0
      ;  mov ah,0
        inc cx
        cmp ax,0
       jne totalpush
   
totalprint:
        pop dx
        add dx,48
        mov ah,2
        int 21h
loop totalprint




mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h

mov dx,offset msg8
mov ah,9
int 21h

mov dx,count
mov ah,2
int 21h

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h


mov dx,offset msg9
mov ah,9
int 21h

mov dx,r
mov ah,2
int 21h

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h



mov dx,offset msg10
mov ah,9
int 21h


mov dl,c
mov ah,2
int 21h

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h



mov dx,offset msg11
mov ah,9
int 21h

mov dl,b
mov ah,2
int 21h

jmp while_
jmp end_


delt proc
mov r,'0'
mov c,'0'
mov b,'0'
mov amount,0
;sub amount,48
mov count,'0'
mov dx,offset msg12
mov ah,9
int 21h

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h 

jmp while_
jmp end_

end main
 ;HLT
