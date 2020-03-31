C ****************************************************
C   FRANK MANU
C   SPRING 2020
C   EECE.5200 - COMPUTER AIDED ENGINEERING ANAYLSIS
C   PROBLEM SET 3 - PART 3
C ****************************************************

	IMPLICIT REAL (A-H,O-Z)
	IMPLICIT INTEGER(I-N)

	PARAMETER(LDA=9,M=LDA,N=3)

	REAL P(11),Y(11)
	REAL A(LDA,N),W(M),C(N)
	REAL V(LDA,N),U(LDA,M),SIGMA(N),SCRATCH(N)
	REAL BHAT(N),Z(N)

C[] YEARS SCALED BY 10
	Y(1)= 19.00
	Y(2)= 19.10
	Y(3)= 19.20
	Y(4)= 19.30
	Y(5)= 19.40
	Y(6)= 19.50
	Y(7)= 19.60
	Y(8)= 19.70
	Y(9)= 19.80
	Y(10)= 19.90
	Y(11)= 20.00

C[] POPULATION SCALED BY 100,000
	P(1)=75.994575
	P(2)=91.972266
	P(3)=105.710620
	P(4)=122.775046
	P(5)=131.669275
	P(6)=150.697361
	P(7)=179.323175
	P(8)=203.235298
	P(9)=227.224681
	P(10)=249.438712
	P(11)=281.421906

	DO I=1,M
		A(I,1)=1
		A(I,2)=Y(I)
		A(I,3)=Y(I)**2
		W(I) = P(I)
	ENDDO

C[] MATRIX DECOMPOSITION
	CALL SVD(LDA,M,N,A,SIGMA,1,U,1,V,IERR,SCRATCH)

	ARGMIN = 1E6
	DO I=1,N
		WRITE(*,*) I,SIGMA(I)
		IF (SIGMA(I).LT.ARGMIN) THEN
			ARGMIN = SIGMA(I)
			INDEX=I
		ENDIF
	ENDDO

	PRINT *,''

	DO I=1,N
		BHAT(I)=0
		DO K=1,M
			BHAT(I)=BHAT(I) +U(K,I)*W(K)
		ENDDO

		IF (I.NE.INDEX) THEN
			Z(I)= BHAT(I)/SIGMA(I)
		ELSE
			Z(I)=0
		ENDIF
	ENDDO

	DO I=1,N
		C(I)=0
		DO J=1,N
			C(I)= V(I,J)*Z(J) +C(I)
		ENDDO
	ENDDO

	DO I=1,N
		WRITE(*,*) I,C(I)
	ENDDO

C[] WRITING ITEMS TO FILE
	OPEN(10,FILE='svd.dat')
	DO I=1,11
		ARG = C(1) +C(2)*Y(I) +C(3)*Y(I)*Y(I)
		WRITE(10,*) Y(I),ARG, P(I)
	ENDDO

C[] CLOSING FILE
	CLOSE(10)

	END
