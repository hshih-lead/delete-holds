#!/bin/bash

# List of hold_ids (update these as needed)
hold_ids=(
'hold_2vT0Lh5S3AKNltMbFVM9P9oLfN8'
)

# Base URL and static parts
url="https://mx3r18ur6c-vpce-0b695dae7de2259b6.execute-api.us-east-1.amazonaws.com/prod/fiserv/v1/cancel_hold"
description="manual delete"
user="ach"
user_type="person"

# Loop through hold_ids
for i in "${!hold_ids[@]}"; do
  hold_id="${hold_ids[$i]}"
  idempotency_key="webull-ghost-$((i + 1))"

  echo "Cancelling hold: $hold_id with Idempotency-Key: $idempotency_key"

  curl "$url" \
    --request POST \
    --header "Idempotency-Key: $idempotency_key" \
    --header "Content-Type: application/json" \
    --data '{
      "hold_id": "'"$hold_id"'",
      "description": "'"$description"'",
      "user": "'"$user"'",
      "user_type": "'"$user_type"'"
    }'

  echo -e "\n---\n"
done