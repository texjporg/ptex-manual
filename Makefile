DOCTARGET = ptex-manual uptex-manual eptexdoc jfm
# following documents are not maintained anymore;
# even some descriptions might be different from
# current status of pTeX
#   jtex_asciimw jtexdoc_asciimw
#   ptexdoc_asciimw ptexskip_asciimw
#   eptex_resume
PDFTARGET = $(addsuffix .pdf,$(DOCTARGET))
DVITARGET = $(addsuffix .dvi,$(DOCTARGET))
KANJI = -kanji=utf8
FONTMAP = -f ipaex.map -f ptex-ipaex.map -f uptex-ipaex.map
TEXMF = $(shell kpsewhich -var-value=TEXMFHOME)

default: $(DVITARGET)
all: $(PDFTARGET)

ptex-manual.dvi: ptex-manual.tex
	platex $(KANJI) ptex-manual.tex
	platex $(KANJI) ptex-manual.tex
#	makeindex -s gind.ist -o ptex-manual.ind ptex-manual.idx
	mendex -U -s gind.ist -o ptex-manual.ind ptex-manual.idx
	platex $(KANJI) ptex-manual.tex
	rm -f *.aux *.log *.toc *.idx *.ind *.ilg *.out

uptex-manual.dvi: uptex-manual.tex
	uplatex $(KANJI) uptex-manual.tex
	uplatex $(KANJI) uptex-manual.tex
	upmendex -s gind.ist -o uptex-manual.ind uptex-manual.idx
	uplatex $(KANJI) uptex-manual.tex
	rm -f *.aux *.log *.toc *.idx *.ind *.ilg *.out

eptexdoc.dvi: eptexdoc.tex fam256p.tex fam256d.tex
	platex $(KANJI) eptexdoc.tex
	platex $(KANJI) eptexdoc.tex
	mendex -U -s gind.ist eptexdoc.idx
	platex $(KANJI) eptexdoc.tex
	rm -f *.aux *.log *.toc *.idx *.ind *.ilg *.out

.SUFFIXES: .tex .dvi .pdf
.tex.dvi:
	platex $(KANJI) $<
	platex $(KANJI) $<
	platex $(KANJI) $<
	rm -f *.aux *.log *.toc
.dvi.pdf:
	dvipdfmx $(FONTMAP) $<

.PHONY: install clean
install:
	mkdir -p ${TEXMF}/doc/ptex/ptex-manual
	cp ./LICENSE ${TEXMF}/doc/ptex/ptex-manual/
	cp ./README* ${TEXMF}/doc/ptex/ptex-manual/
	cp ./Makefile ${TEXMF}/doc/ptex/ptex-manual/
	cp ./*.tex ${TEXMF}/doc/ptex/ptex-manual/
	cp ./*.pdf ${TEXMF}/doc/ptex/ptex-manual/
clean:
	rm -f $(DVITARGET) $(PDFTARGET)
