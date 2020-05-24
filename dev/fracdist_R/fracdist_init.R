##################################################
#
# fracdist Initialization Scratchpad
#
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
#
# May 19, 2020
#
##################################################
#
# A set of commands to initialize the fradist package
#
# Dependencies:
#   None.
#
##################################################


##################################################
# Preparing the Workspace
##################################################

# Clear workspace.
rm(list=ls(all=TRUE))




# Check that the package development tools are installed correctly
library(devtools)
# Loading required package: usethis
# Warning messages:
#   1: package 'devtools' was built under R version 3.5.3
#   2: package 'usethis' was built under R version 3.5.3
has_devel()
# Your system is ready to build packages!



##################################################
# Package initialization.
##################################################

fracdist_dir <- '~/Research/FCVAR/GitRepo/fracdist'
fracdist_dir <- 'C:/Users/le279259/Documents/Research/FCVAR/GitRepo/fracdist'
setwd(fracdist_dir)


# Deprecated:
#
# # Since folder already exists, use setup() instead of create().
# devtools::setup(path = fracdist_dir)
# # Error: 'setup' is not an exported object from 'namespace:devtools'
# setup(path = fracdist_dir)
#
# # devtools is no longer current. It was split into several pieces.
# # There is a separate package for package setup.
# library(usethis)
# usethis::setup(path = fracdist_dir)
# # Does not exist. See below with create_package().

# Check that the name is available.
# install.packages('available')
library(available)
available('fracdist')
# Urban Dictionary can contain potentially offensive results,
# should they be included? [Y]es / [N]o:
#   1: y
# -- fracdist --------------------------------------------------------------------
#   Name valid: check
# Available on CRAN: check
# Available on Bioconductor: check
# Available on GitHub:  check
# Abbreviations: http://www.abbreviations.com/fracdist
# Wikipedia: https://en.wikipedia.org/wiki/fracdist
# Wiktionary: https://en.wiktionary.org/wiki/fracdist
# Urban Dictionary:
#   Not found.
# Sentiment:???
#   Warning message:
#   package 'tidytext' was built under R version 3.5.3

# This means we are G2G.

# Ok now create the package.

create_package(path = fracdist_dir)

# New project 'FCVAR' is nested inside an existing project 'C:/Users/le279259/Documents/Research/FCVAR/GitRepo/', which is rarely a good idea.
# Do you want to create anyway?
#
#   1: Absolutely not
# 2: No
# 3: Yes
#
# Selection: Y
# Enter an item from the menu, or 0 to exit
# Selection: Yes
# check Setting active project to 'C:/Users/le279259/Documents/Research/FCVAR/GitRepo/FCVAR'
# check Creating 'R/'
# check Writing 'DESCRIPTION'
# Package: FCVAR
# Title: What the Package Does (One Line, Title Case)
# Version: 0.0.0.9000
# Authors@R (parsed):
#   * First Last <first.last@example.com> [aut, cre] (<https://orcid.org/YOUR-ORCID-ID>)
# Description: What the package does (one paragraph).
# License: What license it uses
# Encoding: UTF-8
# LazyData: true
# check Writing 'NAMESPACE'
# check Writing 'FCVAR.Rproj'
# check Adding '.Rproj.user' to '.gitignore'
# check Adding '^FCVAR\\.Rproj$', '^\\.Rproj\\.user$' to '.Rbuildignore'
# check Opening 'C:/Users/le279259/Documents/Research/FCVAR/GitRepo/FCVAR/' in new RStudio session
# check Setting active project to '<no active project>'



##################################################
# Create documantation

##################################################

# Next steps:
# Edit field in the description
# Create a function in the R folder.
# Add roxygen comments before the function.

# Use roxygen to build documentation.
devtools::document()
# Rinse and repeat.


# Set some folders to be ignored by R build.
usethis::use_build_ignore(c("dev"))
# check Setting active project to 'C:/Users/le279259/Documents/Research/FCVAR/GitRepo/FCVAR'
# check Adding '^stata$', '^R_dev$', '^MATLAB$' to '.Rbuildignore'



