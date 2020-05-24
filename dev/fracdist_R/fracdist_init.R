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


