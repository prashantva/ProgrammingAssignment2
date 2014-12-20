#===============================================================================

#  OVERALL DESCRIPTION OF THE FUNCTIONS IN THIS FILE:

#===============================================================================

## In this file we have two functions "makeCacheMatrix" and "cacheSolve"
## The function "makeCacheMatrix" creates an object of the type list
## it is a list of set, get, setinverse, and getinverse
## The function "cacheSolve" gives the inverse of the matrix
## It computes the inverse if the matrix is new, 
## OR it just takes it from the cache, if the inverse has already been computed.

#===============================================================================
## Typical use:
#===============================================================================
## X<-matrix(c(1, 2, 3, 4), 2, 2) # create a matrix
## Y<-makeCacheMatrix(X) # create the object Y that contains a list of functions
## cacheSolve(Y)
#===============================================================================

## DESCRIPTION OF THE FUNCTION "makeCacheMatrix"
## The function makeCacheMatrix take a square matrix X as the input 
# This function creates an object of the class "list"
# This list contains four functions set, get, setinverse, getinverse

#===============================================================================

makeCacheMatrix <- function(X = matrix()) 
{
      # ------------------------------------------------------------------------
      
      Z <- NULL # Z is the cached value, right now it is set to NULL
      
      # The function "set" can be used to set the matrix
      set <- function(Y) 
      {
            X <<- Y  
            Z <<- NULL
      }
      
      # ------------------------------------------------------------------------
      
      # The function "get" can be used to get the matrix
      
      get <- function() 
      {
            X
      }
      
      # ------------------------------------------------------------------------
      
      # The function "setinverse" is used to set the inverse of the matrix
      
      setinverse <- function(inv) 
      {
            Z <<- inv
      }
      
      # ------------------------------------------------------------------------
      
      # The function "getinverse" is used to get the inverse
      
      getinverse <- function() 
      {
            Z
      }
      
      # ------------------------------------------------------------------------
      
      # Finally we return the list of four functions.
      list(set = set, get = get, setinverse = setinverse, getinverse=getinverse)
      
      # ------------------------------------------------------------------------
}




#===============================================================================

# OVERALL DESCRIPTION OF THE FUNCTION "cacheSolve"

## The function "cacheSolve" take the object created using the function 
## makeCacheMatrix as the input.
## If the inverse of the matrix is not computed then it is computed.
## If the inverse of the matrix already computed then it is not computed again,
## but rather it is accessed from the stored value in the cache.

#===============================================================================

cacheSolve <- function(Y, ...) 
{
      # ------------------------------------------------------------------------
      
      Z <- Y$getinverse() 
      # Here Z is given the value of the object Y$getinverse using the object
      # that was created before.
      
      # ------------------------------------------------------------------------
      
      # If the inverse is already computed then get it from the cached data.
      # And exactly this is done in the following if condition statement
      
      if(!is.null(Z)) 
      {
            message("The inverse of the matrix is obtained from the cache.")
            return(Z) # at this point return Z and exit!
      }
      
      # ------------------------------------------------------------------------
      
      # If matrix is new i.e. if the inverse is not yet computed then 
      # we should get the matrix from the object created using 
      # the makeCacheMatrix function
      
      data <- Y$get() 
      
      # ------------------------------------------------------------------------
      
      # Now let us compute the inverse of the matrix and store it in Z
      Z <- solve(data, ...)
      
      # ------------------------------------------------------------------------
      
      # We should let the user know that the inverse is "computed", as opposed to
      # getting it from the cached value
      
      message("The inverse of the matrix is computed.")
      
      # ------------------------------------------------------------------------
      
      # Now we use the function setinverse to set the value of the inverse
      Y$setinverse(Z)
      # Now we return the inverse and exit the function
      Z
      
}

#===============================================================================