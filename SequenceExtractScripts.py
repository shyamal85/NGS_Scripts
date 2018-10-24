#!/usr/local/bin/python
# fnaEx fna_file gene_list
import sys

class Fasta:
    def __init__(self, Fas_file):
        self.Fas_file = Fas_file

    def readfile(self):
        genes = {}
        with open(self.Fas_file,'r') as Fas: data = [dx.strip('\n') for dx in Fas.readlines() if dx[0] != '#']   
        gene_index = [dx for dx in enumerate(data) if dx[1][0] == '>']
        for cx in range(len(gene_index)-1): genes[gene_index[cx][1][1:]] = ''.join(data[(gene_index[cx][0]+1):(gene_index[cx+1][0])])
        return genes

genes = Fasta(sys.argv[1]).readfile()
found = False
for shortname in [dx.rstrip() for dx in open(sys.argv[2],'r').readlines()]:
    for gene_name in genes.keys():
        if '('+shortname+')' in gene_name: 
            print '>'+gene_name+'\n'+genes[gene_name]
            found = True
    if not found: sys.stderr.write( shortname + ' not found.\n')
    found = False

