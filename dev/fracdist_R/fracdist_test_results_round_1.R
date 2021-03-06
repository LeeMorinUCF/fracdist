
##################################################
#
# Fractionally Cointegrated VAR Model
# Test Cases for Critical Values and P-values
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
# fracdist_test_results_round_1.R
#   evaluates test cases from tables
#   of fracdist critial values and p-values and
#   compares them against those evaluated in Fortran.
#
# Dependencies:
#   fracdist_lib.R with functions for calculating
#   critial values and p-values.
#
# TODO: Revise for csv file format
#   (Maybe never, after tests pass).
#
##################################################


##################################################
# Preparing the Workspace
##################################################

# Clear workspace.
rm(list=ls(all=TRUE))

# Set working directory.
wd_path <- '~/Research/FCVAR'

# Set data directory.
# data_dir <- '~/Research/FCVAR/fracdist/mn-files'

# Set directory for test cases.
test_dir <- '~/Research/FCVAR/GitRepo/FCVAR/R_dev/Fortran_tests'

# Set fracdist library directory.
# source_dir <- '~/Research/FCVAR/GitRepo/FCVAR/R_dev/Fortran_tests'

setwd(wd_path)


##################################################
# Load Packages
##################################################

# Load library with functions for calculating
#   critial values and p-values.
# Not needed when package is loaded.
# fracdist_lib_file <- sprintf('%s/fracdist_lib1.R', source_dir)
# source(fracdist_lib_file)

# Read in files of test cases evaluated in Fortran.

# P-value test cases.
in_file_name <- 'test_fpval.out'
in_file_name <- sprintf('%s/%s', test_dir, in_file_name)
test_fpval <- read.fwf(in_file_name, widths = c(1, 3, 6, 9, 7), skip = 1)
colnames(test_fpval) <- c('iscon', 'iq', 'bb', 'stat', 'pval')


# Critical value test cases.
in_file_name <- 'test_fcval.out'
in_file_name <- sprintf('%s/%s', test_dir, in_file_name)
test_fcval <- read.fwf(in_file_name, widths = c(1, 3, 6, 5, 9), skip = 1)
colnames(test_fcval) <- c('iscon', 'iq', 'bb', 'clevel', 'cval')

# Inspect test cases.
summary(test_fpval)
head(test_fpval)
tail(test_fpval)

# Inspect test cases.
summary(test_fcval)
head(test_fcval)
tail(test_fcval)


##################################################
# Evaluate test cases
##################################################

#--------------------------------------------------
# P-value test cases.
#--------------------------------------------------

test_fpval[, 'pval_test'] <- NA

# A good deal of troubleshooting took place with version 1.
# fracdist_out_last <- -7
# for (row_num in 1:10) {
# for (row_num in 1:nrow(test_fpval)) {
# for (row_num in 399:nrow(test_fpval)) {
# row_num <- 415 # Test case missing.
# row_num <- 1240 # Test case missing.
# row_num <- 1001 # Test case missing.
# for (row_num in 1:10) {
# for (row_num in 1:nrow(test_fpval)) {
# for (row_num in which(is.na(test_fpval[, 'pval_test']))) {
for (row_num in 1:nrow(test_fpval)) {

  if(row_num %in% seq(0, nrow(test_fpval), by = 100)) {
    print(sprintf('Performing test case %d of %d.', row_num, nrow(test_fpval)))
  }

  try(

    fracdist_out <- fracdist_values(iq = test_fpval[row_num, 'iq'],
                                    iscon = test_fpval[row_num, 'iscon'],
                                    # dir_name = data_dir,
                                    bb = test_fpval[row_num, 'bb'],
                                    stat = test_fpval[row_num, 'stat'])

  )

  # Record result, if successful.
  test_fpval[row_num, 'pval_test'] <- fracdist_out
  # Erase result in case next one not successful.
  fracdist_out <- NA

}

# Inspect output.
summary(test_fpval)
head(test_fpval)
tail(test_fpval)

# Test for errors.
summary(test_fpval[, 'pval'] - test_fpval[, 'pval_test'])
summary(test_fpval[, 'pval'] - round(test_fpval[, 'pval_test'], 4))
max(abs(test_fpval[, 'pval'] - round(test_fpval[, 'pval_test'], 4)),
    na.rm = TRUE)
# Differences are exactly zero, except for the 20 corner cases
# and those are only off on the last decimal.
table(test_fpval[, 'pval'] - round(test_fpval[, 'pval_test'], 4))
# -0.000199999999999978  -9.9999999999989e-05                     0
#                    10                    10                  2380
# Good enough for me.


