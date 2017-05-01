FONTMAP = -f ipaex.map -f ptex-ipaex.map
ptex-manual.pdf: ptex-manual.tex
	platex ptex-manual.tex
	makeindex -s gind.ist -o ptex-manual.ind ptex-manual.idx
	platex ptex-manual.tex
	dvipdfmx $(FONTMAP) ptex-manual
