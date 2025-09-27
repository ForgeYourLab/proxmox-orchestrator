#!/usr/bin/env bash
set -euo pipefail

SUFFIX_REGEX='\.vault\.ya?ml$'
EXIT_STATUS=0

if [ "$#" -eq 0 ]; then
  echo "Warning: No files provided by pre-commit; scanning all tracked files."
  mapfile -t FILES < <(git ls-files | grep -E "$SUFFIX_REGEX" || true)
else
  FILES=("$@")
fi

for FILE in "${FILES[@]}"; do
  [[ "$FILE" =~ $SUFFIX_REGEX ]] || continue
  [[ -f "$FILE" ]] || continue

  if [ ! -s "$FILE" ]; then
    echo "Error: $FILE is empty but ends with .vault.yml/.yaml."
    EXIT_STATUS=1
    continue
  fi

  FIRST_LINE=$(head -n 1 -- "$FILE" || true)

  if [[ "$FIRST_LINE" != \$ANSIBLE_VAULT\;* ]]; then
    echo "Error: $FILE ends with .vault.yml/.yaml but is not Vault-encrypted (missing '\$ANSIBLE_VAULT;' header)."
    EXIT_STATUS=1
  fi
done

exit "$EXIT_STATUS"
