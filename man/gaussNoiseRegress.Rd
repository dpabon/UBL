\name{gaussNoiseRegress}
\alias{gaussNoiseRegress}

\title{
Introduction of Gaussian Noise for the generation of synthetic examples to handle imbalanced regression problems
}
\description{
 This strategy performs both oversampling and undersampling. The undersampling is randomly performed on the examples below the relevance threshold defined by the user. Regarding the oversampling method, this is based on the generation of new synthetic examples with the introduction of a small perturbation on existing examples through gaussian noise. A new example from a rare "class"" is obtained by perturbing all the features and the traget variable a percentage of its standard deviation (evaluated on the rare examples). The value of nominal features of the new example is randomly selected according to the frequency of the values existing in the rare cases of the bump in consideration.
}
\usage{
gaussNoiseRegress(form, data, rel="auto", thr.rel=0.5, C.perc="balance", pert=0.1, repl=FALSE)
}

\arguments{
  \item{form}{
    A formula describing the prediction problem
  }
  \item{data}{
    A data frame containing the original (unbalanced) data set
  }
  \item{rel}{
    The relevance function which can be automatically ("auto") determined with uba package (the default) or may be provided by the user through a matrix.
  }
  \item{thr.rel}{
    A number indicating the relevance threshold above which a case is considered as belonging to the rare "class".
  }
    \item{C.perc}{
      A list containing the percentage(s) of under- or/and  over-sampling to apply to each "class" obtained with the threshold. The over-sampling percentage means that the examples above the threshold are increased by this percentage. The undersampling percentage means that the normal cases (cases below the threshold) are undersampled by this percentage. Alternatively it may be "balance" (the default) or "extreme", cases where the sampling percentages are automatically estimated.
  }
  \item{pert}{
    A number indicating the level of perturbation to introduce when generating synthetic examples. Assuming as center the base example, this parameter defines the radius (based on the standard deviation) where the new example is generated.
  }
  \item{repl}{
    A boolean value controling the possibility of having repetition of examples when performing undersampling by selecting among the "normal" examples.
  }
}
\details{

}
\value{
  The function returns a data frame with
  the new data set resulting from the application of random undersampling and oversampling through the generation of synthetic examples using Gaussian noise. 
}
\references{
Sauchi Stephen Lee. (1999)  \emph{Regularization in skewed binary classification.}
Computational Statistics Vol.14, Issue 2, 277-292.
Sauchi Stephen Lee. 2000.  \emph{Noisy replication in skewed binary classification.}
Computational statistics & data analysis Vol. 34, Issue 2, 165–191.
}
\author{ Paula Branco \email{paobranco@gmail.com}, Rita Ribeiro
  \email{rpribeiro@dcc.fc.up.pt} and Luis Torgo \email{ltorgo@dcc.fc.up.pt} }
  
  
\seealso{
\code{\link{smoteRegress}}
}

\examples{
  library(DMwR)
  data(algae)
  clean.algae <- algae[complete.cases(algae),]
  C.perc=list(0.5, 3) 
  mygn.alg <- gaussNoiseRegress(a7~., clean.algae, C.perc=C.perc)
  gnB.alg <- gaussNoiseRegress(a7~., clean.algae, C.perc="balance", pert=0.1)
  gnE.alg <- gaussNoiseRegress(a7~., clean.algae, C.perc="extreme")
  
  plot(density(clean.algae$a7))
  lines(density(gnE.alg$a7), col=2)
  lines(density(gnB.alg$a7), col=3)
  lines(density(mygn.alg$a7), col=4)



  ir<- iris[-c(95:130),]
  mygn1.iris <- gaussNoiseRegress(Sepal.Width~., ir, C.perc=list(0.5,2.5))
  mygn2.iris <- gaussNoiseRegress(Sepal.Width~., ir, C.perc=list(0.2,4), thr.rel=0.8)
  gnB.iris <- gaussNoiseRegress(Sepal.Width~., ir, C.perc="balance")
  gnE.iris <- gaussNoiseRegress(Sepal.Width~., ir, C.perc="extreme")
  
  # defining a relevance function
  rel <- matrix(0,ncol=3,nrow=0)
  rel <- rbind(rel,c(2,1,0))
  rel <- rbind(rel,c(3,0,0))
  rel <- rbind(rel,c(4,1,0))

  gn.rel <- gaussNoiseRegress(Sepal.Width~., ir, rel =rel, C.perc=list(5,0.2,5))

  plot(density(ir$Sepal.Width), ylim=c(0,1))
  lines(density(gnB.iris$Sepal.Width), col=3)
  lines(density(gnE.iris$Sepal.Width, bw=0.3), col=4)
  #check the impact of a different relevance threshold
  lines(density(gn.rel$Sepal.Width), col=2)
}

\keyword{models}