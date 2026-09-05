# Invoked by the Nix-generated wrapper; can also be run with bash for testing.
set -euo pipefail
export LC_ALL=C

profile="${1:-/nix/var/nix/profiles/system}"
keep="${2:-3}"

if [[ ! "$keep" =~ ^[1-9][0-9]*$ ]]; then
  echo "Generation count must be a positive integer." >&2
  exit 2
fi

# A first installation may not have created the system profile yet.
[[ -e "$profile" ]] || exit 0

# Serialise activation and scheduled cleanup for this profile.
exec 9>"$profile.retention.lock"
flock -x 9

generation_list=$(nix-env --profile "$profile" --list-generations)
current=$(awk '$NF == "(current)" { print $1 }' <<< "$generation_list")
if [[ ! "$current" =~ ^[0-9]+$ ]]; then
  echo "Cannot identify the current generation; nothing deleted." >&2
  exit 1
fi

mapfile -t generations < <(awk 'NF { print $1 }' <<< "$generation_list" | sort -rn)
remaining=$((keep - 1))
remove=()

for generation in "${generations[@]}"; do
  if [[ ! "$generation" =~ ^[0-9]+$ ]]; then
    echo "Unexpected generation listing; nothing deleted." >&2
    exit 1
  fi
  [[ "$generation" == "$current" ]] && continue
  if (( remaining > 0 )); then
    remaining=$((remaining - 1))
  else
    remove+=("$generation")
  fi
done

if (( ${#remove[@]} > 0 )); then
  # nix-env also refuses to delete a generation that became current meanwhile.
  nix-env --profile "$profile" --delete-generations "${remove[@]}"
fi
