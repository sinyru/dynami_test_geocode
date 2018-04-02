#!/bin/bash

API="${API_ORIGIN:-http://localhost:4741}"
URL_PATH="/locations"
curl "${API}${URL_PATH}" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=$TOKEN" \
  --data '{
    "location": {
      "address": "1600 Amphitheatre Parkway, Mountain View, CA",
      "lat": 37.4224764,
      "lng": -122.0829009197085
    }
  }'

echo
