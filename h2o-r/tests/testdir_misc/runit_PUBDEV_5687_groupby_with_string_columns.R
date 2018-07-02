setwd(normalizePath(dirname(R.utils::commandArgs(asValues=TRUE)$"f")))
source("../../scripts/h2o-r-test-setup.R")
##
# Test groupby functions on a frame with String columns
##

test <- function(conn) {
  Log.info("Upload dataset with String columns into H2O...")
  df.hex <- h2o.uploadFile(locate("smalldata/jira/test_groupby_with_strings.csv"))

  Log.info("Test method = nrow...")
  browser()
  gp_nrow <- h2o.group_by(data = df.hex, by = "C1", nrow("C4"))
  gp_nrow <- as.data.frame(gp_nrow)[,2]
  r_nrow  <- c(1:6)
  checkEqualsNumeric(gp_nrow, r_nrow)
 
  Log.info("Test method = median...")
  browser()
  gp_nrow <- h2o.group_by(data = df.hex, by = "C1", median("C4"))
  gp_nrow <- as.data.frame(gp_nrow)[,2]
  r_nrow  <- c(1:6)
  checkEqualsNumeric(gp_nrow, r_nrow) 
}

doTest("Testing different methods for groupby for dataset with String columns:", test)