# Generate a pdf manual once the documentation is complete.
devtools::build_manual()
# Hmm ... looks like a package
# Creating pdf output from LaTeX ...
# Saving output to 'C:/Users/le279259/Documents/Research/FCVAR/GitRepo/FCVAR_0.0.0.9000.pdf' ...
# Done


# Generate a sketch of a vignette.
usethis::use_vignette("fracdist")
# check Setting active project to 'C:/Users/le279259/Documents/Research/FCVAR/GitRepo/FCVAR'
# check Adding 'rmarkdown' to Suggests field in DESCRIPTION
# check Writing 'vignettes/FCVAR.Rmd'
# dot Modify 'vignettes/FCVAR.Rmd'

# Generate a sketch of an article.
usethis::use_article("fracdist")
# Overwrite pre-existing file 'vignettes/FCVAR.Rmd'?
#
#   1: Yeah
# 2: Negative
# 3: Not now
#
# Selection: 1
# check Writing 'vignettes/FCVAR.Rmd'
# dot Modify 'vignettes/FCVAR.Rmd'
# check Adding '^vignettes/FCVAR\\.Rmd$' to '.Rbuildignore'

# Underwhelming. Only creates a folder.

# Try to build:
devtools::build_vignettes()
# NULL
# No actions that I can detect with git status.



# Iterations on R package.
# load_all() is the key step in this "lather, rinse, repeat"
# cycle of package development:
#
# 1.  Tweak a function definition.
# 2.
load_all()
# 3. Try out the change by running a small example or some tests.



# Data for lookup tables.
# See fracdist_tables.R in the data-raw folder.

# This sets up the folder and files for supporting the fracdist package.
# data_dir <- '~/Research/FCVAR/fracdist_Fortran/mn-files'

# Example:
# frmapp01 <- get_fracdist_tab(iq = 1, iscon = 0,
#                              dir_name = data_dir, file_ext = 'txt')
# usethis::use_data(frmapp01, frmapp01)
# Warning: Saving duplicates only once: 'frmapp01'
# check Creating 'data/'
# check Saving 'frmapp01' to 'data/frmapp01.rda'
# Repeat for all tables.
# See fracdist_tables.R in the dev folder for the rest.






# Testing
usethis::use_testthat()
# check Adding 'testthat' to Suggests field in DESCRIPTION
# check Creating 'tests/testthat/'
# check Writing 'tests/testthat.R'
# dot Call `use_test()` to initialize a basic test file and open it for editing.


# Ignoring files not included in R packages.
# usethis::use_build_ignore('.gitignore')
# check Adding '^\\.gitignore$' to '.Rbuildignore'
#
# usethis::use_build_ignore('README.md')
# check Adding '^README\\.md$' to '.Rbuildignore'



