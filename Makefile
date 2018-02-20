# WHAT:
#   Builds oblig1.pdf from the lab-solution markdown files
# DEPENDENCIES: (let me know if any are missing)
# * make (duh)
# * pandoc
#   * einsvogel template: https://github.com/Wandmalfarbe/pandoc-latex-template
# * pdfunite

# list of labs oblig constist of
O1_LABS=0119 0126 0202
O2_LABS=0209 0216

# sort them
O1_LABS_SORTED=$(sort $(O1_LABS))
O2_LABS_SORTED=$(sort $(O2_LABS))

# construct path to each lab
O1_LAB_SOLUTIONS_MD=$(sort $(patsubst %,lab%/lab-solutions.md,$(O1_LABS_SORTED)))
O2_LAB_SOLUTIONS_MD=$(sort $(patsubst %,lab%/lab-solutions.md,$(O2_LABS_SORTED)))

# construct path to each desired pdf
O1_LAB_SOLUTIONS_PDF=$(sort $(patsubst %,lab%/lab-solutions.pdf,$(O1_LABS_SORTED)))
O2_LAB_SOLUTIONS_PDF=$(sort $(patsubst %,lab%/lab-solutions.pdf,$(O2_LABS_SORTED)))

#-------------------------------- TARGETS --------------------------------------

all: oblig1.pdf oblig2.pdf

# To build oblig1.pdf: First compile all the pdf's, then merge them together
oblig1.pdf: $(O1_LAB_SOLUTIONS_PDF)
	pdfunite $(O1_LAB_SOLUTIONS_PDF) oblig1.pdf

# To build oblig2.pdf: First compile all the pdf's, then merge them together
oblig2.pdf: $(O2_LAB_SOLUTIONS_PDF)
	pdfunite $(O2_LAB_SOLUTIONS_PDF) oblig2.pdf

# To build each sub-pdf: Throw some pandoc at it 
lab%/lab-solutions.pdf: lab%/lab-solutions.md
	cd $(dir $<); pandoc $(notdir $<) -o $(notdir $@) --from markdown --template eisvogel --listings
