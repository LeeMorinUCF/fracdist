# fracdist

Numerical Distribution Functions of Fractional Unit Root and Co-Integration Tests

## Description

Numerical asymptotic distribution functions of likelihood ratio tests for 
fractional unit roots and co-integration rank. 
For these distributions, the included functions calculate critical values and P-values used in unit root tests, co-integration tests, and rank tests in the 
Fractionally Co-integrated Vector Autoregression (FCVAR) model.

## How it Works

Simple tabulation is not a feasible approach for obtaining
critical values and P-values because these distributions depend
on a real-valued parameter *b* that must be estimated.
Instead, response surface regressions are used to obtain the numerical
distribution functions and combined by model averaging
across values taken from a series of tables.
As a function of the dimension of the problem, *q*,
and a value of the fractional integration order *b*,
this approach provides either a set of critical values or the asymptotic P-value
for any value of the likelihood ratio statistic.
The P-values and critical values are calculated by interpolating from the
quantiles on a grid of probabilities and values of the fractional integration order,
with separate tables for a range of values of co-integrating rank.

The functions in this package are based on the functions and subroutines 
in the Fortran program ```fracdist.f```
to accompany an article by MacKinnon and Nielsen (2014).
This program is available from the archive 
of the *Journal of Applied Econometrics* at

http://qed.econ.queensu.ca/jae/datasets/mackinnon004/.

Alternatively, a C++ implementation of this program is also available; see

https://github.com/jagerman/fracdist/blob/master/README.md 

for details.


## References 

James G. MacKinnon and Morten Ørregaard Nielsen,
"Numerical Distribution Functions of Fractional Unit Root and Co-integration Tests,"
*Journal of Applied Econometrics*, Vol. 29, No. 1, 2014, pp.161-171.

Johansen, S. and M. Ø. Nielsen (2012).
"Likelihood inference for a fractionally co-integrated vector autoregressive model,"
*Econometrica* 80, pp.2667-2732.


## How to Install fracdist

Install the development version on GitHub using the *devtools* package:

```
library(devtools)
devtools::install_github("LeeMorinUCF/fracdist")


```


## Examples

```
> # Calculate P-values:

> fracdist_values(iq = 1, iscon = 0, bb = 0.43, stat = 3.84)
[1] 0.05004352

> fracdist_values(iq = 1, iscon = 0, bb = 0.73, stat = 3.84)
[1] 0.0461


> # Calculate critical values:

> fracdist_values(iq = 1, iscon = 0, bb = 0.73, ipc = FALSE, clevel = 0.05)
[1] 3.7066

> fracdist_values(iq = 1, iscon = 0, bb = 0.43, ipc = FALSE, clevel = 0.05)
[1] 3.841459

> fracdist_values(iq = 1, iscon = 0, bb = 0.73, ipc = FALSE)
[1] 6.4588 3.7066 2.5927

```

## Release Notes


## May 21, 2021: 
Second submission after adjustments to documentation:
* Shortened the package title to 63 characters.
* Replaced examples to avoid using ```\dontrun``` environment. 




### May 20, 2021: 
* First submission.
* Added a `NEWS.md` file to track changes to the package.

#### Checks on Rhub:
* Fedora Linux, R-devel, clang, gfortran
* Ubuntu Linux 20.04.1 LTS, R-release, GCC

#### Checks on local machine:
* Windows 10 Enterprise, version 20H2, OS build 19042.985, R 4.0.5

#### Checks on win-builder:
* devel and release


#### R CMD check results

There were no ERRORs or WARNINGs.

There was one NOTE:

New submission


#### Downstream dependencies

There are currently no downstream dependencies for this package. 

