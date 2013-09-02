	SUBROUTINE INITL

	DIMENSION IELMST(400),ILAMI(16),ILAMX(6)
	DIMENSION ELEMTR(16,6),RTRANS(5,2),ISX(6)
	DIMENSION MEMFCN(400,6),LTRMAP(400)
	DIMENSION MEMDEL(6,6),MEMPR(6,6),IBLANK(400)
	DIMENSION IARRAY(8)
	DIMENSION ITEXT(200)
	CHARACTER*70 IALPH

	COMMON	/BLKLAM/ IELMST,ILAMI,ILAMX
	COMMON	/BLKRAT/ MEMDEL
	COMMON	/BLKELM/ ELEMTR
	COMMON	/BLKSPD/ RTRANS,MEMPR
	COMMON	/BLKMEM/ MEMFCN
	COMMON	/BLKS/ ISX
	COMMON	/BLKTRN/LTRMAP,IBLANK, IALPH
	common	/BLKTXT/ ITEXT


	DATA	ISX/1,1,0,0,0,0/
	DATA	MEMFCN /9,11,13,15,9,11,13,15,9,0,11,0,13,0,15,0,384*0,
     &10,12,14,16,10,12,14,16,0,10,0,12,0,14,0,16,384*0,
     &1,0,0,0,5,0,0,0,1,5,1,5,1,5,1,5,384*0,
     &0,2,0,0,0,6,0,0,2,6,2,6,2,6,2,6,384*0,
     &0,0,3,0,0,0,7,0,3,7,3,7,3,7,3,7,384*0,
     &0,0,0,4,0,0,0,8,4,8,4,8,4,8,4,8,384*0/

	DATA IELMST/1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,384*0/
	DATA ILAMI/3,4,5,6,3,4,5,6,1,2,1,2,1,2,1,2/
	DATA ILAMX/1,1,0,0,0,0/

	DATA LTRMAP/3,4,5,6,3,4,5,6,1,2,1,2,1,2,1,2,384*0/

	DATA IALPH /'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890;:%&'/
C /'A','B','C','D','E','F','G','H','I','J','K','L','M'/
C	2	'N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
C	2	'1','2','3','4','5','6','7'/
C	2	'8','9','0',';',':','%','&',0,0,'^',',','AS','SN',
C	2	0,0,0,0,'NR','NO','GA','OK','AR','SK',0,0,0,0,
C	2	'IMI',0,0,0,0,'BT',0,0,0,'EEE'/

	DATA IBLANK/400*0/
	
	DATA ELEMTR/.55,.6,.5,.5,.56,.5,.5,.5,8*0.,
     &.45,.5,.5,.5,.45,.5,.5,.5,8*0.,
     &8*0.,.581,.54,.923,.923,.923,.93,.92,.95,
     &8*0.,.335,.376,.062,.062,.062,.062,.04,.04,
     &8*0.,.067,.069,.012,.012,.012,.012,.009,.009,
     &8*0.,.015,.015,.003,.003,.003,.003,.001,.001/
	
	DATA RTRANS /.1,.2,.4,.2,.1,.15,.2,.3,.2,.15/
	DATA MEMDEL /0,0,2,2,5,10,0,0,2,2,5,10,
     &2,2,0,0,0,0,2,2,0,0,0,0,2,2,0,0,0,0,
     &2,2,0,0,0,0/
	DATA MEMPR /0,0,1,2,1,2,0,0,1,2,1,2,1,1,0,0,0,0,
     &1,1,0,0,0,0,1,0,0,0,0,0,1,1,0,0,0,0/
	
	OPEN (UNIT=20, FILE='MORSEM')
	DO 10 I=1,300
	READ (20,30) (IARRAY(K),K=1,8)
30	FORMAT(8I3) 
	
	DO 11 K=1,6
11	MEMFCN(I,K) = IARRAY(K+2)
	LTRMAP(I) = IARRAY(1)
	IELMST(I) = IARRAY(2) 
	IF ((IELMST(I).EQ.7).OR.(IELMST(I).EQ.3))  IBLANK(I) = 1
	IF ((IELMST(I).EQ.8).OR.(IELMST(I).EQ.4))  IBLANK(I) = 2
10	CONTINUE 
	
	ENDFILE 20 
	OPEN(UNIT=20,FILE='OUTPUT')
	DO 50 I=1,300
	WRITE(20,40) (MEMFCN(I,K),K=1,6)
40	FORMAT(10X,6(I3,2X))
	
50	CONTINUE 
	ENDFILE 20 
	
	OPEN(UNIT=20,FILE='TEXT')
	DO 60 I=1,108 
	READ(20,70) ITEXT(I)
70	FORMAT(I2) 
60	CONTINUE
	ENDFILE 20 
	
	RETURN 
	END 
	