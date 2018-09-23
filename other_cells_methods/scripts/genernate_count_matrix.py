import pandas as pd
from glob import glob
from scipy.io import mmwrite
from scipy.sparse import csr_matrix

count_list = glob("*/count/*.count")
scs = pd.DataFrame()
scs['files'] = count_list
scs['exp'] = scs.files.str.split('/').str[0]
groups = scs.groupby('exp').groups

for exp, idx in groups.items():

    dfs = []
    file_list = list(scs.files[idx])

    for df in file_list:
        fn = df.split('/')[-1]
        cell = fn[:-6]
        dfs.append(pd.read_table(df, header=None, index_col=0, names=["pid", cell]))

    matrix = pd.concat(dfs, axis=1)
    mtx = csr_matrix(matrix)
    mmwrite(exp + '/scATAC_count_matrix_over_aggregate.mtx',
            mtx, field='integer')

    with open(exp + '/scATAC_count_matrix_over_aggregate.rownames', 'w') as f:
        f.write('\n'.join(matrix.index.values))
        f.write('\n')

    with open(exp + '/scATAC_count_matrix_over_aggregate.colnames', 'w') as f:
        f.write('\n'.join(matrix.columns.values))
        f.write('\n')
