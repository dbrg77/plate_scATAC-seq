import pandas as pd
from glob import glob

count_list = glob("*/*/count/*.count")
scs = pd.DataFrame()
scs["files"] = count_list
scs["batch"] = scs.files.str.extract('(.*/.*/)count/.*\.count')
groups = scs.groupby("batch").groups

for path, idx in groups.items():
    dfs = []
    file_list = list(scs.files[idx])
    for df in file_list:
        fn = df.split('/')[-1]
        cell = fn[:-6]
        dfs.append(pd.read_table(df, header=None, index_col=0, names=["pid", cell]))
    matrix = pd.concat(dfs, axis=1)
    matrix.to_csv(path + 'count_matrix_over_aggregate_narrowPeaks.csv')

