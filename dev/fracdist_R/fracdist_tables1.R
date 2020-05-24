
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
# May 12, 2020
#
##################################################
#
# fracdist_tables.R creates tables for fracdist
#   critial values and p-values and organizes them
#   in a form suitable for an R package.
# This script takes several attempts and the last
#   version is implemented to make the tables
#   available internally.
# That last block of code is stored in the data-raw folder.
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

# Set working directory.
wd_path <- '~/Research/FCVAR/GitRepo/fracdist'

# Set data directory.
data_dir <- '~/Research/FCVAR/fracdist/mn-files'

setwd(wd_path)


##################################################
# Load Packages
##################################################

# Inspired by a subroutine in the Fortran fracdist code
# subroutine readdata(iq,iscon,probs,bbb,xndf)
# c This routine reads data from whichever input file is appropriate
# c for the no-constant case.
# c If iscon=0, files are frmapp01.txt through frmapp12.txt
# c If iscon.ne.0, files are frcapp01.txt through frcapp12.txt




# This function assembles a table of probabilities
# and quantiles for all values of the fractional
# integration parameter for a particular rank and
# soecification of constant.
get_fracdist_tab <- function(iq, iscon, dir_name) {

  # Determine required file name.

  # Depends on whether or not there is a constant term.
  if (iscon == 0) {
    dfirst = 'frmapp'
  } else {
    dfirst = 'frcapp'
  }

  # Depends on the (difference in) cointerating ranks.
  dq <- sprintf('00%d', iq)
  dq <- substr(dq, nchar(dq) - 1, nchar(dq))


  in_file_name <- sprintf('%s/%s%s.txt', dir_name, dfirst, dq)

  # Initialize matrix and open connection.
  frtab <- data.frame(bbb = numeric(221*31),
                      probs = numeric(221*31),
                      xndf = numeric(221*31))

  frtab_lines <- readLines(con = in_file_name)
  lines_read <- 0

  # Loop on fractional integration parameter
  # to collect table from separate pieces.
  for (ib in 1:31) {

    # Read the value of b.
    bbb_str <- frtab_lines[lines_read + 1]
    lines_read <- lines_read + 1
    bbb <- as.numeric(substr(bbb_str, 6, 9))

    # Read the probabilities and quantiles.
    frtab_sub <- data.frame(bbb = rep(bbb, 221),
                            probs = numeric(221),
                            xndf = numeric(221))

    frtab_lines_sub <- frtab_lines[seq(lines_read + 1, lines_read + 221)]
    lines_read <- lines_read + 221
    frtab_sub[, 'probs'] <- as.numeric(substr(frtab_lines_sub, 1, 6))
    frtab_sub[, 'xndf'] <- as.numeric(substr(frtab_lines_sub, 9, 25))

    # Append to the full table.
    frtab[seq((ib - 1)*221 + 1, ib*221), ] <- frtab_sub

  }


  return(frtab)
}



frtab <- get_fracdist_tab(iq = 1, iscon = 0, dir_name = data_dir)

summary(frtab)
head(frtab)
frtab[217:223, ]
tail(frtab)


##################################################
# Loop over tables and save them in a compressed
# format suitable for R packages.
##################################################


# Set directory for output.
out_dir <- '~/Research/FCVAR/fracdist/R-mn-files'

for (iq in seq(12)) {

  for (iscon in c(0, 1)) {

    # Read text file version of table from Fortran package.
    frtab <- get_fracdist_tab(iq = 1, iscon = 0, dir_name = data_dir)


    # Determine corresponding file name for output.

    # Depends on whether or not there is a constant term.
    if (iscon == 0) {
      dfirst = 'frmapp'
    } else {
      dfirst = 'frcapp'
    }

    # Depends on the (difference in) cointerating ranks.
    dq <- sprintf('00%d', iq)
    dq <- substr(dq, nchar(dq) - 1, nchar(dq))


    out_file_name <- sprintf('%s/%s%s.RData', out_dir, dfirst, dq)


    # Save the file in a compressed format suitable for R.
    save(frtab, file = out_file_name)
    # Note that this gave them all the same names.
    # Replaced them in fracdist_init1.R and fracdist_tables2.R.

  }

}


