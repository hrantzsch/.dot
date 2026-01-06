#!/bin/bash

function main {
  output_name=$1

  while true; do
    sleep 0.5

    niri msg -j workspaces | jq -r --arg output_name "$output_name" '
      .[] |
      select(.output == $output_name) |
      if .is_active then "󰪥" else "󰄰" end
    ' | tr '\n' ' '

    echo
  done
}

main "$1"
