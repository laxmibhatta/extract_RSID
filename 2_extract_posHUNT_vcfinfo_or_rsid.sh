input=/mnt/archive/laxmi/RSID/bloodpressure_rsid_newset.txt
reference=/mnt/archive/laxmi/RSID/rsid_snp151_hunt_vcfinfo.txt
# 1=chr, 2=pos, 3=chr:pos, 4=chr:pos_A1/A2, 5=rs, 6=REF(0), 7=ALT(1), 8=ALT_Frq, 9=MAF, 10=AvgCall, 11=Rsq, 12=Genotyped, 13=LooRsq, 14=EmpR, 15=EmpRsq, 16=Dose0, 17=Dose1 
output=/mnt/archive/laxmi/RSID/bloodpressure_rsid_newset_Rsq_output.txt
tmp=/mnt/archive/laxmi/RSID/

cat $input | awk '{ print $1 }' > $tmp/tmp1.txt
cat $reference  > $tmp/tmp2.txt

join  -1 1 -2 5  -o auto  <(sort -k1,1 $tmp/tmp1.txt -T /mnt/archive/laxmi/tmp)  <(sort -k5,5  $tmp/tmp2.txt -T /mnt/archive/laxmi/tmp)  > $tmp/tmp3.txt
sort -k2V,2  $tmp/tmp3.txt | awk '{ print $1"\t"$5"\t"$11 }'  > $output

rm $tmp/tmp*
