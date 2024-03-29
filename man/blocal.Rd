% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fracdist.R
\name{blocal}
\alias{blocal}
\title{Interpolate Critical Values Local to Fractional Integration Parameter}
\usage{
blocal(nb = 31, bb, estcrit, bval)
}
\arguments{
\item{nb}{The integer number of values of the fractional integration
parameter \eqn{b}. The default is 31, which is the number of gridpoints
between 0.5 and 2.0 in the lookup tables.}

\item{bb}{The fractional integration parameter, which can take on values
between 0.5 and 2.0.}

\item{estcrit}{A numeric scalar that is an estimate of the critical value,
a quantile, corresponding to a particular probability.}

\item{bval}{A numeric vector of the fractional integration parameter \eqn{b}
ranging between 0.5 and 2.0 to match those in the lookup tables.}
}
\value{
A numeric scalar that is the sum of regression coefficients
from a response surface regression.
}
\description{
\code{blocal} calculates an approximation to the CDF for a particular
value of the fractional integration parameter b.
}
\note{
The fractional integration parameter \code{b} must lie within
the interval \eqn{[0.50, 2]}. If \code{b} is less than 0.5,
the relevant distribution is chi-squared. A value above 2 is less common
but might be avoided by differencing the data before estimating the model
under consideration.
}
\examples{
frtab <- get_fracdist_tab(iq = 3, iscon = 0)
bval <- unique(frtab[, 'bbb'])
probs <- unique(frtab[, 'probs'])
estcrit <- frtab[frtab[, 'probs'] == probs[201], 'xndf']
bedf_i <- blocal(nb = 31, bb = 0.75, estcrit, bval)
}
\references{
James G. MacKinnon and Morten \enc{Ø}{O}rregaard Nielsen,
"Numerical Distribution Functions of Fractional Unit Root and Cointegration Tests,"
\emph{Journal of Applied Econometrics}, Vol. 29, No. 1, 2014, pp.161-171.
}