# After initial save, test the optimal compression format.
tools::checkRdaFiles(out_dir)
# Looks good. 54K each file, 1.24M total.

# Inspect one file.
check_frtab <- get(load(file = out_file_name))

class(check_frtab)
head(check_frtab)
tail(check_frtab)
summary(check_frtab)

# See revised version of get_fracdist_tab function:
# get_fracdist_tab(iq, iscon, dir_name, file_ext = 'txt')


##################################################
# Definition of tables
##################################################

# Separate tables loaded in same format as those
# for Fortran version, except in rda format.


##################################################
# First version of Tables: External Data
# Note: Data not needed as external data.
# Revised below
##################################################


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
test_data1 <- get_fracdist_tab(iq = 1, iscon = 0)
summary(test_data1)
summary(frmapp01)
summary(test_data1 - frmapp01)

test_data2 <- get_fracdist_tab(iq = 12, iscon = 1)
summary(test_data2)
summary(frcapp12)
summary(test_data2 - frcapp12)


# Load table of ginv values from Fortran code.
data_dir <- '~/Research/FCVAR/GitRepo/fracdist/dev/fracdist_Fortran/ginv_tests'
in_file_name <- sprintf('%s/test_ginv.csv', data_dir)
ginv_tab <- read.csv(in_file_name, header = FALSE)
ginv_col <- sprintf('iq_%d', seq(12))
colnames(ginv_tab) <- c('probs', ginv_col)

summary(ginv_tab)

# Add to the data folder in the package.
usethis::use_data(ginv_tab, ginv_tab)





##################################################
# Second version: Store tables as internal data
##################################################

# Example:
# usethis::use_data(x, mtcars, internal = TRUE)


# Load table of ginv values from Fortran code.
data_dir <- '~/Research/FCVAR/GitRepo/fracdist/dev/fracdist_Fortran/ginv_tests'
in_file_name <- sprintf('%s/test_ginv.csv', data_dir)
ginv_tab <- read.csv(in_file_name, header = FALSE)
ginv_col <- sprintf('iq_%d', seq(12))
colnames(ginv_tab) <- c('probs', ginv_col)

summary(ginv_tab)

# Test:
# Add to the internal data folder in the package.
# usethis::use_data(ginv_tab, ginv_tab, internal = TRUE)
# Warning: Saving duplicates only once: 'ginv_tab'
# check Saving 'ginv_tab' to 'R/sysdata.rda'

# Add all tables together in one call to use_data().


# Now load tables of quantiles.

# This sets up the folder and files for supporting the fracdist package.

# Set directory where txt files of quantiles are stored for the Fortran version.
data_dir <- '~/Research/FCVAR/fracdist_Fortran/mn-files'


for (iq in seq(12)) {

  for (iscon in c(0, 1)) {

    # Read text file version of table from Fortran package.
    frtab <- get_fracdist_tab(iq = iq, iscon = iscon,
                              dir_name = data_dir, file_ext = 'txt')


    # Determine corresponding file name for output.

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

    # Save the file in a compressed format suitable for R.
    # save(frtab, file = out_file_name)
    # Note that this gave them all the same names.
    # Replaced them in fracdist_init1.R and fracdist_tables2.R.

  }

}





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


# Declare data as internal.
# usethis::use_data_raw()
# check Creating 'data-raw/'
# check Adding '^data-raw$' to '.Rbuildignore'
# check Writing 'data-raw/DATASET.R'
# - Modify 'data-raw/DATASET.R'
# - Finish the data preparation script in 'data-raw/DATASET.R'
# - Use `usethis::use_data()` to add prepared data to package


##################################################
# End
##################################################
