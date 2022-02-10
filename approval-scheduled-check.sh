MRS_DATA=$(curl --silent --request GET --header "PRIVATE-TOKEN: $GITLAB_TOKEN_FOR_CI" "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/merge_requests?state=opened")

echo "$MRS_DATA" | jq -r '.[]|[.iid] | @tsv' |
  while IFS=$'\t' read -r MR_ID; do
    MR_DATA=$(curl --insecure --silent --request GET --header "PRIVATE-TOKEN: $GITLAB_TOKEN_FOR_CI" "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/merge_requests/${MR_ID}")
    MR_UPVOTES=$(jq -r '.upvotes' <<<"$MR_DATA")
    echo "MR_ID=$MR_ID, MR_UPVOTES=$MR_UPVOTES"
    if [ "$MR_UPVOTES" -ge "$(expr ${PROJECT_UPVOTES_QUANTITY})" ]; then
      PIPELINES_JSON=$(curl --insecure --silent --request GET --header "PRIVATE-TOKEN: $GITLAB_TOKEN_FOR_CI" "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/merge_requests/${MR_ID}/pipelines")
      PIPELINE_ID=$(jq -r '.[0] | select(.status=="failed") | .id' <<<"$PIPELINES_JSON")
      if [[ -n "$PIPELINE_ID" ]]; then
        JOBS_JSON=$(curl --insecure --silent --request GET --header "PRIVATE-TOKEN: $GITLAB_TOKEN_FOR_CI" "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/pipelines/${PIPELINE_ID}/jobs?scope=failed")
        APPROVE_JOB_ID=$(jq -r '.[] | select(.name=="approval:check") | .id' <<<"$JOBS_JSON")
        echo "PIPELINE_ID=$PIPELINE_ID, APPROVE_JOB_ID=$APPROVE_JOB_ID"
        curl --insecure --silent --request POST --header "PRIVATE-TOKEN: $GITLAB_TOKEN_FOR_CI" "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/jobs/${APPROVE_JOB_ID}/retry"
      fi
    fi
  done
