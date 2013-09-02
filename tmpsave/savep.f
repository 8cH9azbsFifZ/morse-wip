	SUBROUTINE SAVEP(P,PATHSV,ISAVE,IMAX,LAMSAV,DURSAV,ILRSAV,LAMBDA,
     &DUR,ILRATE,SORT)
C	2	DUR,ILRATE,SORT)


C
C	THIS SUBROUTINE PERFORMS THE ALGORITM TO SAVE
C	THE PATHS WITH HIGHEST POSTERIOR PROBABILITY.
C	IT WILL SAVE A MINIMUM OF 7 PATHS (ONE FOR EACH
C	ELEMENT STATE AND ONE ADDITIONAL NODE), AND
C	A MAXIMUM OF 25 PATHS.  WITHIN THESE LIMITS, IT
C	SAVED ONLY ENOUGH TO MAKE THE TOTAL SAVED PROBABILITY
C	EQUAL TO POPT.
C
C
C	ADDITIONALLY, IT RESORTS THE LAMBDA,DUR,AND ILRATE
C	ARRAYS TO CORRESPOND TO THE SAVED NODES.
C
C
C	VARIABLES:
C		P-	INPUT PROBABILITY ARRAY OF NEW NODES
C		PATHSV-	OUTPUT ARRAY OF THE PREVIOUS NODES TO
C			WHICH THE SAVED NODES ARE CONNECTED.
C		ISAVE-	INPUT: NO. OF PREVIOUS NODES SAVED
C 
C			OUPUT: NO. OF NODES SAVED AT CURRENT STAGE
C		IMAX-	INDEX OF HIGHEST PROBABILITY NODE
C		LAMSAV-	INPUT ARRAY OF LTR STATES AT EACH NEW NODE
C		DURSAV-	INPUT ARRAY OF SAVED DURATIONS
C		ILRSAV-	INPUT ARRAY OF SAVED RATES
C		LAMBDA-	OUTPUT ARRAY OF SAVED LTR STATES, SORTED
C
C			ACCORDING TO PROBABILITY
C		DUR-	OUTPUT ARRAY OF SORTED DURATIONS
C		ILRATE-	OUTPUT ARRAY OF SORTED RATES
C
C

	INTEGER PATHSV,SORT
	DIMENSION P(750),PATHSV(25),PSAV(25),SORT(25)
	DIMENSION LAMSAV(750),DURSAV(750),ILRSAV(750)
	DIMENSION LAMBDA (25), DUR (25), ILRATE(25) 
	DIMENSION YKKIP(25), PKKIP(25)
	DIMENSION YKKSV(750), PKKSV(750) 
	DIMENSION ICONV(25)
	COMMON/BLKSV1/YKKIP,PKKIP,YKKSV,PKKSV
	DATA POPT/.90/

	NSAV=0
	PSUM=0.

C	SELECT SIX HIGHEST PROB ELEMENT STATE NODES:

	DO 200 K=1,6
	PMAX=0.

	DO 100 IP=1, ISAVE 
	DO 100 I=1,5

	J=(IP-1)*30+(I-1)*6+K
	IF (P(J) .LT. PMAX) GO TO 100
	PMAX=P(J)
	JSAV=J
	IPSAV=IP
100	CONTINUE

	IF (PMAX .GE. 0.000001) GO TO 150
	GO TO 200

150	NSAV=NSAV+1
	PSUM=PSUM+PMAX
	PSAV(NSAV)=PMAX
	PATHSV(NSAV)=IPSAV
	SORT(NSAV)= JSAV

200	CONTINUE

C	SELECT ENOUGH ADDITIONAL NODES TO MAKE TOTAL
C	PROBABILITY SAVED EQUAL TO POPT, OR A MAX OF 25:


520	PMAX=0.
	DO 500 IP=1, ISAVE
	DO 500 N=1, 30
	J=(IP-1)*30+N
	DO 510 I=1, NSAV
	IF (J .EQ. SORT(I)) GO TO 500

510	CONTINUE

	IF (P(J).LE.PMAX) GO TO 500
	PMAX = P(J)
	JSAV=J
	IPSAV=IP
500	CONTINUE

	PSUM=PSUM+PMAX
	NSAV=NSAV+1
	PSAV(NSAV)=PMAX
	PATHSV(NSAV)=IPSAV
	SORT(NSAV)=JSAV
	
	
	IF(PSUM.GE.POPT) GO TO 600
	IF(NSAV.GE.25    ) GO TO 600
	GO TO 520

C	NEW ISAVE EQUALS NO. OF NODES SAVED:

600 	ISAVE=NSAV

C	SORT THE SAVED ARRAYS TO OBTAIN THE ARRAYS
C	TO BE USED FOR THE NEXT ITERATION:
C	ALSO OBTAIN HIGHEST PROBAILITY NODE:

	DO 700 I=1,ISAVE
	P(I)=PSAV(I)/PSUM
	LAMBDA(I)=LAMSAV(SORT(I))
	DUR(I)=DURSAV(SORT(I))
	ILRATE(I)=ILRSAV(SORT(I))
	YKKIP(I)=YKKSV(SORT(I))
	PKKIP(I)=PKKSV(SORT(I))

700 	CONTINUE

	DO 790 I=1,ISAVE
	ICONV(I)=1
790	CONTINUE

	ISAVM1=ISAVE-1

	DO 800   N=1,ISAVM1
	IF(ICONV(N).EQ.0)  GO  TO  800
	
	NPLUS1=N+1
	DO 810  K=NPLUS1,ISAVE
	IF(ICONV(K).EQ.O)  GO  TO  810

	IF(ILRATE(K).NE.ILRATE(N))  GO  TO  810
	IF(DUR(K).NE.DUR(N))  GO  TO  810
	IF(LAMBDA(K).NE.LAMBDA(N))  GO  TO  810
	ICONV(K)=0

810	CONTINUE
800	CONTINUE

	PSUM=0.
	N=1

	DO 900  I=2,ISAVE
	IF (ICONV(I).EQ.0)  GO  TO  900
	N=N+1
	LAMBDA(N)=LAMBDA(I)
	DUR(N)=DUR(I)
	ILRATE(N)=ILRATE(I)
	YKKIP(N)=YKKIP(I)
	PKKIP(N)=PKKIP(I)
	PATHSV(N)=PATHSV(I)
	SORT(N)=SORT(I)
	P(N)=P(I)
	PSUM=PSUM+P(N)

900	CONTINUE
	ISAVE=N
	PMAX=0.
	
	DO 950 I=1,ISAVE
	P(I)=P(I)/PSUM
	IF(P(I).LE.PMAX) GO TO 950
	PMAX=P(I)
	IMAX=I
950	CONTINUE 

	RETURN 
	END