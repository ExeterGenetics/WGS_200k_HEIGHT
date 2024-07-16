#!/bin/bash
pheno=${1}
catvars=${2}
output=${3}
chr=${4}
invnorm=${5}
ncon=${6}
output_prefix=${7}
mac=${8}
struct=${9}
binary=${10}


# build main command
command="
./regenie_v3.0.gz_x86_64_Linux  \
--step 2 \
--pgen chr${chr}_for_regenie \
--out ${output}/${output_prefix} \
--phenoFile Phenotype_TSV \
--covarFile Covariate_TSV \
--bsize 400 \
--catCovarList ${catvars} \
--par-region b38 \
--maxCatLevels 30 \
--pred ${pheno}_Step1_pred.list 
"
# and add in the optional parts if they're required
# inverse normalise
if [ "${invnorm}" == "Yes" ]; then
command=${command}" \
--apply-rint
"
fi
# conditional SNPs
if [ $ncon -gt 0 ]; then
command=${command}" \
--condition-list conditional_list_local 
"
fi


if [ "${binary}" == "Yes" ]; then
command=${command}" \
--bt \
--firth --approx \
--firth-se 
"
fi


else
command=${command}" \

"
fi




# run command
${command}