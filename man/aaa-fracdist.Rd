% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fracdist.R
\docType{package}
\name{aaa-fracdist}
\alias{aaa-fracdist}
\title{Numerical Distribution Functions of
Fractional Unit Root and Cointegration Tests}
\description{
A package for calculating numerical distribution functions of fractional
unit root and cointegration tests. The included functions calculate
critial values and p-values for unit root and cointegration tests
and for rank tests in the Fractionally Cointegrated Vector
Autoregression (FCVAR) model (see Johansen and Nielsen, 2012).
}
\details{
Because these distributions depend
on a real-valued parameter b which must be estimated, simple tabulation is not
feasible. Instead, response surface regressions are used to obtain the numerical
distribution functions and combined by model averaging. As a function of the
dimension of the problem, q, and a value of the fractional integration order b,
this provides either a set of critical values or the asymptotic P-value for any
value of the likelihood ratio statistic.

The functions in this package are based on the functions and subroutines in the
Fortran program \code{fracdist.f} to accompany an article by MacKinnon and Nielsen (2014).
This program is available from the archive of the Journal of Applied Econometrics
at \url{http://qed.econ.queensu.ca/jae/datasets/mackinnon004/}.
An alternative C++ implementation of this program is also available; see
\url{https://github.com/jagerman/fracdist/blob/master/README.md} for details.
}
\references{
James G. MacKinnon and Morten \enc{O}{O}rregaard Nielsen,
"Numerical Distribution Functions of Fractional Unit Root and Cointegration Tests,"
Journal of Applied Econometrics, Vol. 29, No. 1, 2014, pp.161-171.

Johansen, S. and M. \enc{O}{O}. Nielsen (2012).
"Likelihood inference for a fractionally cointegrated vector autore-gressive model,"
Econometrica 80, pp.2667-2732.
}
