sources := \
paramesh_dimensions.F90 \
paramesh_interfaces.F90 \
physicaldata.F90 \
prolong_arrays.F90 \
timings.F90 \
tree.F90 \
workspace.F90 \
io.F90 \
constants.F90 \
paramesh_comm_data.F90

ifndef SHMEM
sources += mpi_morton.F90 paramesh_mpi_interfaces.F90
endif

%.o:%.F90
	$(FC) -c $(FFLAGS) $<

objects := $(sources:.F90=.o)

libmodules.a: $(objects)
	$(AR) $(ARFLAGS) $@ $^
	cp -f libmodules.a ../libs/.

ifdef MY_CPP
GNUmakefile.include: $(sources)
	find . -name \*.F90 | xargs $(MY_CPP) > $@
include GNUmakefile.include
else
$(objects): $(wildcard *.fh)
endif

.PHONY: clean
clean:
	$(RM) libmodules.a *.o *.mod *.d *~ GNUmakefile.include
