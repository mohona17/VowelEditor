.global main
.text

main:
  #Prompting the user
  ldr x0, =inputprompt
  bl printf

  #Getting user string
    ldr x0, =input
    ldr x1, =input_buffer1
    bl scanf

#Storing input into x21
  ldr x4, =input_buffer1
  mov x22, x4

#Counter for loop. keeps track of where we are in the string.
  mov x21, #0

#branch to loop which iterates through the string
bl loop

#exit
mov x0, #42
mov x8, #93
svc #0

ret

loop:
# w24 holds the current character we are checking
ldrb w24,[x22, x21]
# increment Counter
add x21, x21, #1

#checking if vowel. if its a vowel, branch to replace which just prints an x out
cmp w24,#97
beq replace
cmp w24,#65
beq replace
cmp w24,#101
beq replace
cmp w24,#69
beq replace
cmp w24,#105
beq replace
cmp w24,#73
beq replace
cmp w24,#111
beq replace
cmp w24,#79
beq replace
cmp w24,#117
beq replace
cmp w24,#85
beq replace

#if the current character is not a vowel, then the below code is called
ldr x0, =charbuffer
#moves the current character which is in w24 to x1 to be printed
mov w1, w24
bl printf

#when there are no more characters in the string, exit
cbz w24, loopexit
#branch to loop if there are more characters
bl loop

loopexit:

#flush
ldr x0, =newline
bl printf

#once the loop is finished, program can be exitted
b exit

replace:
#replace is called when there is a vowel

ldr x0, =charbuffer
#120 is the ascii for x
mov w1, #120

#print an x when the current character is a vowel
bl printf

#call loop to check the next character. alternative to using br x30.
b loop

.section .data
inputprompt: .asciz "Input a string: "
input: .asciz "%[^\n]"
input_buffer1: .space 256
charbuffer: .asciz "%c"
newline: .asciz "\n"
