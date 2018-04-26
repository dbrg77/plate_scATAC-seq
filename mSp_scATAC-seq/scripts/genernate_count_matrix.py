import pandas as pd
from glob import iglob
from scipy.io import mmwrite
from scipy.sparse import csr_matrix

scs = iglob("*/count/*.count")
dfs = []

for df in scs:
    fn = df.split('/')[-1]
    cell = fn[:-6]
    dfs.append(pd.read_table(df, header=None, index_col=0, names=["pid", cell]))

matrix = pd.concat(dfs, axis=1)
# matrix.to_csv('count_matrix_over_aggregate_narrowPeaks.csv')
mtx = csr_matrix(matrix)
mmwrite('mSp_scATAC_count_matrix_over_aggregate.mtx',
        mtx, field='integer')

with open('mSp_scATAC_count_matrix_over_aggregate.rownames', 'w') as f:
    f.write('\n'.join(matrix.index.values))
    f.write('\n')

with open('mSp_scATAC_count_matrix_over_aggregate.colnames', 'w') as f:
    f.write('\n'.join(matrix.columns.values))
    f.write('\n')
