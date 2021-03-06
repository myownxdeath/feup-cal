IDIR= ./headers
GRAPH_DIR=./graph_viewer
CC=g++

CFLAGS= -I $(IDIR) -Wall -Wextra -pthread


ODIR= ./obj

#PROJECT SPECIFIC DEPENDENCIES
_PROJ_DEPS=graph.h utilities.h ui.h trie.h
PROJ_DEPS=$(patsubst %,$(IDIR)/%,$(_PROJ_DEPS))

_PROJ_OBJ=main.o utilities.o trie.o
PROJ_OBJS=$(patsubst %,$(ODIR)/%,$(_PROJ_OBJ))

#GRAPHVIEWER DEPEPNDENCIES
_GRAPH_DEPS=connection.h edgetype.h graphviewer.h
GRAPH_DEPS=$(patsubst %,$(GRAPH_DIR)/%,$(_GRAPH_DEPS))

_GRAPH_OBJ=connection.o graphviewer.o
GRAPH_OBJS=$(patsubst %,$(ODIR)/%,$(_GRAPH_OBJ))

#GATHER ALL OBJECTS IN ONE VARIABLE
OBJS=$(PROJ_OBJS) $(GRAPH_OBJS)

default:proj

#GRAPHVIEWER RULE
$(GRAPH_OBJS): $(GRAPH_DIR)/*.cpp $(GRAPH_DEPS)
	@mkdir -p obj
	@$(CC) -c -o $@ $(patsubst obj%,graph_viewer%,$(patsubst %.o,%.cpp,$@)) $(CFLAGS)

#PROJECT RULE
$(PROJ_OBJS): ./src/*.cpp $(PROJ_DEPS)
	@mkdir -p obj
	@$(CC) -c -o $@ $(patsubst obj%,src%,$(patsubst %.o,%.cpp,$@)) $(CFLAGS)

proj: $(OBJS)
	@ g++ -o $@ $^ $(CFLAGS)

.PHONY: clean

clean:
	@rm -fr $(ODIR) proj
