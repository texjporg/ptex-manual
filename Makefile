DOCTARGET = ptex-manual eptexdoc jfm \
	ptex-guide-en
# following documents are not maintained anymore;
# even some descriptions might be different from
# current status of pTeX
#   jtex_asciimw jtexdoc_asciimw
#   ptexdoc_asciimw ptexskip_asciimw
#   eptex_resume
PDFTARGET = $(addsuffix .pdf,$(DOCTARGET))
DVITARGET = $(addsuffix .dvi,$(DOCTARGET))
KANJI = -kanji=utf8
#FONTMAP = -f ipaex.map -f ptex-ipaex.map
FONTMAP = -f ptex-haranoaji.map -f otf-haranoaji.map
TEXMF = $(shell kpsewhich -var-value=TEXMFHOME)
ifdef PLATEX
	PLATEX=${foo}
else
	PLATEX=platex
endif

default: $(DVITARGET)
all: $(PDFTARGET)

ptex-manual.dvi: ptex-manual.tex
	$(PLATEX) $(KANJI) ptex-manual.tex
	$(PLATEX) $(KANJI) ptex-manual.tex
#	makeindex -s gind.ist -o ptex-manual.ind ptex-manual.idx
	mendex -U -s gind.ist -o ptex-manual.ind ptex-manual.idx
	$(PLATEX) $(KANJI) ptex-manual.tex
	rm -f *.aux *.log *.toc *.idx *.ind *.ilg *.out

ptex-guide-en.dvi: ptex-guide-en.tex
	$(PLATEX) $(KANJI) ptex-guide-en.tex
	$(PLATEX) $(KANJI) ptex-guide-en.tex
#	makeindex -s gind.ist -o ptex-guide-en.ind ptex-guide-en.idx
	mendex -U -s gind.ist -o ptex-guide-en.ind ptex-guide-en.idx
	$(PLATEX) $(KANJI) ptex-guide-en.tex
	rm -f *.aux *.log *.toc *.idx *.ind *.ilg *.out

eptexdoc.dvi: eptexdoc.tex fam256p.tex fam256d.tex
	$(PLATEX) $(KANJI) eptexdoc.tex
	$(PLATEX) $(KANJI) eptexdoc.tex
	mendex -U -s gind.ist eptexdoc.idx
	$(PLATEX) $(KANJI) eptexdoc.tex
	rm -f *.aux *.log *.toc *.idx *.ind *.ilg *.out

.SUFFIXES: .tex .dvi .pdf
.tex.dvi:
	$(PLATEX) $(KANJI) $<
	$(PLATEX) $(KANJI) $<
	$(PLATEX) $(KANJI) $<
	rm -f *.aux *.log *.toc
.dvi.pdf:
	dvipdfmx $(FONTMAP) $<

.PHONY: install clean
install:
	mkdir -p ${TEXMF}/doc/ptex/ptex-manual
	cp ./LICENSE ${TEXMF}/doc/ptex/ptex-manual/
	cp ./README* ${TEXMF}/doc/ptex/ptex-manual/
	cp ./*.tex ${TEXMF}/doc/ptex/ptex-manual/
	cp ./*.pdf ${TEXMF}/doc/ptex/ptex-manual/
clean:
	rm -f $(DVITARGET) $(PDFTARGET)
