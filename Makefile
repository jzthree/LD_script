# Dependencies: tabix v1.2.1, plink v1.90b3.39
SUBDIRS = 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X Y
POPULATIONS = AFR AMR EAS EUR SAS

setup: 
	for i in $(SUBDIRS); \
	do \
	echo ========= preparing $$i ; \
	(mkdir -p $$i ; cp -v ./Makefile.in $$i/Makefile ; ) ; \
	done; \

setuppanel: panel.SAS
	wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/integrated_call_samples_v3.20130502.ALL.panel
	for i in $(POPULATIONS); \
	do \
		fgrep $$i integrated_call_samples_v3.20130502.ALL.panel | cut -f1 > panel.$$i; \
	done
tabix:
	for i in $(POPULATIONS); \
	do \
		cat */plinkoutput.$$i.ld |sed 's/\ \+/\t/g'|sed 's/^\t//g'|fgrep -v CHR_A |bgzip -c > $$i.ld.gz ; tabix -b 2 -e 2 $$i.ld.gz; \
	done

$(SUBDIRS)::
	$(MAKE) -C $@ $(MAKECMDGOALS)

all clean download format plink realclean: $(SUBDIRS)

