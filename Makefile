KANJI = -kanji=utf8
PFONTMAP = -f ipaex.map -f ptex-ipaex.map
UPFONTMAP = -f ipaex.map -f uptex-ipaex.map

.PHONY: all
all: ptex-manual.pdf uptex-manual.pdf

ptex-manual.pdf: ptex-manual.tex
	platex $(KANJI) ptex-manual.tex
#	makeindex -s gind.ist -o ptex-manual.ind ptex-manual.idx
	mendex -U -s gind.ist -o ptex-manual.ind ptex-manual.idx
	platex $(KANJI) ptex-manual.tex
	dvipdfmx $(PFONTMAP) ptex-manual
uptex-manual.pdf: uptex-manual.tex
	uplatex $(KANJI) uptex-manual.tex
#	makeindex -s gind.ist -o ptex-manual.ind ptex-manual.idx
#	mendex -U -s gind.ist -o ptex-manual.ind ptex-manual.idx
	upmendex -s gind.ist -o uptex-manual.ind uptex-manual.idx
	uplatex $(KANJI) uptex-manual.tex
	dvipdfmx $(UPFONTMAP) uptex-manual
