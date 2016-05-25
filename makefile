
CFLAGS	= -g -Wall -DSUN
# CFLAGS	= -g -Wall -DDEC
CC	= g++
CCF	= $(CC) $(CFLAGS)

H	= .
C_DIR	= .

INCDIR	= -I$(H)
LIBDIRS = -L$(C_DIR)
LIBS    = -lclientReplFs

CLIENT_OBJECTS = client.o network.o 
SERVER_OBJECTS = server.o network.o

all:	appl server

appl:	appl.o $(C_DIR)/libclientReplFs.a
	$(CCF) -o appl appl.o $(LIBDIRS) $(LIBS)

server: $(SERVER_OBJECTS)
	$(CCF) $(SERVER_OBJECTS) -o $@

appl.o:	appl.c client.h appl.h
	$(CCF) -c $(INCDIR) appl.c

$(C_DIR)/libclientReplFs.a:	$(CLIENT_OBJECTS)
	ar cr libclientReplFs.a $(CLIENT_OBJECTS)
	ranlib libclientReplFs.a

client.o:	client.cpp client.h
	$(CCF) -c $(INCDIR) client.cpp

%.o: %.cpp %.h $(includes)
	$(CCF) -c $(INCDIR) $< -o $@

clean:
	rm -f appl *.o *.a