# Final step:
# devtools::check()
# Updating fracdist documentation
# Writing NAMESPACE
# Loading fracdist
# Writing NAMESPACE
# -- Building -------------------------------------------------------- fracdist --
#   Setting env vars:
#   * CFLAGS    : -Wall -pedantic
# * CXXFLAGS  : -Wall -pedantic
# * CXX11FLAGS: -Wall -pedantic
# --------------------------------------------------------------------------------
#   check  checking for file 'C:\Users\le279259\Documents\Research\FCVAR\GitRepo\fracdist/DESCRIPTION' ...
# -  preparing 'fracdist': (2s)
# check  checking DESCRIPTION meta-information ...
# -  checking for LF line-endings in source and make files and shell scripts (490ms)
# -  checking for empty or unneeded directories
# -  looking to see if a 'data/datalist' file should be added
# -  building 'fracdist_0.0.0.9000.tar.gz'
#
# -- Checking -------------------------------------------------------- fracdist --
#   Setting env vars:
#   * _R_CHECK_CRAN_INCOMING_USE_ASPELL_: TRUE
# * _R_CHECK_CRAN_INCOMING_REMOTE_    : FALSE
# * _R_CHECK_CRAN_INCOMING_           : FALSE
# * _R_CHECK_FORCE_SUGGESTS_          : FALSE
# * NOT_CRAN                          : true
# -- R CMD check ------------------------------------------------------
#   -  using log directory 'C:/Users/le279259/AppData/Local/Temp/1/RtmpyQpz1L/fracdist.Rcheck'
# -  using R version 3.5.1 (2018-07-02)
# -  using platform: x86_64-w64-mingw32 (64-bit)
# -  using session charset: ISO8859-1
# -  using options '--no-manual --as-cran'
# check  checking for file 'fracdist/DESCRIPTION'
# -  this is package 'fracdist' version '0.0.0.9000'
# -  package encoding: UTF-8
# check  checking package namespace information
# check  checking package dependencies (886ms)
# check  checking if this is a source package ...
# check  checking if there is a namespace
# check  checking for executable files (408ms)
# check  checking for hidden files and directories ...
# check  checking for portable file names ...
# check  checking serialization versions ...
# check  checking whether package 'fracdist' can be installed (2.9s)
# check  checking installed package size ...
# check  checking package directory
# check  checking DESCRIPTION meta-information (338ms)
# check  checking top-level files
# check  checking for left-over files ...
# check  checking index information
# check  checking package subdirectories ...
# check  checking R files for non-ASCII characters ...
# check  checking R files for syntax errors ...
# check  checking whether the package can be loaded ...
# check  checking whether the package can be loaded with stated dependencies ...
# check  checking whether the package can be unloaded cleanly ...
# check  checking whether the namespace can be loaded with stated dependencies ...
# check  checking whether the namespace can be unloaded cleanly ...
# check  checking dependencies in R code ...
# check  checking S3 generic/method consistency (515ms)
# check  checking replacement functions ...
# check  checking foreign function calls ...
# N  checking R code for possible problems (3.4s)
# blocal: no visible global function definition for 'lm'
# fpcrit: no visible global function definition for 'qchisq'
# fpcrit: no visible global function definition for 'lm'
# fpval: no visible global function definition for 'lm'
# fpval: no visible global function definition for 'pchisq'
# fracdist_values: no visible global function definition for 'pchisq'
# fracdist_values: no visible global function definition for 'qchisq'
# Undefined global functions or variables:
#   lm pchisq qchisq
# Consider adding
# importFrom("stats", "lm", "pchisq", "qchisq")
# to your NAMESPACE file.
# check  checking Rd files ...
# check  checking Rd metadata ...
# check  checking Rd line widths ...
# check  checking Rd cross-references ...
# check  checking for missing documentation entries ...
# check  checking for code/documentation mismatches (731ms)
# check  checking Rd \usage sections (721ms)
# check  checking Rd contents ...
# check  checking for unstated dependencies in examples ...
# check  checking R/sysdata.rda ...
# check  checking examples (2.4s)
# check  checking for unstated dependencies in 'tests' ...
# -  checking tests ...
# check  Running 'testthat.R' (2.8s)
#
# See
# 'C:/Users/le279259/AppData/Local/Temp/1/RtmpyQpz1L/fracdist.Rcheck/00check.log'
# for details.
#
#
# -- R CMD check results --------------------- fracdist 0.0.0.9000 ----
#   Duration: 20.2s
#
# > checking R code for possible problems ... NOTE
# blocal: no visible global function definition for 'lm'
# fpcrit: no visible global function definition for 'qchisq'
# fpcrit: no visible global function definition for 'lm'
# fpval: no visible global function definition for 'lm'
# fpval: no visible global function definition for 'pchisq'
# fracdist_values: no visible global function definition for 'pchisq'
# fracdist_values: no visible global function definition for 'qchisq'
# Undefined global functions or variables:
#   lm pchisq qchisq
# Consider adding
# importFrom("stats", "lm", "pchisq", "qchisq")
# to your NAMESPACE file.
#
# 0 errors check | 0 warnings check | 1 note x
# >


# To remove notes, add dependencies on function calls.

# After these adjustments, we're clear:

# -- R CMD check results --------------------- fracdist 0.0.0.9000 ----
#   Duration: 20.4s
#
# 0 errors check | 0 warnings check | 0 notes check

