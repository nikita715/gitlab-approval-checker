APPROVAL_CHECKER_DEBUG=${APPROVAL_CHECKER_DEBUG:-false}
APPROVAL_CHECKER_UPVOTES_QUANTITY=${APPROVAL_CHECKER_UPVOTES_QUANTITY:-1}

log () {
  if [[ "$APPROVAL_CHECKER_DEBUG" == "true" ]]; then echo "$1" ; fi;
}

makeRequest () {
  curl --silent --request "$1" --header "PRIVATE-TOKEN: $APPROVAL_CHECKER_PRIVATE_TOKEN" "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}$2"
}

parseJson () {
  jq -r "$2" <<< "$1"
}
