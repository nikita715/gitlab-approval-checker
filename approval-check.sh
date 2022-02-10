MR_DATA=$(curl --silent --request GET --header "PRIVATE-TOKEN: $PROJECT_PRIVATE_TOKEN" "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/merge_requests/${CI_MERGE_REQUEST_IID}")
echo "MR_DATA=$MR_DATA"

read -a arr < <(echo $(echo $MR_DATA | jq -r '.upvotes'))

MR_UPVOTES=${arr[0]}
echo "MR_UPVOTES=$MR_UPVOTES"

if [ "${MR_UPVOTES}" -ge "$(expr ${PROJECT_UPVOTES_QUANTITY})" ];
  then
    echo "MR OK";
  else
    echo "MR ERROR Need more votes";
    exit 1;
fi
