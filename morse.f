	PROGRAM MORSE

	INTEGER ELMHAT, XHAT, IPMAX
	REAL X, ZOUT, RN,SPDHAT
	DIMENSION S1(512), S2(512), S3(512), S4(512)

	DATA RN/.1/
	DATA NP/0/
C	CALL SRAND(86456)
	CALL INITL
	CALL INPUTL
	PRINT 4 
4	FORMAT('MORSE:, X, PMAX, IPMAX, ELMHAT, ZSIG,RN,SPDHAT,ZDET')

1  	DO 2 N1=1,512
	DO 3 N2=1,18
	CALL SIMSGI(X,ZSIG)
	CALL RCVR(ZSIG,ZRCV)
	CALL BPFDET(ZRCV,ZDET)
	NP=NP+1
C	DECIMATE 4 kHz by 40  down to 100Hz - 5 ms sample time for PROCES
	IF(NP.LT.40) GO TO 3
	NP=0

	CALL NOISE(ZDET,RN,ZOUT)
C	RN = RAND()
	RN=0.01
	CALL PROCES(X,RN,XHAT,PX,ELMHAT,LTRHAT, SPDHAT, IMAX,PMAX)
3	CONTINUE

	N=N1
C	PRINT 5, X,  PMAX, IMAX, ELMHAT,ZSIG, RN, SPDHAT, ZDET
C5	FORMAT('MORSE:',2(F10.3,2X),2(I7,1X),4(F10.3,2X) )
	CALL STATS(ZDET,Z,PX,XHAT,S1,S2,S3,S4,N)
2	CONTINUE

C	CALL DISPLA(S1,S2,S3,S4)

	GO TO 1
	STOP
	END 