\name{randUnderRegress}
\alias{randUnderRegress}

\title{
Random undersampling for imbalanced regression problems
}
\description{
This function performs a random undersampling strategy for imbalanced regression problems. Essentially, a percentage of cases of the "class(es)" (bumps below a relevance threshold defined) 
selected by the user are randomly removed. Alternatively, the strategy can be applied to either balance all the 
existing "classes"" or to "smoothly invert" the frequency
of the examples in each "class".

}
\usage{
randUnderRegress(form, data,  rel="auto", thr.rel=0.5, C.perc= "balance", repl=FALSE)
}

\arguments{
  \item{form}{
    A formula describing the prediction problem.
  }
  \item{data}{
    A data frame containing the original imbalanced data set.
  }
  \item{rel}{
    The relevance function which can be automatically ("auto") determined with uba package (the default) or may be provided by the user through a matrix.
  }
  \item{thr.rel}{
    A number indicating the relevance threshold below which a case is considered as belonging to the normal "class".
  }
  \item{C.perc}{
      A list containing the undersampling percentage/s to apply to all/each
        "class" (bump) obtained with the relevance threshold. Examples 
        are randomly removed in each normal "class" according to a percentage. Moreover, different percentages may 
        be provided for each "class". Alternatively, it may be "balance" or "extreme",
        cases where the undersampling percentages are automatically estimated.
  }
  \item{repl}{
  A boolean value controling the possibility of having repetition of examples in the undersampled data set. Defaults to FALSE.
  }
}
\details{
This function performs a random undersampling strategy for dealing with imbalanced regression problems. The examples removed are randomly selected among the examples belonging to the normal "class(es)" (bump of relevance below the threshold defined). The user can chose one or more bumps to be undersampled.

}
\value{
  The function returns a data frame with
  the new data set resulting from the application of the random undersampling strategy.
}
\references{


}
\author{ Paula Branco \email{paobranco@gmail.com}, Rita Ribeiro
  \email{rpribeiro@dcc.fc.up.pt} and Luis Torgo \email{ltorgo@dcc.fc.up.pt} }
  

\seealso{
\code{\link{randOverRegress}}
}
\examples{
  library(DMwR)
  data(algae)
  clean.algae <- algae[complete.cases(algae),]
  alg.myUnd <- randUnderRegress(a7~., clean.algae, C.perc=list(0.5) )
  alg.Bal <- randUnderRegress(a7~., clean.algae, C.perc="balance")
  alg.Ext <- randUnderRegress(a7~., clean.algae, C.perc="extreme")

}

\keyword{models}