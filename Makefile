# WHAT:
#   Builds oblig1.pdf from the lab-solution markdown files
# DEPENDENCIES: (let me know if any are missing)
# * make (duh)
# * pandoc
#   * einsvogel template: https://github.com/Wandmalfarbe/pandoc-latex-template
# * pdfunite

# Fetch relative path of each of the lab-solutions
LAB_SOLUTIONS_MD=$(sort $(wildcard lab*/lab-solutions.md))

# Convert into list of desired corresponding pdf's
LAB_SOLUTIONS_PDF=$(patsubst lab%/lab-solutions.md,lab%/lab-solutions.pdf,$(LAB_SOLUTIONS_MD))

# To build oblig1.pdf: First compile all the pdf's, then merge them together
oblig1.pdf: $(LAB_SOLUTIONS_PDF)
	pdfunite $(LAB_SOLUTIONS_PDF) oblig1.pdf

# To build each sub-pdf: Throw some pandoc at it 
lab%/lab-solutions.pdf: lab%/lab-solutions.md
	cd $(dir $<); pandoc $(notdir $<) -o $(notdir $@) --from markdown --template eisvogel --listings
