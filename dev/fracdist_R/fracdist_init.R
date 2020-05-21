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
# This sets up the folder and files for supporting the fracdist package.
data_dir <- '~/Research/FCVAR/fracdist_Fortran/mn-files'

frmapp01 <- get_fracdist_tab(iq = 1, iscon = 0,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frmapp01, frmapp01)
# Warning: Saving duplicates only once: 'frmapp01'
# check Creating 'data/'
# check Saving 'frmapp01' to 'data/frmapp01.rda'
# Repeat for all tables.
frmapp02 <- get_fracdist_tab(iq = 2, iscon = 0,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frmapp02, frmapp02)
frmapp03 <- get_fracdist_tab(iq = 3, iscon = 0,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frmapp03, frmapp03)
frmapp04 <- get_fracdist_tab(iq = 4, iscon = 0,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frmapp04, frmapp04)
frmapp05 <- get_fracdist_tab(iq = 5, iscon = 0,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frmapp05, frmapp05)
frmapp06 <- get_fracdist_tab(iq = 6, iscon = 0,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frmapp06, frmapp06)
frmapp07 <- get_fracdist_tab(iq = 7, iscon = 0,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frmapp07, frmapp07)
frmapp08 <- get_fracdist_tab(iq = 8, iscon = 0,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frmapp08, frmapp08)
frmapp09 <- get_fracdist_tab(iq = 9, iscon = 0,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frmapp09, frmapp09)
frmapp10 <- get_fracdist_tab(iq = 10, iscon = 0,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frmapp10, frmapp10)
frmapp11 <- get_fracdist_tab(iq = 11, iscon = 0,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frmapp11, frmapp11)
frmapp12 <- get_fracdist_tab(iq = 12, iscon = 0,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frmapp12, frmapp12)


# Repeat for models with constant.
frcapp01 <- get_fracdist_tab(iq = 1, iscon = 1,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frcapp01, frcapp01)
frcapp02 <- get_fracdist_tab(iq = 2, iscon = 1,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frcapp02, frcapp02)
frcapp03 <- get_fracdist_tab(iq = 3, iscon = 1,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frcapp03, frcapp03)
frcapp04 <- get_fracdist_tab(iq = 4, iscon = 1,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frcapp04, frcapp04)
frcapp05 <- get_fracdist_tab(iq = 5, iscon = 1,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frcapp05, frcapp05)
frcapp06 <- get_fracdist_tab(iq = 6, iscon = 1,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frcapp06, frcapp06)
frcapp07 <- get_fracdist_tab(iq = 7, iscon = 1,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frcapp07, frcapp07)
frcapp08 <- get_fracdist_tab(iq = 8, iscon = 1,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frcapp08, frcapp08)
frcapp09 <- get_fracdist_tab(iq = 9, iscon = 1,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frcapp09, frcapp09)
frcapp10 <- get_fracdist_tab(iq = 10, iscon = 1,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frcapp10, frcapp10)
frcapp11 <- get_fracdist_tab(iq = 11, iscon = 1,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frcapp11, frcapp11)
frcapp12 <- get_fracdist_tab(iq = 12, iscon = 1,
                             dir_name = data_dir, file_ext = 'txt')
usethis::use_data(frcapp12, frcapp12)

# Then run
# usethis::use_data()
# usethis::use_data(my_dataset, my_dataset)
# Warning: Saving duplicates only once: 'votingJNP2014'
# check Creating 'data/'
# check Saving 'votingJNP2014' to 'data/votingJNP2014.rda'

# You should also make sure that the data has been optimally compressed:
# Run
tools::checkRdaFiles('data/frmapp01.rda')
# size ASCII compress version
# data/frmapp01.rda 57512 FALSE    bzip2       2
# to determine the best compression for each file.
# So, the best compression is 'bzip2', which is the default, so we're good.
# The file is already quite small.

# Otherwise:
# Re-run
# usethis::use_data(votingJNP2014, votingJNP2014, compress = 'whatever')
# with compress set to that optimal value.
# If you've lost the code for recreating the files, you can use
# tools::resaveRdaFiles()
# to re-save in place.


# Test datasets.
test_data1 <- get(load(file = 'data/frmapp08.RData'))
summary(test_data1)
summary(frtab)
test_data2 <- get(load(file = 'data/frcapp01.RData'))
summary(test_data2)



# Testing
usethis::use_testthat()
# check Adding 'testthat' to Suggests field in DESCRIPTION
# check Creating 'tests/testthat/'
# check Writing 'tests/testthat.R'
# dot Call `use_test()` to initialize a basic test file and open it for editing.




