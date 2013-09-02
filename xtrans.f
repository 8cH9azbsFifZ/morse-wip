	FUNCTION XTRANS (IELEM, D0, IRATE)

C	THIS FUNCTION IMPLEMENTS THE CALCULATION OF KEYSTATE
C	TRANSITION PROBABILITY, CONDITIONED ON ELEMENT TYPE,
C	CURRENT DURATION, AND DATA RATE.
C	VARIABLES:
C	IELEM- 	INPUT CURRENT ELEMENT TYPE
C	D0- 	INPUT CURRENT ELEMENT DURATION
C	IRATE - INPUT CURRENT DATA RATE
C	
C	TABLES IN COMMON CONTAIN DENSITY PARMS FOR EACH ELEMENT TYPE, DATA RATE.


	DIMENSION KIMAP (6), APARM (3)
	DATA KIMAP/1, 3, 1, 3, 7, 14/
	DATA APARM/ 3.000, 1.500, 1.000/

C	
C	SCALE DURATION AND OBTAIN DENSITY PARAMETER:
C	       

	MSCALE = KIMAP (IELEM)
	RSCALE = 1200./IRATE
	B0=D0/(MSCALE*RSCALE)
	B1=(D0+5.)/(MSCALE*RSCALE)
	IF (IELEM .EQ. 6) GO TO 20
	IF (IELEM .EQ. 5) GO TO 10
	ALPHA=MSCALE*APARM(1)  
	GO TO 100

10	ALPHA=7.*APARM(2)
	GO TO 100

20	ALPHA=14.*APARM(3)

100	IF (B1 .LE. 1.) GO TO 200
	IF((B0 .LT. 1.) .AND. (B1 .GT. 1.)) GO TO 300
	XTRANS=EXP (-ALPHA*(B1-B0))
	GO TO 400

200	P1=1.-0.5*EXP (ALPHA*(B1-1.))
	P0=1.-0.5*EXP(ALPHA*(B0-1.))
	XTRANS=P1/P0
	GO TO 400

300	P1 = -0.5*EXP(-ALPHA*(B1-1.))
	P0=1.-0.5*EXP(ALPHA*(B0-1.))
	XTRANS=P1/P0

400	RETURN
	END