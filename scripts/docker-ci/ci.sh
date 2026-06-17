#!/bin/bash -l
export KYNEMA_COMMIT=$(curl --request GET --url "https://api.github.com/repos/kynema/kynema-manager/commits/main" | jq -r '.sha')
./generate-snapshot-image.sh $KYNEMA_COMMIT
