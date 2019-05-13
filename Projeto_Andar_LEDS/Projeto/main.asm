;
; AssemblerApplication2.asm
;
; Created: 06/05/2019 09:56:47
; Author : u17188
;

.nolist      
.include "m32U4def.inc"    ; defini??o do processador escolhido
.list

.def		al      = r16
.def 		Delay	= r17 ; Delay variable 1
.def		Delay2	= r18 ; Delay variable 2
.def		Delay3	= r19 ; Delay variable 2

.org 0x0000 //seta o ponteiro de onde vai escrever o codigo (vai para o comeco)
	RJMP ON_RESET ;RESET VECTOR (vetor de interrupcao)

ON_RESET:
	//Config de Stack Pointer 
	ldi 	R16, high(RAMEND)
	out 	SPH, R16
	ldi 	R16, low(RAMEND)
	out 	SPL, R16

	LDI		al, 0b11111110 ;1=saida, 0=entrada
	Out		DDRB, al ;abre o B para escrita
	Out		DDRC, al ;abre o B para escrita
	Out		DDRD, al ;abre o B para escrita


start:

	Rcall apagar_todas_leds

	ldi r22, 0 ; (numero de leds acesas do bloco) - 1
	loop1:
		; acende a led seguinte
		mov al, r22
		inc al
		Rcall acender_led

		; loop que anda para DIREITA com as leds que estao acesas (acende a primeira led apagada a esquerda do bloco de leds acesas, e apaga a ultima led da direita do bloco de leds acesas)
		mov r20, r22 ;registrador com o indice da led que vai ser acesa
		ldi r21, 0 ;registrador com o indice da led que vai ser apagada
		loop_acender:
			mov al, r20
			Rcall acender_led
			Rcall delay_100

			mov al, r21
			Rcall apagar_led
		
			cpi r20, 12
			breq fora_loop_acender

			inc r20
			inc r21

			rjmp loop_acender
		fora_loop_acender:

		; seta r20 (para andar para esquerda)
		ldi r20, 12 ;registrador com o indice da led que vai ser acesa
		ldi al, 0
		subt_r20: ;faz -(r22+1) em r20
			cp al, r22
			breq fora_subt

			dec r20
			inc al
			rjmp subt_r20
		fora_subt:

		; loop que anda para ESQUERDA com as leds que estao apagadas (acende a primeira led apagada a direita do bloco de leds acesas, e apaga a ultima led da esquerda do bloco de leds acesas)
		ldi r21, 12 ;registrador com o indice da led que vai ser apagada
		loop_apagar:
			mov al, r20
			Rcall acender_led
			Rcall delay_100

			mov al, r21
			Rcall apagar_led
		
			dec r20
			dec r21

			cpi r20, 1
			brne loop_apagar

		; da um tempo para mostrar o ultimo (todas acesas)
		Rcall acender_1
		Rcall delay_100
		Rcall delay_100

		; incrementa o numero de leds acesas do bloco na proxima execucao do loop
		inc r22

		cpi r22, 11
		brne loop1

		;quando vai voltar a acender apenas uma
		ldi r22, 0
		Rcall acender_todas_leds
		Rcall delay_100
		Rcall delay_100
		Rcall apagar_todas_leds
		Rcall delay_100
		Rcall delay_100
		rjmp loop1

	rjmp 		start		 ; volta ao inicio


; procedimentos auxiliares importantes
acender_led: ;ascende a led al (considera-se a sequencia das leds no micro-processador)
	cpi al, 1
	brne a_led_2
	Rcall acender_1
	rjmp fim_a_led

	a_led_2:
	cpi al, 2
	brne a_led_3
	Rcall acender_2
	rjmp fim_a_led

	a_led_3:
	cpi al, 3
	brne a_led_4
	Rcall acender_3
	rjmp fim_a_led

	a_led_4:
	cpi al, 4
	brne a_led_5
	Rcall acender_4
	rjmp fim_a_led

	a_led_5:
	cpi al, 5
	brne a_led_6
	Rcall acender_5
	rjmp fim_a_led

	a_led_6:
	cpi al, 6
	brne a_led_7
	Rcall acender_6
	rjmp fim_a_led

	a_led_7:
	cpi al, 7
	brne a_led_8
	Rcall acender_7
	rjmp fim_a_led

	a_led_8:
	cpi al, 8
	brne a_led_9
	Rcall acender_8
	rjmp fim_a_led

	a_led_9:
	cpi al, 9
	brne a_led_10
	Rcall acender_9
	rjmp fim_a_led

	a_led_10:
	cpi al, 10
	brne a_led_11
	Rcall acender_10
	rjmp fim_a_led

	a_led_11:
	cpi al, 11
	brne a_led_12
	Rcall acender_11
	rjmp fim_a_led

	a_led_12:
	cpi al, 12
	brne fim_a_led
	Rcall acender_12
	rjmp fim_a_led

	fim_a_led:
	ret

