
#!
#! Modification history:
#!     Michael L. Rilee, November 2002, *dbz*
#!        Initial support for divergenceless prolongation
#!     Michael L. Rilee, December 2002, *clean_divb*
#!        Support for projecting field onto divergenceless field
#!

.SUFFIXES :  
.SUFFIXES : .o .c .f .F .F90 .f90 .fh .a

sources := \
  amr_1blk_cc_cp_remote.F90  \
  amr_1blk_cc_prol_gen_unk_fun.F90  \
  amr_1blk_cc_prol_inject.F90  \
  amr_1blk_cc_prol_linear.F90  \
  amr_1blk_cc_prol_genorder.F90 \
  amr_1blk_cc_prol_user.F90 \
  amr_1blk_cc_prol_gen_work_fun.F90 \
  amr_1blk_cc_prol_work_inject.F90 \
  amr_1blk_cc_prol_work_linear.F90 \
  amr_1blk_cc_prol_work_genorder.F90 \
  amr_1blk_cc_prol_work_user.F90 \
  amr_1blk_copy_soln.F90    \
  amr_1blk_ec_cp_remote.F90 \
  amr_1blk_ec_prol_gen_fun.F90 \
  amr_1blk_ec_prol_genorder.F90 \
  amr_1blk_ec_prol_user.F90 \
  amr_1blk_ec_prol_linear.F90 \
  amr_1blk_fc_prol_dbz.F90 \
  clean_field.F90 \
  poisson_sor.F90 \
  amr_1blk_fc_clean_divb.F90 \
  amr_1blk_fc_cp_remote.F90 \
  amr_1blk_fc_prol_gen_fun.F90 \
  amr_1blk_fc_prol_inject.F90 \
  amr_1blk_fc_prol_linear.F90 \
  amr_1blk_fc_prol_genorder.F90 \
  amr_1blk_fc_prol_user.F90 \
  amr_1blk_guardcell_reset.F90 \
  amr_1blk_guardcell_srl.F90 \
  set_f2c_indexes.F90 \
  amr_1blk_nc_cp_remote.F90 \
  amr_1blk_nc_prol_gen_fun.F90 \
  amr_1blk_nc_prol_genorder.F90 \
  amr_1blk_nc_prol_user.F90 \
  amr_1blk_nc_prol_linear.F90 \
  amr_1blk_save_soln.F90 \
  amr_1blk_t_to_perm.F90 \
  amr_1blk_to_perm.F90 \
  amr_bcset_init.F90 \
  amr_block_geometry.F90 \
  user_coord_transfm.F90 \
  amr_close.F90 \
  amr_initialize.F90 \
  amr_set_runtime_parameters.F90 \
  amr_mpi_find_blk_in_buffer.F90 \
  amr_perm_to_1blk.F90 \
  amr_prolong_cc_fun_init.F90 \
  amr_prolong_face_fun_init.F90 \
  amr_prolong_fun_init.F90 \
  amr_reorder_grid.F90 \
  amr_restrict_ec_fun.F90 \
  amr_restrict_ec_genorder.F90 \
  amr_restrict_ec_user.F90 \
  amr_restrict_edge.F90 \
  amr_restrict_fc_fun.F90 \
  amr_restrict_fc_genorder.F90 \
  amr_restrict_fc_user.F90 \
  amr_restrict_red.F90 \
  amr_restrict_unk_fun.F90 \
  amr_restrict_unk_genorder.F90 \
  amr_restrict_unk_user.F90 \
  amr_restrict_nc_fun.F90 \
  amr_restrict_nc_user.F90 \
  amr_restrict_nc_genorder.F90 \
  amr_restrict_work_fun.F90 \
  amr_restrict_work_genorder.F90 \
  amr_restrict_work_user.F90 \
  amr_restrict_work_fun_recip.F90 \
  amr_system_calls.F90 \
  amr_q_sort.F90 \
  amr_q_sort_real.F90
 
%.o:%.F90
	$(FC) -c $(FFLAGS) $<

objects := \
	$(patsubst %.F90,%.o, \
	$(patsubst %.f90,%.o, \
	$(patsubst %.c,%.o, \
	$(patsubst %.F,%.o,$(sources)))))

vpath %.fh ../headers

libparamesh.a: $(objects)
	$(AR) $(ARFLAGS) $@ $^
	cp -f libparamesh.a ../libs/.

ifdef MY_CPP
GNUmakefile.include: $(sources)
	find . -name \*[.f90,.F90,.c,.F] | xargs $(MY_CPP) > $@
include GNUmakefile.include
else
$(objects): $(wildcard *.fh)
endif

.PHONY: clean
clean:
	$(RM) libparamesh.a *.o *~ GNUmakefile.include

#--------------------------------------------------------------------------

.SUFFIXES : .F90 .f90 .c .o

.F.o:
	$(FC) $(FFLAGS) -c -o $*.o $*.F

.f90.o:
	$(FC) $(FFLAGS) -c -o $*.o $*.f90

.F90.o:
	$(FC) $(FFLAGS) -c -o $*.o $*.F90

.c.o:
	$(CC) $(CFLAGS) -c -o $*.o $*.c

# .fh:;
# .mod:;

#--------------------------------------------------------------------------
