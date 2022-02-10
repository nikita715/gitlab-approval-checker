APPROVAL_CHECKER_DEBUG=${APPROVAL_CHECKER_DEBUG:-false}

MR_DATA=$(curl --silent --request GET --header "PRIVATE-TOKEN: $APPROVAL_CHECKER_PRIVATE_TOKEN" "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/merge_requests/${CI_MERGE_REQUEST_IID}")
if [[ "$APPROVAL_CHECKER_DEBUG" == "true" ]]; then echo "MR_DATA=$MR_DATA" ; fi;

read -a arr < <(echo $(echo $MR_DATA | jq -r '.upvotes'))

MR_UPVOTES=${arr[0]}
if [[ "$APPROVAL_CHECKER_DEBUG" == "true" ]]; then echo "MR_UPVOTES=$MR_UPVOTES" ; fi;

if [ "${MR_UPVOTES}" -ge "$(expr ${APPROVAL_CHECKER_UPVOTES_QUANTITY})" ];
  then
    echo "MR OK";
  else
    echo "MR ERROR Need more votes";
    exit 1;
fi
