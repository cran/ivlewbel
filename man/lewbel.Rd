\name{lewbel}
\alias{lewbel}
\alias{print.lewbel.model}
\title{Identification using heteroscedasticity}
\description{
This function estimates the model parameters and associated standard errors for a 
linear regression model with one or more endogenous regressors. Identification is
achieved through heteroscedastic covariance restrictions within the triangular system.}
\usage{
lewbel(formula, data, clustervar = NULL, robust = TRUE)
}
\arguments{
  \item{formula}{an object of class ``formula'' (or one that can be coerced to that class).}
  \item{data}{the data frame containing these data. This argument must be used.}
  \item{clustervar}{a character value naming the cluster on which to adjust the standard errors and test statistics.}
  \item{robust}{if \code{TRUE} the function reports heteroscedasticity and autorcorrelation consistent (HAC) standard errors and test statistics.}
}
\details{
The formula follows a four-part specification. Each part is separated by a vertical bar character ``|''. The following formula is an example: \code{y2 ~ y1 | x1 + x2 + x3 | x1 + x2 | z1}. Here, \code{y2} is the dependent variable and \code{y1} is the endogenous regressor. The code \code{x1 + x2 + x3} represents the exogenous regressors whereas the third part \code{x1 + x2} specifies the exogenous heteroscedastic variables from which the instruments are derived. The final part \code{z1} is optional, allowing the user to include tradtional instrumental variables. If both \code{robust=TRUE} and \code{!is.null(clustervar)} the function overrides the robust command and computes clustered standard errors and test statistics adjusted to account for clustering. This function computes partial F-statistics that indicate potentially weak identification. In cases where there is more than one endogenous regressor the Angrist-Pischke (2009) method for multivariate first-stage F-statistics is employed.
}
\value{
\item{coef.est}{a coefficient matrix with columns containing the estimates, 
associated standard errors, test statistics and p-values.}
\item{call}{the matched call.}
\item{num.obs}{the number of observations.}
\item{j.test}{J-test for overidentifying restrictions.}
\item{f.test.stats}{Partial F-test statistics for weak IV detection.}
}

\references{
Angrist, J. and Pischke, J.S. (2009). Mostly Harmless Econometrics: An Empiricist's Companion, Princeton University Press.

Lewbel, A. (2012). Using heteroscedasticity to identify and estimate mismeasured and endogenous regressor models. Journal of Business & Economic Statistics, 30(1), 67-80.
}

\examples{

set.seed(1234)
n = 1000
x1 = rnorm(n, 0, 1)
x2 = rnorm(n, 0, 1)
u = rnorm(n, 0, 1)
s1 = rnorm(n, 0, 1)
s2 =  rnorm(n, 0, 1)
ov = rnorm(n, 0, 1)
z1 = rnorm(n, 0 ,1)
e1 = u + exp(x1)*s1 + exp(x2)*s1
e2 = u + exp(-x1)*s2 + exp(-x2)*s2
y1 = 1 + x1 + x2 + ov + e2 + 2*z1
y2 = 1 + x1 + x2 + y1 + 2*ov + e1
data = data.frame(y2, y1, x1, x2, z1)

lewbel(formula = y2 ~ y1 | x1 + x2 | x1 + x2, data = data)
lewbel(formula = y2 ~ y1 | x1 + x2 | x1 + x2 | z1, data = data)
}
