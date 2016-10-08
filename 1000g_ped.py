import pandas as pd
import sys

ped=pd.read_csv(sys.argv[1],sep='\t')
tfam=pd.read_csv(sys.argv[2],sep='\t',header=None)
ped.iloc[pd.match(tfam.iloc[:,1],ped.iloc[:,1]),:6].to_csv(sys.argv[2],sep='\t',header=False,index=False)
