C ****************************************************
C   FRANK MANU
C   SPRING 2020
C   EECE.5200 - COMPUTER AIDED ENGINEERING ANAYLSIS
C   PROBLEM SET 3 - PART 1
C ****************************************************

	PARAMETER (LDA =10, N=3)

	REAL A(LDA,LDA),B(LDA,LDA),X (LDA)
	REAL WR(LDA), WI(LDA), Z(LDA,LDA)
	REAL ALAMBDA_RE(LDA),ALAMBDA_IM(LDA),E(N,N),EINV(N,N),DUM(N,N)

c[] MATRIX A DEFINITION
	DATA (A(1,J),J=1,3) / -2.0, 1.0, 2.0/
	DATA (A(2,J),J=1,3) /  2.0, 3.0, -2.0/
	DATA (A(3,J),J=1,3) / 1.0,  -2.0, 3.0/

c[] MATRIX B DEFINITION
	DATA (B(1,J),J=1,3) / -2.0, 2.0, 4.0/
	DATA (B(2,J),J=1,3) / 3.0, 1.0, -1.0/
	DATA (B(3,J),J=1,3) / 0.0, 0.0, 1.0E-4/

C[] CALL GESS
	CALL GESS (N,A,LDA,B,LDA,N,COND)

C[] DETERMINE  1/ EIGENVALUES
	CALL EIGEN(LDA,N,B,WR,WI,Z)

	DO I=1,N
	    ARE =  WR(I)/ (WR(I)*WR(I) + WI(I)*WI(I))
	    AIM = -WI(I)/ (WR(I)*WR(I) + WI(I)*WI(I))
        ALAMBDA_RE(I)=ARE
        ALAMBDA_IM(I)=AIM
        WRITE(*,*) I, ARE,AIM
	ENDDO

C FOR REAL EIGENVALUES
        DO I=1,N
            DO J=1,N
                E(I,J) = Z(I,J)
            ENDDO
        ENDDO

        EINV=0
        DO I=1,N
            EINV(I,I)=1.0
            DO J=1,N
                DUM(I,J)=E(I,J)
            ENDDO
        ENDDO

        CALL GESS (N,DUM,N,EINV,N,N,COND)
        
        PRINT *,''
        WRITE(*,*) '[',(E(1,J),J=1,N),'] [',(EINV(1,J),J=1,N),']'
        WRITE(*,*) '[',(E(2,J),J=1,N),'] [',(EINV(2,J),J=1,N),']'
        WRITE(*,*) '[',(E(3,J),J=1,N),'] [',(EINV(3,J),J=1,N),']'

        PRINT *,''
        WRITE(*,*) 'E1=10^( ', ALAMBDA_RE(1),'t',')'
        WRITE(*,*) 'E2=10^( ', ALAMBDA_RE(2),'t',')'
        WRITE(*,*) 'E3=10^( ', ALAMBDA_RE(3),'t',')'
	END
