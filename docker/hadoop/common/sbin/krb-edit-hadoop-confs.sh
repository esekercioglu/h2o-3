#! /bin/bash

set -ex

cd ${HADOOP_CONF_DIR}
for conf in $(ls *.xml); do
    if [ -f "${conf}.part" ]; then
        echo "Putting ${conf}.part to ${conf}"
        echo "Remove the </configuration>"
        sed -i 's/<\/configuration>//g' ${conf}
        echo "Append content of ${conf}.part"
        cat ${conf}.part >> ${conf}
        echo "Append </configuration>"
        echo -e "\n</configuration>" >> ${conf}
        cat ${conf}
        rm ${conf}.part
    else
        echo "File ${conf}.part does not exist"
    fi
done
sed -i "s|SUBST_HADOOP_CONF_DIR|${HADOOP_CONF_DIR}|g" ${HADOOP_CONF_DIR}/*.xml