# # Differences in previous version:
# sum(!(test_fpval[, 'pval'] == round(test_fpval[, 'pval_test'], 4)),
#     na.rm = TRUE)
# all(test_fpval[, 'pval'] == round(test_fpval[, 'pval_test'], 4))
#
# # Which ones are missing?
# which(is.na(test_fpval[, 'pval_test']))
# head(test_fpval[is.na(test_fpval[, 'pval_test']), ], 100)
# tail(test_fpval[is.na(test_fpval[, 'pval_test']), ], 100)
# # They all have p-values near 1.0000.
#
# # Check the errors.
#
# test_fpval[!is.na(test_fpval[, 'pval_test']) &
#   !(test_fpval[, 'pval'] == round(test_fpval[, 'pval_test'], 4)), ]
#
#
#
# # All are rounding errors.
# summary(test_fpval[, 'pval'] - round(test_fpval[, 'pval_test'], 4))
# summary(floor(test_fpval[, 'pval']*10^3)/10^3 -
#           floor(test_fpval[, 'pval_test']*10^3)/10^3)
# summary(round(test_fpval[, 'pval'], 4) -
#           round(test_fpval[, 'pval_test'], 4))
# summary(round(test_fpval[, 'pval'], 3) -
#           round(test_fpval[, 'pval_test'], 3))
# # There are always some rounding errors.


#--------------------------------------------------
# Critical value test cases.
#--------------------------------------------------

test_fcval[, 'cval_test'] <- NA

# There are always some problemmatic cases.
# for (row_num in 1:10) {
# row_num <- which(is.na(test_fcval[, 'cval_test']))[1]
# for (row_num in which(is.na(test_fcval[, 'cval_test']))) {
for (row_num in 1:nrow(test_fcval)) {

  if(row_num %in% seq(0, nrow(test_fcval), by = 100)) {
    print(sprintf('Performing test case %d of %d.', row_num, nrow(test_fcval)))
  }

  fracdist_out <- fracdist_values(iq = test_fcval[row_num, 'iq'],
                                  iscon = test_fcval[row_num, 'iscon'],
                                  # dir_name = data_dir,
                                  bb = test_fcval[row_num, 'bb'],
                                  # stat = NA,
                                  ipc = FALSE,
                                  clevel = test_fcval[row_num, 'clevel'])

  test_fcval[row_num, 'cval_test'] <- fracdist_out

}

# Inspect output.
summary(test_fcval)
head(test_fcval)
tail(test_fcval)

# Test for errors.
summary(test_fcval[, 'cval'] - test_fcval[, 'cval_test'])
summary(test_fcval[, 'cval'] - round(test_fcval[, 'cval_test'], 4))
table(test_fcval[, 'cval'] - round(test_fcval[, 'cval_test'], 4))
# -0.000100000000031741  -0.00010000000000332 -9.99999999748979e-05
#                     6                     4                     9
#                     0   0.00010000000000332
#                   698                     3
# I'd call this correct:
# 698/720 test cases exactly equal.
# The other 22 test cases off by last digit
# that is displayed in the Fortran code.


# # Differences in previous version:
# sum(!(test_fcval[, 'cval'] == round(test_fcval[, 'cval_test'], 4)),
#     na.rm = TRUE)
# all(test_fcval[, 'cval'] == round(test_fcval[, 'cval_test'], 4))
#
# plot(test_fcval[, 'cval'],
#      test_fcval[, 'cval_test'])
# hist(test_fcval[, 'cval_test'] -
#      test_fcval[, 'cval'], breaks = 50, col = 'red')
# # There are really just a few outliers.
#
# quantile(test_fcval[, 'cval_test'] -
#            test_fcval[, 'cval'],
#          probs = c(seq(0, 0.05, by = 0.01),
#                    seq(0.95, 1, by = 0.01)))
#
# # summary(floor(test_fcval[, 'cval']*10^2)/10^2 -
# #           round(test_fcval[, 'cval_test'], 2))
# # summary(floor(test_fcval[, 'cval']*10)/10 -
# #           floor(test_fcval[, 'cval_test']*10)/10)
#
#
# summary(test_fcval[, 'cval'] - round(test_fcval[, 'cval_test'], 4))
# summary(test_fcval[, 'cval'] - round(test_fcval[, 'cval_test'], 3))
# summary(test_fcval[, 'cval'] - round(test_fcval[, 'cval_test'], 2))
#
# summary(round(test_fcval[, 'cval'], 3) - round(test_fcval[, 'cval_test'], 3))
# summary(round(test_fcval[, 'cval'], 2) - round(test_fcval[, 'cval_test'], 2))
#
# # Need to fine tune the critical values.
#
# # Some didn't evaluate:
# summary(test_fcval[is.na(test_fcval[, 'cval_test']), ])
# head(test_fcval[is.na(test_fcval[, 'cval_test']), ])
# tail(test_fcval[is.na(test_fcval[, 'cval_test']), ])
# # All cvals in the hundreds
# # All ranks 9 or greater.
#
# which(is.na(test_fcval[, 'cval_test']))


##################################################
# End
##################################################
