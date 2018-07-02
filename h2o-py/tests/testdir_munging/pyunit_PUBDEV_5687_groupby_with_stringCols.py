from __future__ import print_function
import sys
sys.path.insert(1,"../../")
import h2o
from tests import pyunit_utils

def group_by():
    # Connect to a pre-existing cluster

    h2o_f1 = h2o.import_file(path=pyunit_utils.locate("smalldata/jira/test_groupby_with_strings.csv"))
    grouped = h2o_f1.group_by("C1")
    grouped.mean(na="all").median(na="all").max(na="all").min(na="all").sum(na="all")
    f1 = grouped.get_frame()
    assert f1.ncol==6 and f1.nrow==6, "Expected column number: 6, actual: {0}.  Expected row number: 6, actual:" \
                                      " {1}".format(f1.ncol, f1.nrow)
    actualValues = f1.transpose().as_data_frame(use_pandas=False)
    groupbyVals = ['1','2','3','4','5','6']
    groupbySum = ['1','4','9','16','25','36']
    for ind in range(1,5):
        assert actualValues[ind]==groupbyVals, "Expected values: {0}, Actual: {1}".format(groupbyVals, actualValues[ind])
    assert actualValues[6]==groupbySum, "Expected values: {0}, Actual: {1}".format(groupbySum, actualValues[5])



if __name__ == "__main__":
    pyunit_utils.standalone_test(group_by)
else:
    group_by()
