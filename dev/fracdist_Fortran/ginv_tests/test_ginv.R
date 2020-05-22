
##################################################
#
# Numerical Distribution Functions of
# Fractional Unit Root and Cointegration Tests
# Functions for Critical Values and P-values
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
# test_ginv.R calculates the inverse CDF of the
#   chi-squared distribution and compares them to
#   the values calculated in the original Fortran
#   version of this package.
#
# Dependencies:
#   test_ginv.f to generate the test cases.
#
##################################################


##################################################
# Preparing the Workspace
##################################################

# Clear workspace.
rm(list=ls(all=TRUE))

# Set working directory.
wd_path <- '~/Research/FCVAR/GitRepo/fracdist/dev/fracdist_Fortran/ginv_tests'


setwd(wd_path)




##################################################
# Load Data
##################################################

# Test cases from ginv
in_file_name <- 'test_ginv.csv'
ginv_test <- read.csv(in_file_name, header = FALSE)

gcinv_col <- sprintf('gcinv_%d', seq(12))

colnames(ginv_test) <- c('probs', gcinv_col)


# Test cases from chisqd
in_file_name <- 'test_chinv.csv'
chisqd_test <- read.csv(in_file_name, header = FALSE)


chisqd_col <- sprintf('chisqd_%d', seq(12))

colnames(chisqd_test) <- c('probs', chisqd_col)



##################################################
# Comparison of ginv with qchisq
##################################################

# Original test cases from Fortran.
summary(ginv_test)

# Append values calculated in R.
prob_list <- ginv_test[, 'probs']
qchisq_col <- sprintf('qchisq_%d', seq(12))
diff_col <- sprintf('diff_%d', seq(12))

for (iq in seq(12)) {

  ginv_test[, qchisq_col[iq]] <- qchisq(p = prob_list, df = iq^2)

  ginv_test[, diff_col[iq]] <- ginv_test[, qchisq_col[iq]] -
    ginv_test[, gcinv_col[iq]]

}


summary(ginv_test[, gcinv_col])
summary(ginv_test[, qchisq_col])
summary(ginv_test[, diff_col])
# Ok. They are different. And biased below.
# Errors on the order of -10^(-6) and +10^(-7)
# with bias on the order of -10^(-7)

# Ok. Compare to the other function.


##################################################
# Comparison of ginv with qchisq
##################################################

summary(chisqd_test)


# Append values calculated in R.
for (iq in seq(12)) {

  chisqd_test[, qchisq_col[iq]] <- qchisq(p = prob_list, df = iq^2)

  chisqd_test[, diff_col[iq]] <- chisqd_test[, qchisq_col[iq]] -
    chisqd_test[, chisqd_col[iq]]

}

summary(chisqd_test[, chisqd_col])
summary(chisqd_test[, qchisq_col])
summary(chisqd_test[, diff_col])
# Ok, so these are different too.
# Similar patterns, mostly different numbers here.

# Conclusion: Load exact values from the Fortran code.
# IOW: If it's good enough for James, it's good enough for me.
# IOW: If James is wrong (unlikely), then I want to be wrong like James.



##################################################
# End
##################################################
