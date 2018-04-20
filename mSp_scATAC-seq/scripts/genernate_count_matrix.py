import pandas as pd
from glob import iglob

scs = iglob("*/count/*.count")
dfs = []

for df in scs:
    fn = df.split('/')[-1]
    cell = fn[:-6]
    dfs.append(pd.read_table(df, header=None, index_col=0, names=["pid", cell]))

matrix = pd.concat(dfs, axis=1)
matrix.to_csv('count_matrix_over_aggregate_narrowPeaks.csv')
