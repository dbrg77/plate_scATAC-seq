from glob import iglob
import pandas as pd

dfs = []
cfs = iglob('immgen_count/*.count')

for cf in cfs:
    fn = cf.split('/')[-1]
    cell = fn[:-6]
    dfs.append(pd.read_table(cf, header=None, names=["pid", cell],
                             index_col="pid"))

matrix = pd.concat(dfs, axis=1)
matrix.to_csv("immgen_count_matrix_over_all.csv")
