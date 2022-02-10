./init.sh

MRS_DATA=$(makeRequest GET "/merge_requests?state=opened")
log "MRS_DATA=$MRS_DATA"

echo "$MRS_DATA" | jq -r '.[]|[.iid] | @tsv' |
  while IFS=$'\t' read -r MR_ID; do
    MR_DATA=$(makeRequest GET "/merge_requests/${MR_ID}")
    MR_UPVOTES=$(jq -r '.upvotes' <<<"$MR_DATA")
    log "MR_ID=$MR_ID, MR_UPVOTES=$MR_UPVOTES"
    if [ "$MR_UPVOTES" -ge "$(expr ${APPROVAL_CHECKER_UPVOTES_QUANTITY})" ]; then
      PIPELINES_JSON=$(makeRequest GET "/merge_requests/${MR_ID}/pipelines")
      PIPELINE_ID=$(jq -r '.[0] | select(.status=="failed") | .id' <<<"$PIPELINES_JSON")
      if [[ -n "$PIPELINE_ID" ]]; then
        JOBS_JSON=$(makeRequest GET "/pipelines/${PIPELINE_ID}/jobs?scope=failed")
        APPROVE_JOB_ID=$(jq -r '.[] | select(.name=="approval:check") | .id' <<<"$JOBS_JSON")
        log "PIPELINE_ID=$PIPELINE_ID, APPROVE_JOB_ID=$APPROVE_JOB_ID"
        log makeRequest POST "/jobs/${APPROVE_JOB_ID}/retry"
      fi
    fi
  done
