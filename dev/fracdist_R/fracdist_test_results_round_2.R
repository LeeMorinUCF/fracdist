
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
# May 23, 2020
#
##################################################
#
# fracdist_test_results_round_2.R
#   evaluates test cases from tables
#   of fracdist critial values and p-values and
#   compares them against those evaluated in Fortran.
#
# In round 2, test cases are also generated for all cases
#   of rank iq and constant indicator, for randomly
#   chosen values of b, uniformly between 0.510 and 2.000.
#   For p-values, quantiles were selected from the
#   corresponding critical values in the tests from round 1,
#   except that they are perturbed by normal random variable.
#   For critical values, uniformly chosen levels of
#   significance were used, with level of significance drawn
#   from the uniform distribution over [0.01 to 0.10].
#
# Dependencies:
#   fracdist package.
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
wd_path <- '~/Research/FCVAR/GitRepo/fracdist'

# Set directory for test cases.
test_dir <- '~/Research/FCVAR/GitRepo/fracdist/dev/fracdist_Fortran/R_test_cases'

setwd(wd_path)


##################################################
# Load Packages
##################################################

# Load library with functions for calculating
#   critial values and p-values.
devtools::load_all()



##################################################
# Read in files of test cases evaluated in Fortran.
##################################################

# P-value test cases.
in_file_name <- 'test_fpval_round_2.out'
in_file_name <- sprintf('%s/%s', test_dir, in_file_name)
test_fpval <- read.fwf(in_file_name, widths = c(1, 3, 6, 9, 7), skip = 1)
colnames(test_fpval) <- c('iscon', 'iq', 'bb', 'stat', 'pval')


# Critical value test cases.
in_file_name <- 'test_fcval_round_2.out'
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
# Differences are exactly zero, except for the 24 corner cases
# and those are only off on the last decimal.
table(test_fpval[, 'pval'] - round(test_fpval[, 'pval_test'], 4))
# -0.000300000000000022 -0.000199999999999978   -0.0001000000000001
#                     1                     2                     1
# -0.000100000000000044  -9.9999999999989e-05                     0
#                     1                     8                   936
#   9.9999999999989e-05  0.000100000000000044    0.0001000000000001
#                     9                     1                     1

# Inspect the cases visually:
test_fpval[!(test_fpval[, 'pval'] == round(test_fpval[, 'pval_test'], 4)), ]
# Apear to be in unimportant areas, i.e. high p-values,
# which is where the tables are more sparse.

# Good enough for me.


#--------------------------------------------------
# Critical value test cases.
#--------------------------------------------------

test_fcval[, 'cval_test'] <- NA

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
# Correct in all but 17 cases, all only 1 digit off in the last decimal place.
# -0.000100000000031741  -0.00010000000000332 -9.99999999748979e-05
#                     4                     2                     2
#                     0
#                   943
#  9.99999999748979e-05   0.00010000000000332  0.000100000000031741
#                     2                     5                     2
# Good enough for me.


##################################################
# End
##################################################
