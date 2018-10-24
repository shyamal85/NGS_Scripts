####### Quality Control-FastQC #######

#!/bin/bash
#PBS -q batch
#PBS -l nodes=1:ppn=12
#PBS -l walltime=120:00:00
#PBS -N GrassMice_fastqc
#PBS -j oe

cd $PBS_O_WORKDIR
module load fastqc/0.11.3

fastqc ./*fastq.gz

####### Trimming the adaptora and Kmers-Trimmomatic #######

#!/bin/bash
#PBS -q batch
#PBS -l nodes=1:ppn=12
#PBS -l walltime=120:00:00
#PBS -N GrassMice_Trim
#PBS -j oe

cd $PBS_O_WORKDIR
module load trimmomatic/0.33

trimmomatic PE -phred33 /scratch/shyamal/samples/OR906R1.fastq.gz /scratch/shyamal/samples/OR906R2.fastq.gz \
OR906_PE_R1.fq.gz OR906_FR_UPE.fq.gz OR906_PE_R2.fq.gz OR906_RV_UPE.fq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 \

trimmomatic PE -phred33 /scratch/shyamal/samples/OR907R1.fastq.gz /scratch/shyamal/samples/OR907R2.fastq.gz \
OR907_PE_R1.fq.gz OR907_FR_UPE.fq.gz OR907_PE_R2.fq.gz OR907_RV_UPE.fq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 \
	
trimmomatic PE -phred33 /scratch/shyamal/samples/OR910R1.fastq.gz /scratch/shyamal/samples/OR910R2.fastq.gz \
OR910_PE_R1.fq.gz OR910_FR_UPE.fq.gz OR910_PE_R2.fq.gz OR910_RV_UPE.fq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 \
	
trimmomatic PE -phred33 /scratch/shyamal/samples/OR911R1.fastq.gz /scratch/shyamal/samples/OR911R2.fastq.gz \
OR911_PE_R1.fq.gz OR911_FR_UPE.fq.gz OR911_PE_R2.fq.gz OR911_RV_UPE.fq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 \
	

#!/bin/bash
#PBS -q bigmem
#PBS -l nodes=1:ppn=12
#PBS -l walltime=120:00:00
#PBS -N GM_Trinity
#PBS -j oe

cd $PBS_O_WORKDIR
module load trinity/2.0.6


/opt/trinity/2.0.6/Trinity --seqType fq --max_memory 250G \
	--left OR906_PE_R1.fq.gz,OR907_PE_R1.fq.gz,OR910_PE_R1.fq.gz,OR911_PE_R1.fq.gz \
		--right OR906_PE_R2.fq.gz,OR907_PE_R2.fq.gz,OR910_PE_R2.fq.gz,OR911_PE_R2.fq.gz  \
			--output /scratch/shyamal/samples/Trinity/GM_Trinity_July2018.fasta \
				--CPU 12 

###### Build index files for HiSat2 ###### 
#!/bin/bash
#PBS -q batch
#PBS -l nodes=1:ppn=12
#PBS -l walltime=120:00:00
#PBS -N PM_genome_index
#PBS -j oe

cd $PBS_O_WORKDIR

module load hisat2/2.1.0

hisat2-build Peromyscus_maniculatus_genome.fa /scratch/shyamal/samples/Reference_gtf/reference/HiSat2_IndexFiles/PM_index/PM_genome_Index

###### HiSat2- refrence-sam to bam, sorting and indexing for generating counts #######

#!/bin/bash
#PBS -q bigmem
#PBS -l nodes=1:ppn=12
#PBS -l walltime=120:00:00
#PBS -N GM_HiSat2_OR906
#PBS -j oe

cd $PBS_O_WORKDIR

module load hisat2/2.1.0
module load samtools/1.3.1


HISAT_INDEX=/scratch/shyamal/samples/03_HiSat2/Reference_gtf/reference/HiSat2_IndexFiles/PM_index/PM_genome_Index
HISAT_STRANDNESS=FR
GFF_REFERENCE=/scratch/shyamal/samples/03_HiSat2/Reference_gtf/reference/HiSat2_IndexFiles/PM_index/Peromyscus_maniculatus_bairdii.Pman_1.0.93.gtf.gz

hisat2 -x /scratch/shyamal/samples/03_HiSat2/Reference_gtf/reference/HiSat2_IndexFiles/PM_index/PM_genome_Index \
	--dta -1 /scratch/shyamal/samples/03_HiSat2/OR906/OR906_PE_R1.fq.gz -2 /scratch/shyamal/samples/03_HiSat2/OR906/OR906_PE_R2.fq.gz --rna-strandness FR -S /scratch/shyamal/samples/03_HiSat2/OR906/OR906.out.sam 


samtools view -bT /scratch/shyamal/samples/03_HiSat2/Reference_gtf/reference/Peromyscus_maniculatus_genome.fa /scratch/shyamal/samples/03_HiSat2/OR906/OR906.out.sam > /scratch/shyamal/samples/03_HiSat2/OR906/OR906.out.bam   

samtools sort -o /scratch/shyamal/samples/03_HiSat2/OR906/OR906_sorted.bam /scratch/shyamal/samples/03_HiSat2/OR906/OR906.out.bam


samtools index /scratch/shyamal/samples/03_HiSat2/OR906/OR906_sorted.bam /scratch/shyamal/samples/03_HiSat2/OR906/OR906_sorted.bai


##############
#!/bin/bash
#PBS -q bigmem
#PBS -l nodes=1:ppn=12
#PBS -l walltime=120:00:00
#PBS -N GM_HiSat2_OR907
#PBS -j oe

cd $PBS_O_WORKDIR

module load hisat2/2.1.0
module load samtools/1.3.1


HISAT_INDEX=/scratch/shyamal/samples/03_HiSat2/Reference_gtf/reference/HiSat2_IndexFiles/PM_index/PM_genome_Index
HISAT_STRANDNESS=FR
GFF_REFERENCE=/scratch/shyamal/samples/03_HiSat2/Reference_gtf/reference/HiSat2_IndexFiles/PM_index/Peromyscus_maniculatus_bairdii.Pman_1.0.93.gtf.gz

hisat2 -x /scratch/shyamal/samples/03_HiSat2/Reference_gtf/reference/HiSat2_IndexFiles/PM_index/PM_genome_Index \
	--dta -1 /scratch/shyamal/samples/03_HiSat2/OR907/OR907_PE_R1.fq.gz -2 /scratch/shyamal/samples/03_HiSat2/OR907/OR907_PE_R2.fq.gz --rna-strandness FR -S /scratch/shyamal/samples/03_HiSat2/OR907/OR907.out.sam 


samtools view -bT /scratch/shyamal/samples/03_HiSat2/Reference_gtf/reference/Peromyscus_maniculatus_genome.fa /scratch/shyamal/samples/03_HiSat2/OR907/OR907.out.sam > /scratch/shyamal/samples/03_HiSat2/OR907/OR907.out.bam   

samtools sort  -o /scratch/shyamal/samples/03_HiSat2/OR907/OR907_sorted.bam /scratch/shyamal/samples/03_HiSat2/OR907/OR907.out.bam 


samtools index /scratch/shyamal/samples/03_HiSat2/OR907/OR907_sorted.bam /scratch/shyamal/samples/03_HiSat2/OR907/OR907_sorted.bai

##############
#!/bin/bash
#PBS -q bigmem
#PBS -l nodes=1:ppn=12
#PBS -l walltime=120:00:00
#PBS -N GM_HiSat2_OR910
#PBS -j oe

cd $PBS_O_WORKDIR

module load hisat2/2.1.0
module load samtools/1.3.1


HISAT_INDEX=/scratch/shyamal/samples/03_HiSat2/Reference_gtf/reference/HiSat2_IndexFiles/PM_index/PM_genome_Index
HISAT_STRANDNESS=FR
GFF_REFERENCE=/scratch/shyamal/samples/03_HiSat2/Reference_gtf/reference/HiSat2_IndexFiles/PM_index/Peromyscus_maniculatus_bairdii.Pman_1.0.93.gtf.gz

hisat2 -x /scratch/shyamal/samples/03_HiSat2/Reference_gtf/reference/HiSat2_IndexFiles/PM_index/PM_genome_Index \
	--dta -1 /scratch/shyamal/samples/03_HiSat2/OR910/OR910_PE_R1.fq.gz -2 /scratch/shyamal/samples/03_HiSat2/OR910/OR910_PE_R2.fq.gz --rna-strandness FR -S /scratch/shyamal/samples/03_HiSat2/OR910/OR910.out.sam 


samtools view -bT /scratch/shyamal/samples/03_HiSat2/Reference_gtf/reference/Peromyscus_maniculatus_genome.fa /scratch/shyamal/samples/03_HiSat2/OR910/OR910.out.sam > /scratch/shyamal/samples/03_HiSat2/OR910/OR910.out.bam   

samtools sort -o /scratch/shyamal/samples/03_HiSat2/OR910/OR910_sorted.bam /scratch/shyamal/samples/03_HiSat2/OR910/OR910.out.bam 


samtools index /scratch/shyamal/samples/03_HiSat2/OR910/OR910_sorted.bam /scratch/shyamal/samples/03_HiSat2/OR910/OR910_sorted.bai

#################

#!/bin/bash
#PBS -q bigmem
#PBS -l nodes=1:ppn=12
#PBS -l walltime=120:00:00
#PBS -N GM_HiSat2_OR911
#PBS -j oe

cd $PBS_O_WORKDIR

module load hisat2/2.1.0
module load samtools/1.3.1


HISAT_INDEX=/scratch/shyamal/samples/03_HiSat2/Reference_gtf/reference/HiSat2_IndexFiles/PM_index/PM_genome_Index
HISAT_STRANDNESS=FR
GFF_REFERENCE=/scratch/shyamal/samples/03_HiSat2/Reference_gtf/reference/HiSat2_IndexFiles/PM_index/Peromyscus_maniculatus_bairdii.Pman_1.0.93.gtf.gz

hisat2 -x /scratch/shyamal/samples/03_HiSat2/Reference_gtf/reference/HiSat2_IndexFiles/PM_index/PM_genome_Index \
	--dta -1 /scratch/shyamal/samples/03_HiSat2/OR911/OR911_PE_R1.fq.gz -2 /scratch/shyamal/samples/03_HiSat2/OR911/OR911_PE_R2.fq.gz --rna-strandness FR -S /scratch/shyamal/samples/03_HiSat2/OR911/OR911.out.sam 


samtools view -bT /scratch/shyamal/samples/03_HiSat2/Reference_gtf/reference/Peromyscus_maniculatus_genome.fa /scratch/shyamal/samples/03_HiSat2/OR911/OR911.out.sam > /scratch/shyamal/samples/03_HiSat2/OR911/OR911.out.bam   

samtools sort  -o /scratch/shyamal/samples/03_HiSat2/OR911/OR911_sorted.bam /scratch/shyamal/samples/03_HiSat2/OR911/OR911.out.bam 


samtools index /scratch/shyamal/samples/03_HiSat2/OR911/OR911_sorted.bam /scratch/shyamal/samples/03_HiSat2/OR911/OR911_sorted.bai






