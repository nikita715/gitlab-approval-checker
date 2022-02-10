./init.sh

MR_DATA=$(makeRequest GET "/merge_requests/${CI_MERGE_REQUEST_IID}")
log "MR_DATA=$MR_DATA"

read -a arr < <(echo $(echo $MR_DATA | jq -r '.upvotes'))

MR_UPVOTES=${arr[0]}
log "MR_UPVOTES=$MR_UPVOTES"

if [ "${MR_UPVOTES}" -ge "$(expr ${APPROVAL_CHECKER_UPVOTES_QUANTITY})" ];
  then
    echo "MR OK";
  else
    echo "MR ERROR Need more votes";
    exit 1;
fi
