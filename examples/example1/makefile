# Example from http://slo.sourceforge.net/dochtml/ch04s03.html

CC=$(HOME)/gcc-slo/bin/gcc-slo
CCC=$(HOME)/gcc-slo/bin/g++-slo
INSTR_FLAG= -O3 -fno-inline -fslo-instrument
INSTR_LINK_OPTIONS= -static -lrd

all: example1 example1.slo.zip
clean:
	rm *.slo_instr_o *.o example1 example1_slo_instr *_info BRD example1.slo.zip

%.o: %.c
	$(CC) -O2 -c -o $@ $<

%.slo_instr_o: %.c
	$(CC) $(INSTR_FLAG) -c -o $@ $<

example1: example1.o make_vec.o
	$(CC) -o $@ example1.o make_vec.o -lm

example1_slo_instr: example1.slo_instr_o make_vec.o
	$(CCC) -o $@ example1.slo_instr_o make_vec.o $(INSTR_LINK_OPTIONS) -lm

BRD: example1_slo_instr
	./example1_slo_instr 1000

example1.slo.zip: BRD
	zip $@ BRD example1.c example1.c.bb_info example1.c.function_info \
		example1.c.memaccess_info
