#!/usr/bin/env bash
echo
echo "##### testing all pyCRAC tools #####"
echo
echo "# pyBarcodeFilter.py..."
echo "...demultiplexing illumina indexes"
pyBarcodeFilter.py -f test_f.fastq -r test_r.fastq -b indexes.txt -i -m 1
echo "...demultiplexing illumina indexes on compressed files"
pyBarcodeFilter.py -f test_f.fastq.gz -r test_r.fastq.gz -b indexes.txt -i -m 1 --file_type=fastq.gz
echo "...demultiplexing random barcodes in 5' adapter"
pyBarcodeFilter.py -f test_f_dm.fastq -r test_r_dm.fastq -b barcodes.txt -m 1
echo "...demultiplexing random barcodes in 5' adapter on compressed data and compressing output files"
pyBarcodeFilter.py -f test_f_dm.fastq -r test_r_dm.fastq -b barcodes.txt -m 1 --gz
echo "# pyReadCounters..."
echo "...range 300 and deletions only"
pyReadCounters.py -f test.novo -m 10000 -r 300 --mutations=delsonly --discarded=pyReadCounters_discarded.txt --rpkm -v --gtf=../db/Saccharomyces_cerevisiae.EF2.59.1.3.gtf
echo "...same as above but counting hits for introns only"
pyReadCounters.py -f test.novo -m 10000 -r 300 --mutations=delsonly --discarded=pyReadCounters_discarded.txt --rpkm -a protein_coding --hittable -s intron -o test_intron -v --gtf=../db/Saccharomyces_cerevisiae.EF2.59.1.3.gtf
echo "...same as above but now counting hits in exons only"
pyReadCounters.py -f test.novo -m 10000 -r 300 --mutations=delsonly --discarded=pyReadCounters_discarded.txt --rpkm -a protein_coding --hittable -s exon -o test_exon -v --gtf=../db/Saccharomyces_cerevisiae.EF2.59.1.3.gtf
echo "# pyClusterReads..."
pyClusterReads.py -f test_count_output_reads.gtf -r 300 --cic=5 --ch=5 --co=5 --mutsfreq=10 -o test_count_output_clusters.gtf -v --gtf=../db/Saccharomyces_cerevisiae.EF2.59.1.3.gtf
echo "...counting overlap between clusters and genomic features"
pyReadCounters.py -f test_count_output_clusters.gtf --file_type=gtf -v --gtf=../db/Saccharomyces_cerevisiae.EF2.59.1.3.gtf
echo "# pyMotif..."
echo "...with range setting"
pyMotif.py -f test_count_output_clusters.gtf -r 300 -v --gtf=../db/Saccharomyces_cerevisiae.EF2.59.1.3.gtf --tab=../db/Saccharomyces_cerevisiae.EF2.59.1.0.fa.tab
echo "...with annotation = protein_coding"
pyMotif.py -f test_count_output_clusters.gtf -a protein_coding -v --gtf=../db/Saccharomyces_cerevisiae.EF2.59.1.3.gtf --tab=../db/Saccharomyces_cerevisiae.EF2.59.1.0.fa.tab
echo "# pyBinCollector..."
echo "...with annotation = protein_coding"
pyBinCollector.py -f test_count_output_clusters.gtf -a protein_coding -n 50 -o test_count_output_protein_coding_50.pileup -v --gtf=../db/Saccharomyces_cerevisiae.EF2.59.1.3.gtf
echo "...with all annotations"
pyBinCollector.py -f test_count_output_clusters.gtf -n 50 -o test_count_output_all_50.pileup -v --gtf=../db/Saccharomyces_cerevisiae.EF2.59.1.3.gtf
echo "...with --binoverlap flag"
pyBinCollector.py -f test_count_output_clusters.gtf -n 50 --binoverlap 1 5 -o test_count_output_selected_1_5.gtf -v --gtf=../db/Saccharomyces_cerevisiae.EF2.59.1.3.gtf
echo "...with --outputall flag"
pyBinCollector.py -f test_count_output_clusters.gtf -n 50 --outputall -v --gtf=../db/Saccharomyces_cerevisiae.EF2.59.1.3.gtf
echo "# pyPileup..."
echo "...with genes list"
pyPileup.py -f test.novo -g genes.list --limit=1000 --discarded=pyPileup_discarded.txt -v --gtf=../db/Saccharomyces_cerevisiae.EF2.59.1.3.gtf --tab=../db/Saccharomyces_cerevisiae.EF2.59.1.0.fa.tab
echo "...with genes list and removal of duplicates"
pyPileup.py -f test.novo -g genes.list --limit=1000 --blocks -v --gtf=../db/Saccharomyces_cerevisiae.EF2.59.1.3.gtf --tab=../db/Saccharomyces_cerevisiae.EF2.59.1.0.fa.tab
echo "...with chromosome coordinates"
pyPileup.py -f test.novo --chr test_coordinates.txt --limit=1000 -v --gtf=../db/Saccharomyces_cerevisiae.EF2.59.1.3.gtf --tab=../db/Saccharomyces_cerevisiae.EF2.59.1.0.fa.tab
echo "...with chromosome coordinates and removal of duplicates"
pyPileup.py -f test.novo --chr test_coordinates.txt --limit=1000 --blocks -v --gtf=../db/Saccharomyces_cerevisiae.EF2.59.1.3.gtf --tab=../db/Saccharomyces_cerevisiae.EF2.59.1.0.fa.tab
echo "# pyReadAligner..."
echo "...with chromosome coordinates"
pyReadAligner.py -f test.novo --chr test_coordinates.txt --limit=1000 --discarded=pyReadAligner_discarded.txt -v --gtf=../db/Saccharomyces_cerevisiae.EF2.59.1.3.gtf --tab=../db/Saccharomyces_cerevisiae.EF2.59.1.0.fa.tab
echo "...with genes list and mutation filtering"
pyReadAligner.py -f test.novo -g genes.list --limit=500 --mutations=delsonly -v --gtf=../db/Saccharomyces_cerevisiae.EF2.59.1.3.gtf --tab=../db/Saccharomyces_cerevisiae.EF2.59.1.0.fa.tab
echo "# pyCalculateFDRs..."
pyCalculateFDRs.py -f test_count_output_reads.gtf -r 200 -o test_count_output_FDRs_005.gtf -v -m 0.05 --gtf=../db/Saccharomyces_cerevisiae.EF2.59.1.3.gtf -c ../db/Saccharomyces_cerevisiae.EF2.59.1.0_chr_lengths.txt
echo "# pyCalculateMutationFrequencies..."
pyCalculateMutationFrequencies.py -i test_count_output_FDRs_005.gtf -r test_count_output_reads.gtf -o test_count_output_FDRs_005_with_muts.gtf --mutsfreq=20 -v -c ../db/Saccharomyces_cerevisiae.EF2.59.1.0_chr_lengths.txt
echo
echo "##### testing pyCRAC scripts #####"
echo
echo "# pyFastqJoiner.py..."
pyFastqJoiner.py -f test_f.fastq test_r.fastq -c "|" -o test_joined.fastq
echo "...with compressed data and output compression"
pyFastqJoiner.py -f test_f.fastq.gz test_r.fastq.gz --file_type=fastq.gz -c "|" --gz -o test_joined_compressed.fastq
echo "...with reverse-complementing the reverse read"
pyFastqJoiner.py -f test_f.fastq test_r.fastq --reversecomplement -c "|" -o test_reverse_joined.fastq
echo "# pyFastqDuplicateRemover.py..."
echo "...with single-end data"
pyFastqDuplicateRemover.py -f test_f.fastq -o test_f.fasta
echo "...with paired-end data"
pyFastqDuplicateRemover.py -f test_f.fastq -r test_r.fastq -o test
echo "# pyFastqSplitter.py..."
pyFastqSplitter.py -f test_joined.fastq -c "|" -o test_splitted
echo "...with compressed data"
pyFastqSplitter.py -f test_joined_compressed.fastq.gz --file_type=fastq.gz -c "|" -o test_compressed_splitted
echo "...with compressed data and compressing output"
pyFastqSplitter.py -f test_joined_compressed.fastq.gz --file_type=fastq.gz -c "|" -o test_compressed_splitted --gzip
echo "# pyCheckGTFfile.py..."
pyCheckGTFfile.py --gtf=test.gtf -o test_corrected.gtf
echo "# pyGetGTFSources.py..."
pyGetGTFSources.py --gtf=test.gtf -o test_gtf_sources.txt --count
echo "# pyGetGeneNamesFromGTF.py..."
pyGetGeneNamesFromGTF.py --gtf=test.gtf -a gene_name -o test_gtf_gene_names.txt --count
echo "# pyNormalizeIntervalLengths with various flags..."
pyNormalizeIntervalLengths.py -f test_count_output_FDRs_005.gtf -c ../db/Saccharomyces_cerevisiae.EF2.59.1.0_chr_lengths.txt --fixed 20 -o test_count_output_FDRs_fixed_20.gtf -v
pyNormalizeIntervalLengths.py -f test_count_output_FDRs_005.gtf -c ../db/Saccharomyces_cerevisiae.EF2.59.1.0_chr_lengths.txt --min 20 -o test_count_output_FDRs_min_20.gtf -v
pyNormalizeIntervalLengths.py -f test_count_output_FDRs_005.gtf -c ../db/Saccharomyces_cerevisiae.EF2.59.1.0_chr_lengths.txt --addboth 20 -o test_count_output_FDRs_addboth_20.gtf -v
pyNormalizeIntervalLengths.py -f test_count_output_FDRs_005.gtf -c ../db/Saccharomyces_cerevisiae.EF2.59.1.0_chr_lengths.txt --addleft 20 -o test_count_output_FDRs_addleft_20.gtf -v
pyNormalizeIntervalLengths.py -f test_count_output_FDRs_005.gtf -c ../db/Saccharomyces_cerevisiae.EF2.59.1.0_chr_lengths.txt --addright 20 -o test_count_output_FDRs_addright_20.gtf -v
echo "# pyAlignment2Tab.py..."
pyAlignment2Tab.py -f sense-reads_SNR17A_genomic_test.fasta -o sense-reads_SNR17A_genomic_test.tab
echo "# pyExtractLinesFromGTF.py..."
pyExtractLinesFromGTF.py --gtf=test.gtf -g genes.list -o test_snR17A.gtf -a gene_name
echo "# pyGTF2bed.py..."
pyGTF2bed.py --gtf=test_count_output_reads.gtf -o test.bed -n test_gtf -d test_gtf --color red
echo "# pyGTF2bedGraph.py..."
echo "...default settings"
pyGTF2bedGraph.py --gtf=test_count_output_reads.gtf -o test_out -t reads -n test_gtf -d test_gtf -v -c ../db/Saccharomyces_cerevisiae.EF2.59.1.0_chr_lengths.txt
echo "...normalized to hits per million"
pyGTF2bedGraph.py --gtf=test_count_output_reads.gtf -o test_out_norm --permillion -t reads -n test_gtf -d test_gtf -v -c ../db/Saccharomyces_cerevisiae.EF2.59.1.0_chr_lengths.txt
echo "...start positions"
pyGTF2bedGraph.py --gtf=test_count_output_reads.gtf -o test_out_norm_5end --permillion -t startpositions -n test_gtf -d test_gtf -v -c ../db/Saccharomyces_cerevisiae.EF2.59.1.0_chr_lengths.txt
echo "...end positions"
pyGTF2bedGraph.py --gtf=test_count_output_reads.gtf -o test_out_norm_3end --permillion -t endpositions -n test_gtf -d test_gtf -v -c ../db/Saccharomyces_cerevisiae.EF2.59.1.0_chr_lengths.txt
echo "# pyGTF2sgr.py..."
echo "...default settings"
pyGTF2sgr.py --gtf=test_count_output_reads.gtf -o test_out -v -c ../db/Saccharomyces_cerevisiae.EF2.59.1.0_chr_lengths.txt
echo "...normalized to hits per million"
pyGTF2sgr.py --gtf=test_count_output_reads.gtf -o test_out_norm --permillion -v -c ../db/Saccharomyces_cerevisiae.EF2.59.1.0_chr_lengths.txt
echo "...start positions"
pyGTF2sgr.py --gtf=test_count_output_reads.gtf -o test_out_norm_5end --permillion -t startpositions -v -c ../db/Saccharomyces_cerevisiae.EF2.59.1.0_chr_lengths.txt
echo "...end positions"
pyGTF2sgr.py --gtf=test_count_output_reads.gtf -o test_out_norm_3end --permillion -t endpositions -v -c ../db/Saccharomyces_cerevisiae.EF2.59.1.0_chr_lengths.txt
echo "# pyFilterGTF.py..."
pyFilterGTF.py -f test_count_output_reads.gtf -o test_sense_filtered_reads.gtf -a protein_coding --gtf=../db/Saccharomyces_cerevisiae.EF2.59.1.3.gtf
echo "# pybed2GTF.py..."
pybed2GTF.py --bed=test.bed -o test_bed2gtf.gtf --gtf=../db/Saccharomyces_cerevisiae.EF2.59.1.3.gtf
echo "# pyFasta2tab.py..."
pyFasta2tab.py -f sense-reads_SNR17A_genomic_test.fasta -o sense-reads_SNR17A_genomic_test_f2a.tab
echo
echo "##### tests finished #####"
echo
