#==============================================================================
#
#  Quattro Creation Kit
#  Copyright © 2016 Ian Karlsson
#
#==============================================================================

# source include directory
INCDIR=./include
# binary include directory
INCBIN=./incbin
# sample include directory
WAVDIR=./samples

# assembler, linker
AS=./tools/ca65
LD=./tools/ld65

# tools
ROMTOOL=./tools/romtool

# options to pass to the linker
LDOPTIONS= -m qck.map
# linker configuration file
CFGFILE=quattro.cfg
# output file
PRGROM=qck.prg.bin
WAVEROM=qck.wav.bin

# source file directory
SRC=./src

# object file directory
OBJ=./obj

OBJS = \
	$(OBJ)/_header.o \
	$(OBJ)/_song.o \
	$(OBJ)/_wave.o \
	$(OBJ)/_volenv.o \
	$(OBJ)/_pitenv.o \
	$(OBJ)/_panenv.o \
	$(OBJ)/_lfo.o \
	$(OBJ)/_preset.o \
	$(OBJ)/init.o \
	$(OBJ)/test.o \
	$(OBJ)/abc_st1.o \
	$(OBJ)/tze.o \
	$(OBJ)/tf4.o \
	$(OBJ)/sunkig2.o \
	$(OBJ)/sunkig2b.o \
	$(OBJ)/motost.o \
	$(OBJ)/challenge.o \
	$(OBJ)/quartet.o \
	$(OBJ)/trademark.o \
	$(OBJ)/dynalloc/dynalloc.o \
	$(OBJ)/dynalloc/shar.o \
	$(OBJ)/dynalloc/chtr.o
	
build:	$(OBJS)
	@echo linking...
	@$(LD) -C $(CFGFILE) $(LDOPTIONS) $(OBJS) -o $(PRGROM)

$(OBJ)/%.o:	$(SRC)/%.s
	@echo assembling $< ...
	@mkdir -p $(@D)
	@$(AS) -I $(INCDIR) --bin-include-dir $(INCBIN) -o $@ -l ./lst/$(<F).lst $<

$(OBJ)/%.o: $(OBJ)/%.s
	@echo assembling $< ...
	@mkdir -p $(@D)
	@$(AS) -I $(INCDIR) --bin-include-dir $(INCBIN) -o $@ -l ./lst/$(<F).lst $<

$(OBJ)/%.s: $(SRC)/%.ini
	@echo generating $< ...
	@mkdir -p $(@D)
	$(ROMTOOL) -d $(WAVDIR) -s $@ -r $(WAVEROM) $<
	
$(WAVEROM): $(OBJ)/_wave.o
	
clean:
	rm -f $(OBJ)/*.o $(OBJ)/*.s

cb: clean build

.PHONY: build clean cb