# Ready to submit to CRAN!

# O.K. One more thing:
# How to add author to description?

# Snippet from DESCRIPTION file:
# Authors@R: person(given = "Lealand",
#                   family = "Morin",
#                   role = c("aut", "cre"),
#                   email = "lealand.morin@ucf.edu",
#                   comment = c(ORCID = "0000-0001-8539-1386"))


# Anyway, Hadley says the check is a time to celebrate:

# devtools::install()
# check  checking for file 'C:\Users\le279259\Documents\Research\FCVAR\GitRepo\fracdist/DESCRIPTION' ...
# -  preparing 'fracdist': (2.1s)
# check  checking DESCRIPTION meta-information ...
# -  checking for LF line-endings in source and make files and shell scripts (501ms)
# -  checking for empty or unneeded directories
# -  looking to see if a 'data/datalist' file should be added
# -  building 'fracdist_0.0.0.9000.tar.gz'
#
# Running "C:/Users/le279259/DOCUME~1/R/R-35~1.1/bin/x64/Rcmd.exe" \
# INSTALL \
# "C:\Users\le279259\AppData\Local\Temp\1\RtmpyQpz1L/fracdist_0.0.0.9000.tar.gz" \
# --install-tests
# * installing to library 'C:/Users/le279259/Documents/R/R-3.5.1/library'
# * installing *source* package 'fracdist' ...
# ** R
# ** tests
# ** byte-compile and prepare package for lazy loading
# ** help
# *** installing help indices
# 'fracdist'ng help for package     finding HTML links ...
# done
# -aa-fracdist                            html
# -   blocal                                  html
# -   fpcrit                                  html
# -   fpval                                   html
# -   fracdist_pvalues                        html
# -   fracdist_values                         html
# -   get_fracdist_tab                        html
# ** building package indices
# ** testing if installed package can be loaded
# *** arch - i386
# *** arch - x64
# * DONE (fracdist)
# In R CMD INSTALL


# Try this:
desc_add_author(given = "Lealand", family = "Morin",
                email = "lealand.morin@ucf.edu",
                role = "aut",
                comment = c(ORCID = "0000-0001-8539-1386"),
                file = ".", normalize = FALSE)

# With this information:
# Authors@R: person(given = "Lealand",
#                   family = "Morin",
#                   role = c("aut", "cre"),
#                   email = "lealand.morin@ucf.edu",
#                   comment = c(ORCID = "0000-0001-8539-1386"))

# Result:
# Package: fracdist
# Title: Numerical Distribution Functions of Fractional Unit Root
# and Cointegration Tests
# Version: 0.0.0.9000
# Authors@R (parsed):
#   * Lealand Morin <lealand.morin@ucf.edu> [aut, cre] (<https://orcid.org/0000-0001-8539-1386>)
# * Lealand Morin <lealand.morin@ucf.edu> [aut] (<https://orcid.org/0000-0001-8539-1386>)
# Description: Numerical asymptotic distribution functions of
# likelihood ratio tests for fractional unit roots and cointegration
# rank. From these distributions, the included functions calculate
# critial values and p-values for unit root and cointegration tests and
# for rank tests in the Fractionally Cointegrated Vector Autoregression
# (FCVAR) model.
# License: GPL-3
# URL: https://github.com/LeeMorinUCF/fracdist
# BugReports: https://github.com/LeeMorinUCF/fracdist/issues
# Depends:
#   R (>= 2.10)
# Suggests:
#   testthat
# Encoding: UTF-8
# LazyData: true
# RoxygenNote: 7.0.2

# Name doesn't appear.
# Still haven't figured it out.

# Didn't work here:
# system("ls -lh", intern = TRUE)
# system("R CMD build fracdist.tar.gz", intern = TRUE)

# scp to linux

# Build package:
# R CMD build fracdist
# Adjusts files, drops Rignore, modifies DESCRIPTION with AUthor, etc.
# Creates fracdist.tar.gz

# Then "untar" to see contents.
# tar xvzf fracdist
# devtools::build_manual()
# Creates manual.
# Now author is complete on manual.
