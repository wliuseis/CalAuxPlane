BIN = .

all: CalAuxPlane clean

CalAuxPlane: CalAuxPlane.o
	gfortran -o ${BIN}/CalAuxPlane CalAuxPlane.o

CalAuxPlane.o: CalAuxPlane.f
	gfortran -c CalAuxPlane.f

clean:
	rm -f *.o
