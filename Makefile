LATEX ?= pdflatex
TEX ?= tex

sources = ${wildcard *.dtx}

packages = ${basename ${sources}}

targets := \
	${addsuffix .sty,${packages}} \
	${addsuffix .ins,${packages}} \
	${addsuffix .pdf,${packages}}

generated := \
	${addsuffix .drv,${packages}} \
	${targets}

.PHONY = all clean distclean

all: ${targets}

clean:
	rm -f *.{dvi,aux,fls,glo,fdb*,idx,ilg,ind,log}

distclean: clean
	rm -f ${generated}

%.drv %.ins %.sty: %.dtx
	$(TEX) $<

%.pdf: %.drv
	$(LATEX) $<
