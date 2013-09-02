	SUBROUTINE KEY(DUR,X)

	DIMENSION ESEP (6),EDEV(6),MORSE(10,40)
	DIMENSION IOUTP(500)
	DIMENSION ITEXT(200)
	DIMENSION ISYMBL(6)
C	CHARACTER*6 ISYMBL
	COMMON/BLKEND/IEND

	COMMON/BLK1/TAU/PLK6/DMEAN,XDUR,ESEP,EDEV
	COMMON/BLKTXT/ITEXT

	DATA IK/0001000000000/
	DATA LTR/20/,NELM/0/, N/0/, NLTR/1/

	DATA MORSE/1,3,2,0,0,0,0,0,0,0,
     &2,3,1,3,1,3,1,0,0,0,2,3,1,3,1,3,1,0,0,0,
     &2,3,1,3,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,
     &1,3,1,3,2,3,1,0,0,0,2,3,2,3,1,0,0,0,0,0,
     &1,3,1,3,1,3,1,0,0,0,1,3,1,0,0,0,0,0,0,0,
     &1,3,2,3,2,3,2,0,0,0,2,3,1,3,2,0,0,0,0,0,
     &1,3,2,3,1,3,1,0,0,0,2,3,2,0,0,0,0,0,0,0,
     &2,3,1,0,0,0,0,0,0,0,2,3,2,3,2,0,0,0,0,0,
     &1,3,2,3,2,3,1,0,0,0,2,3,2,3,1,3,2,0,0,0,
     &1,3,2,3,1,0,0,0,0,0,1,3,1,3,1,0,0,0,0,0,
     &2,0,0,0,0,0,0,0,0,0,1,3,1,3,2,0,0,0,0,0,
     &1,3,1,3,1,3,2,0,0,0,1,3,2,3,2,0,0,0,0,0,
     &2,3,1,3,1,3,2,0,0,0,2,3,1,3,2,3,2,0,0,0,
     &1,3,1,3,2,3,2,3,2,0,1,3,1,3,1,3,2,3,2,0,
     &1,3,1,3,2,3,2,3,2,0,1,3,1,3,1,3,2,3,2,0,
     &1,3,1,3,1,3,1,3,2,0,1,3,1,3,1,3,1,3,1,0,
     &2,3,1,3,1,3,1,3,1,0,2,3,2,3,1,3,1,3,1,0,
     &2,3,2,3,2,3,1,3,1,0,2,3,2,3,2,3,2,3,1,0,
     &2,3,2,3,2,3,2,3,2,0,40*0/

C	2	2,3,1,3,1,3,1,0,0,0,2,3,1,3,1,3,1,0,0,0,
C	2	2,3,1,3,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,
C	2	1,3,1,3,2,3,1,0,0,0,2,3,2,3,1,0,0,0,0,0,
C	2	1,3,1,3,1,3,1,0,0,0,1,3,1,0,0,0,0,0,0,0,
C	2	1,3,2,3,2,3,2,0,0,0,2,3,1,3,2,0,0,0,0,0,
C	2	1,3,2,3,1,3,1,0,0,0,2,3,2,0,0,0,0,0,0,0,
C	2	2,3,1,0,0,0,0,0,0,0,2,3,2,3,2,0,0,0,0,0,
C	2	1,3,2,3,2,3,1,0,0,0,2,3,2,3,1,3,2,0,0,0,
C	2  1,3,2,3,1,0,0,0,0,0,1,3,1,3,1,0,0,0,0,0,
C	2  2,0,0,0,0,0,0,0,0,0,1,3,1,3,2,0,0,0,0,0,
C	2  1,3,1,3,1,3,2,0,0,0,1,3,2,3,2,0,0,0,0,0,
C	2  2,3,1,3,1,3,2,0,0,0,2,3,1,3,2,3,2,0,0,0,
C	2  1,3,1,3,2,3,2,3,2,0,1,3,1,3,1,3,2,3,2,0,
C	2  1,3,1,3,2,3,2,3,2,0,1,3,1,3,1,3,2,3,2,0,
C	2  1,3,1,3,1,3,1,3,2,0,1,3,1,3,1,3,1,3,1,0,
C	2  2,3,1,3,1,3,1,3,1,0,2,3,2,3,1,3,1,3,1,0,
C	2  2,3,2,3,2,3,1,3,1,0,2,3,2,3,2,3,2,3,1,0,
C	2  2,3,2,3,2,3,2,3,2,0,40*0/

	DATA ISYMBL/1H.,1H-,1H ,1H;,1H/,1H~/


C	CHARACTER*500 IOUTP

	BETA=1000.*TAU*DUR
	IF(BETA .LT. XDUR) GO TO 200
	NELM=NELM+1
	IELM=MORSE(NELM,LTR)
	IF(IELM.NE. 0) GO TO 100
	NELM=0
	Y=RAND(IK)
	IELM=4
	IF(Y .GT. .9) IELM=5
	IF((Y.LE. .9).AND.(Y.GT. .3)) IELM=6
	Y=RAND(IK)
	Y=35*(Y-0.001)+1.
	IY=Y
	LTR=IY+1
	GO TO 100


	NLTR=NLTR+1
	LTR=ITEXT(NLTR)
	IF(LTR .EQ. 0) IELM=4
	IF(LTR .EQ. 37)IELM=5
	IF(LTR .EQ. 38)IELM=6
	NLTR=NLTR+1
	LTR=ITEXT(NLTR)

100	N=N+1
	IOUTP(N)=ISYMBL(IELM)
	IF(N .LT. 300) GO TO 110
	N=0
	NLTR=0
	TEND=1
	PRINT 90
90	FORMAT(1X,'END OF RUN; INPUT DATA WAS:')

	DO 10 K=1,10
	K1=(K-1)*50+1
	K2=K*50
	PRINT 105,(IOUTP(L), L=K1,K2)
105	FORMAT(1X,50A1)
10	CONTINUE

	READ 105,KAIT

110	XM=ESEP(IELM)*DMEAN
	XSIGM=EDEV(IELM)*DMEAN
	Y=RAND(IK)
	Y=2.*(Y-.5)
	XDUR=XM+Y+XSIGM
	IF(XDUR .LT. 20.) XDUR=20.
	X=1.
	IF(IELM .GE. 3) X=0

200	RETURN
	END