apagar_led: ;apagar a led al (considera-se a sequencia das leds no micro-processador)
	cpi al, 1
	brne b_led_2
	Rcall apagar_1
	rjmp fim_b_led

	b_led_2:
	cpi al, 2
	brne b_led_3
	Rcall apagar_2
	rjmp fim_b_led

	b_led_3:
	cpi al, 3
	brne b_led_4
	Rcall apagar_3
	rjmp fim_b_led

	b_led_4:
	cpi al, 4
	brne b_led_5
	Rcall apagar_4
	rjmp fim_b_led

	b_led_5:
	cpi al, 5
	brne b_led_6
	Rcall apagar_5
	rjmp fim_b_led

	b_led_6:
	cpi al, 6
	brne b_led_7
	Rcall apagar_6
	rjmp fim_b_led

	b_led_7:
	cpi al, 7
	brne b_led_8
	Rcall apagar_7
	rjmp fim_b_led

	b_led_8:
	cpi al, 8
	brne b_led_9
	Rcall apagar_8
	rjmp fim_b_led

	b_led_9:
	cpi al, 9
	brne b_led_10
	Rcall apagar_9
	rjmp fim_b_led

	b_led_10:
	cpi al, 10
	brne b_led_11
	Rcall apagar_10
	rjmp fim_b_led

	b_led_11:
	cpi al, 11
	brne b_led_12
	Rcall apagar_11
	rjmp fim_b_led

	b_led_12:
	cpi al, 12
	brne fim_b_led
	Rcall apagar_12
	rjmp fim_b_led

	fim_b_led:
	ret

apagar_todas_leds:
	Ldi al, 0x00
	out PORTB, al
	out PORTC, al
	out PORTD, al
	ret

acender_todas_leds:
	Ldi al, 0xff
	out PORTB, al
	out PORTC, al
	out PORTD, al
	ret

; DELAY
delay_100: ; label do procedimento
	Ldi		Delay3,  4
DLY:
	dec   Delay	; decrementa 255
	brne  DLY
	dec   Delay2 ; decrementa 255 
	brne  DLY
	dec   Delay3 ; decrementa 100
	brne  DLY
	ret ; final do proc


; procedimentos auxiliares basicos
acender_1:
	sbi PORTB, 7
	ret

apagar_1:
	cbi PORTB, 7
	ret

acender_2:
	sbi PORTB, 3
	ret

apagar_2:
	cbi PORTB, 3
	ret

acender_3:
	sbi PORTB, 1
	ret

apagar_3:
	cbi PORTB, 1
	ret

acender_4:
	sbi PORTB, 2
	ret

apagar_4:
	cbi PORTB, 2
	ret

acender_5:
	sbi PORTD, 4
	ret

apagar_5:
	cbi PORTD, 4
	ret

acender_6:
	sbi PORTD, 6
	ret

apagar_6:
	cbi PORTD, 6
	ret

acender_7:
	sbi PORTD, 7
	ret

apagar_7:
	cbi PORTD, 7
	ret

acender_8:
	sbi PORTB, 4
	ret

apagar_8:
	cbi PORTB, 4
	ret

acender_9:
	sbi PORTB, 5
	ret

apagar_9:
	cbi PORTB, 5
	ret

acender_10:
	sbi PORTB, 6
	ret

apagar_10:
	cbi PORTB, 6
	ret

acender_11:
	sbi PORTC, 6
	ret

apagar_11:
	cbi PORTC, 6
	ret

acender_12:
	sbi PORTC, 7
	ret

apagar_12:
	cbi PORTC, 7
	ret
