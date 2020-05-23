

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
# fracdist_tables.R evaluates test cases from tables
#   of fracdist critial values and p-values and
#   compares them against those evaluated in Fortran.
#
# In round 1, test cases are generated for all cases
#   of rank iq and constant indicator, for randomly
#   chosen values of b, uniformly between 0.5 and 2.
#   For p-values, quantiles were selected from the
#   corresponding chi-squared distribution with d.f. iq^2,
#   with the quantiles chosen by the inverse chi-squared
#   CDF of uniform random variables between 0.8 and 1.0.
#   For critical values, only the conventional levels of
#   significance were used, 0.10, 0.05 and 0.01.
#   While these are not good test cases, more relevant cases
#   are derived from the results of the critical value test
#   cases.
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

# Set directory for test cases.
test_dir <- '~/Research/FCVAR/GitRepo/FCVAR/R_dev/Fortran_tests'

setwd(wd_path)



##################################################
# Generate Test Cases
##################################################

# Set lists of input variables.
iscon_list <- c(0, 1)
iq_list <- seq(12)
clevel_list <- c(0.10, 0.05, 0.01)
num_bb <- 10
num_stat <- 10
set.seed(42)
bb_list <- runif(num_bb, min = 0.50, max = 2.0)
stat_inv_list <- runif(num_stat, min = 0.80, max = 1.0)


# Create two tables, one for each function.


# Test p-values for a variety of values of the statistic.
test_fpval <- expand.grid(bb = bb_list,
                          iscon = iscon_list,
                          stat = rep(NA, num_stat),
                          iq = iq_list)
# Draw test statistic values from the corresponding chi-squared distribution.
iq_length <- 2*num_bb*num_stat
for (iq_num in 1:length(iq_list)) {

  iq <- iq_list[iq_num]
  row_sel <- seq((iq_num - 1)*iq_length + 1, iq_num*iq_length)
  test_fpval[row_sel, 'stat'] <- qchisq(p = rep(stat_inv_list, 2*num_bb),
                                        df = iq^2)

}
# Reorder the columns.
test_fpval <- test_fpval[, c('iscon', 'iq', 'bb', 'stat')]
summary(test_fpval)
head(test_fpval)
tail(test_fpval)


# Test critical values for conventional significance levels.
test_fcval <- expand.grid(bb = bb_list,
                          iscon = iscon_list,
                          clevel = clevel_list,
                          iq = iq_list)
test_fcval <- test_fcval[, c('iscon', 'iq', 'bb', 'clevel')]
# test_fcval <- test_fcval[order(test_fcval$), ]
summary(test_fcval)
head(test_fcval)
tail(test_fcval)


# Save the files in fixed-width format.
# Yes, I know this is slow but I want to control the formatting
# the way I would read it in Fortran.
out_file_name <- 'test_fpval.txt'
out_file_name <- sprintf('%s/%s', out_dir, out_file_name)
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


# Save the files in fixed-width format.
out_file_name <- 'test_fcval.txt'
out_file_name <- sprintf('%s/%s', out_dir, out_file_name)
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
