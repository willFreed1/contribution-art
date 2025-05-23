#!/bin/bash

REPO_URL="https://github.com/willFreed1/contribution-art.git"
REPO_DIR="contribution-art"

# Clone the repository
git clone "$REPO_URL" "$REPO_DIR"
cd "$REPO_DIR" || exit 1

# Matrix for WILLFREED1 (7x49)
declare -a MATRIX=(
  "10101011101000100011110111001111011110111000100"
  "10101001001000100010000100101000010000100101100"
  "10101001001000100010000100101000010000100100100"
  "10101001001000100011110111001110011100100100100"
  "10101001001000100010000101001000010000100100100"
  "10101001001000100010000100101000010000100100100"
  "01010011101110111010000100101111011110111001110"
)

START_DATE="2022-01-02"  # GitHub calendar starts on Sunday

# Loop over matrix properly (0 to 48)
for row in {0..6}; do
  for col in {0..48}; do
    char="${MATRIX[$row]:$col:1}"
    if [[ "$char" == "1" ]]; then
      for i in {1..5}; do
        commit_date=$(date -d "$START_DATE + $((col * 7 + row)) days" +"%Y-%m-%dT12:00:00")
        GIT_AUTHOR_DATE=$commit_date GIT_COMMITTER_DATE=$commit_date \
        git commit --allow-empty -m "Pixel ($col,$row) run $i" > /dev/null
      done
    fi
  done
done

git branch -M main
git push origin main
