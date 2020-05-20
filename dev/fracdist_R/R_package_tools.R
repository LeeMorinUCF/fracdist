################################################################################
# 
# Creating the fracdist Package
# 
# 
# Lee Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
# 
# May 19, 2020
# 
################################################################################
# 
# This program collects the tools needed to construct
#   an R package for the rank tests used in the FCVAR model.
#   It uses the packages in Hadley Wickham's book "R Packages"
# 
################################################################################


################################################################################
# Clearing Workspace and Declaring Packages
################################################################################

# Clear workspace.
rm(list = ls(all = TRUE))

# Set working directory.
wd_path <- '~/Research/FCVAR/GitRepo/fracdist/R'
setwd(wd_path)

# Load package for development tools.
# install.packages('devtools')
library(devtools)

# Load package for generating R documentation.
# install.packages('roxygen2')
library(roxygen2)

# Load package for testing functions.
# install.packages('testthat')
library(testthat)


# Load package for generating R documentation
# with snippets of R code.
# install.packages('knitr')
library(knitr)


# Check that R version is sufficient.
library(rstudioapi)
rstudioapi::isAvailable("0.99.149")
# [1] TRUE


# Check that everything is installed:
has_devel()
# Need grown-up permission to install. 

# In case it didn't work:
# Diagnosing the problem.
# pkgbuild::check_build_tools(debug = TRUE)
# Have you ever seen the movie 'Inception'?



devtools::session_info()




################################################################################
# End
################################################################################

