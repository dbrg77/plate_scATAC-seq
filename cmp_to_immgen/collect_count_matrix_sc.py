import sys
from glob import iglob
import pandas as pd
from scipy.io import mmwrite
from scipy.sparse import csr_matrix

dfs = []
cfs = iglob('count_spleen_union/*/*.count')

for cf in cfs:
    fn = cf.split('/')[-1]
    cell = fn[:-6]
    dfs.append(pd.read_table(cf, header=None, names=["pid", cell],
                             index_col="pid"))

matrix = pd.concat(dfs, axis=1)
# matrix.to_csv("mSp_scATAC_count_matrix_over_all.csv")
mtx = csr_matrix(matrix)
mmwrite('mSp_scATAC_count_matrix_over_all.mtx',
        mtx, field='integer')

with open('mSp_scATAC_count_matrix_over_all.rownames', 'w') as f:
    f.write('\n'.join(matrix.index.values))
    f.write('\n')

with open('mSp_scATAC_count_matrix_over_all.colnames', 'w') as f:
    f.write('\n'.join(matrix.columns.values))
    f.write('\n')
