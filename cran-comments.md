
## Test environments

* local R installation, R 3.6.1
* ubuntu 16.04 (on travis-ci), R 3.6.1
* win-builder (devel)

## R CMD check results

0 errors | 0 warnings | 1 note

I got the following notes:

Found the following (possibly) invalid DOIs:
  DOI: 10.2307/2276207
    From: DESCRIPTION
    Status: Forbidden
    Message: 403
  DOI: 10.2307/2554117
    From: DESCRIPTION
    Status: Forbidden
    Message: 403
    
However, the two DOIs are valid. They can be assessed via the follwing links:

- https://doi.org/10.2307/2276207
- https://doi.org/10.2307/2554117

## Reverse dependencies

There are no reverse dependencies.

