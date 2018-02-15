LAB_SOLUTIONS_MD=$(sort $(wildcard lab*/lab-solutions.md))
LAB_SOLUTIONS_PDF=$(patsubst lab%/lab-solutions.md,lab%/lab-solutions.pdf,$(LAB_SOLUTIONS_MD))

oblig1.pdf: $(LAB_SOLUTIONS_PDF)
	pdfunite $(LAB_SOLUTIONS_PDF) oblig1.pdf

lab%/lab-solutions.pdf: lab%/lab-solutions.md
	cd $(dir $<); pandoc $(notdir $<) -o $(notdir $@) --from markdown --template eisvogel --listings
