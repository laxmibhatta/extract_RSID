INFO=/mnt/work/genotypes/imp/hrc_wgs_20161002/vcf_info/vcf_info_merged/INFO_HRC_WGS_HRC_CHR_X_Imputation.txt
dictionary=/mnt/cargo/laxmi/snp151.txt.gz
output=/mnt/archive/laxmi/RSID
tmp=/mnt/archive/laxmi/tmp

zcat $dictionary | awk ' {print substr($2, 4)":"$4"\t"$10"\t"$3"\t"$4"\t"$5"\t"$12"\t"$20} '  > $tmp/tmp.txt
awk '$6 == "single"' $tmp/tmp.txt  > $tmp/tmp1.txt
awk '{ print $0"\t"$4-$3; }' $tmp/tmp1.txt | awk '$8 == "1"' > $tmp/tmp2.txt

cat $INFO  | awk -F'[: \t]' '{print $1"\t"$2"\t"$0}' > $tmp/tmp5.txt
awk -F"\t" '{ if ($1 == "X") $1="23";}1'  OFS="\t" $tmp/tmp5.txt > $tmp/tmp6.txt
cat $tmp/tmp6.txt | sort -k1n,1 -k2n,2  -T /mnt/archive/laxmi/tmp  | cut -f3- | sed '1,22d'  > $tmp/tmp7.txt

join  -a2 -e NA  -1 1 -2 1 -o auto  <(sort -k1,1 $tmp/tmp2.txt -T /mnt/archive/laxmi/tmp)  <(sort -k1,1  $tmp/tmp7.txt -T /mnt/archive/laxmi/tmp)  > $tmp/tmp8.txt
cat  $tmp/tmp8.txt | awk -F'[: \t]' '{print $1"\t"$2"\t"$0}' | awk '{print $1"\t"$2"\t"$3"\t"$23"\t"$7"\t"$11"\t"$12"\t"$13"\t"$14"\t"$15"\t"$16"\t"$17"\t"$18"\t"$19"\t"$20"\t"$21"\t"$22}' > $output/rsid_snp151_hunt_vcfinfo.txt
rm $tmp/tmp*
