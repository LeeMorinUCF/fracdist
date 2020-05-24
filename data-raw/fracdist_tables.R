
##################################################
#
# Fractionally Cointegrated VAR Model
# Tables for Calculating Critical Values and P-values
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
# fracdist_tables.R creates tables for fracdist
#   critial values and p-values and organizes them
#   in a form suitable for an R package.
# This version makes the tables available internally.
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

# Set working directory to location of GitHub repo.
wd_path <- '~/Research/FCVAR/GitRepo/fracdist'

setwd(wd_path)



# Set location of tables of quantiles from Fortran code.
data_dir <- '~/Research/FCVAR/fracdist/mn-files'
# These are the files downloaded from the archive of the
# Journal of Applied Econometrics:
# http://qed.econ.queensu.ca/jae/datasets/mackinnon004/


# Set location of table of ginv values from Fortran code.
ginv_dir <- 'dev/fracdist_Fortran/ginv_tests'
ginv_file_name <- sprintf('%s/test_ginv.csv', ginv_dir)
# These were created from running functions in the Fortran
# code to achieve the same values of variables in
# the response surface regressions.


##################################################
# Load Packages
##################################################

# Load package as necessary.
# library(fracdist)
# devtools::load_all()


##################################################
# Read tables to be stored as internal data
##################################################


# Load table of ginv values from Fortran code.
ginv_tab <- read.csv(ginv_file_name, header = FALSE)
ginv_col <- sprintf('iq_%d', seq(12))
colnames(ginv_tab) <- c('probs', ginv_col)

summary(ginv_tab)



# Load tables of quantiles from the Fortran program.
# This reads all the files for supporting the fracdist package.

for (iq in seq(12)) {

  for (iscon in c(0, 1)) {

    # Read text file version of table from Fortran package.
    frtab <- get_fracdist_tab(iq = iq, iscon = iscon,
                              dir_name = data_dir, file_ext = 'txt')


    # Determine corresponding name of table.

    # Depends on whether or not there is a constant term.
    if (iscon == 0) {
      dfirst = 'frmapp'
    } else {
      dfirst = 'frcapp'
    }

    # Depends on the (difference in) cointerating ranks.
    dq <- sprintf('00%d', iq)
    dq <- substr(dq, nchar(dq) - 1, nchar(dq))


    # out_file_name <- sprintf('%s/%s%s.RData', out_dir, dfirst, dq)
    tab_name <- sprintf('%s%s', dfirst, dq)

    # Assign this table to a particular variable in memory.
    assign(x = tab_name, value = frtab)

  }

}


##################################################
# Store tables as internal data
##################################################


# Save all tables together:
usethis::use_data(frmapp01, frmapp02, frmapp03,
                  frmapp04, frmapp05, frmapp06,
                  frmapp07, frmapp08, frmapp09,
                  frmapp10, frmapp11, frmapp12,
                  frcapp01, frcapp02, frcapp03,
                  frcapp04, frcapp05, frcapp06,
                  frcapp07, frcapp08, frcapp09,
                  frcapp10, frcapp11, frcapp12,
                  ginv_tab, internal = TRUE)

# Output to screen:
# check Saving
# 'frmapp01', 'frmapp02', 'frmapp03',
# 'frmapp04', 'frmapp05', 'frmapp06',
# 'frmapp07', 'frmapp08', 'frmapp09',
# 'frmapp10', 'frmapp11', 'frmapp12',
# 'frcapp01', 'frcapp02', 'frcapp03',
# 'frcapp04', 'frcapp05', 'frcapp06',
# 'frcapp07', 'frcapp08', 'frcapp09',
# 'frcapp10', 'frcapp11', 'frcapp12',
# 'ginv_tab' to 'R/sysdata.rda'


##################################################
# End
##################################################
