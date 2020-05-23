
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
# fracdist_test_cases_round_2.R
#   generates test cases for critial values and p-values and
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
wd_path <- '~/Research/FCVAR'

# Set directory for test cases.
test_dir <- '~/Research/FCVAR/GitRepo/fracdist/dev/fracdist_Fortran/R_test_cases'

setwd(wd_path)




##################################################
# Read Test Cases from Round 1
##################################################


# Critical value test cases.
in_file_name <- 'test_fcval_round_1.out'
in_file_name <- sprintf('%s/%s', test_dir, in_file_name)
test_fcval_1 <- read.fwf(in_file_name, widths = c(1, 3, 6, 5, 9), skip = 1)
colnames(test_fcval_1) <- c('iscon', 'iq', 'bb', 'clevel', 'cval')


##################################################
# Set Parameters
##################################################

# Set lists of input variables.
iscon_list <- c(0, 1)
iq_list <- seq(12)
num_bb <- 10
num_stat <- 4
num_clevel <- 4

num_cases <- num_bb*2*num_clevel*12


# Initialize table of p-values.
test_fpval <- expand.grid(bb = rep(NA, num_bb),
                          iscon = iscon_list,
                          stat = rep(NA, num_stat),
                          iq = iq_list)

# Initialize table of critical values.
test_fcval <- expand.grid(bb = rep(NA, num_bb),
                          iscon = iscon_list,
                          clevel = rep(NA, num_clevel),
                          iq = iq_list)


##################################################
# Generate (Pseudo-)Random Part of Test Cases
##################################################

set.seed(1234)
# Draw fractional integration parameters at random.
test_fpval[, 'bb'] <- runif(num_cases, min = 0.510, max = 2.0)
test_fcval[, 'bb'] <- runif(num_cases, min = 0.510, max = 2.0)


# For the p-value tests, take normal random draws
# around the 1, 5 (twice), 1nd 10% critical values.
row_sel <- seq(1, num_cases, by = num_clevel)

test_fpval[row_sel, 'stat'] <-
  test_fcval_1[test_fcval_1[, 'clevel'] == 0.01, 'cval']
test_fpval[row_sel + 1, 'stat'] <-
  test_fcval_1[test_fcval_1[, 'clevel'] == 0.05, 'cval']
test_fpval[row_sel + 2, 'stat'] <-
  test_fcval_1[test_fcval_1[, 'clevel'] == 0.05, 'cval']
test_fpval[row_sel + 3, 'stat'] <-
  test_fcval_1[test_fcval_1[, 'clevel'] == 0.10, 'cval']

# Add a random draw.
test_fpval[, 'stat'] <- test_fpval[, 'stat'] + rnorm(num_cases)


# For the critical value tests, take uniform draws
# of the level of significance.
test_fcval[, 'clevel'] <- runif(num_cases, min = 0.01, max = 0.10)

# Reorder the columns to match format of Fortran input.
test_fpval <- test_fpval[, c('iscon', 'iq', 'bb', 'stat')]
test_fcval <- test_fcval[, c('iscon', 'iq', 'bb', 'clevel')]


summary(test_fpval)
head(test_fpval)
tail(test_fpval)


summary(test_fcval)
head(test_fcval)
tail(test_fcval)

##################################################
# Save table of test cases for p-values
##################################################


# Save the files in fixed-width format.
# Yes, I know this is slow but I want to control the formatting
# the way I would read it in Fortran.
out_file_name <- 'test_fpval.txt'
out_file_name <- sprintf('%s/%s', test_dir, out_file_name)
cat(sprintf('%s\n', paste(colnames(test_fpval), collapse = ' ')),
    file = out_file_name)
for (line in 1:nrow(test_fpval)) {

  cat(sprintf('%d ', test_fpval[line, 'iscon']),
      file = out_file_name, append = TRUE)
  iq <- test_fpval[line, 'iq']
  if (iq >= 10) {
    cat(sprintf('%d ', iq),
        file = out_file_name, append = TRUE)
  } else {
    cat(sprintf(' %d ', iq),
        file = out_file_name, append = TRUE)
  }
  cat(sprintf('%5.3f ', test_fpval[line, 'bb']),
      file = out_file_name, append = TRUE)
  cat(sprintf('%8.4f\n', test_fpval[line, 'stat']),
      file = out_file_name, append = TRUE)

}


##################################################
# Save table of test cases for critical values
##################################################


# Save the files in fixed-width format.
out_file_name <- 'test_fcval.txt'
out_file_name <- sprintf('%s/%s', test_dir, out_file_name)
cat(sprintf('%s\n', paste(colnames(test_fcval), collapse = ' ')),
    file = out_file_name)
for (line in 1:nrow(test_fcval)) {

  cat(sprintf('%d ', test_fcval[line, 'iscon']),
      file = out_file_name, append = TRUE)
  iq <- test_fcval[line, 'iq']
  if (iq >= 10) {
    cat(sprintf('%d ', iq),
        file = out_file_name, append = TRUE)
  } else {
    cat(sprintf(' %d ', iq),
        file = out_file_name, append = TRUE)
  }
  cat(sprintf('%5.3f ', test_fcval[line, 'bb']),
      file = out_file_name, append = TRUE)
  cat(sprintf('%4.2f\n', test_fcval[line, 'clevel']),
      file = out_file_name, append = TRUE)

}


##################################################
# End
##################################################
