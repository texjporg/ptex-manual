KANJI = -kanji=utf8
FONTMAP = -f ipaex.map -f ptex-ipaex.map

ptex-manual.pdf: ptex-manual.tex
	platex $(KANJI) ptex-manual.tex
#	makeindex -s gind.ist -o ptex-manual.ind ptex-manual.idx
	mendex -U -s gind.ist -o ptex-manual.ind ptex-manual.idx
	platex $(KANJI) ptex-manual.tex
	dvipdfmx $(FONTMAP) ptex-manual

.PHONY: clean
clean:
	rm -f *.pdf
