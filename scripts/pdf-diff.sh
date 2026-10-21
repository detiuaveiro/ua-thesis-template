#!/bin/sh
# Usage: pdf-diff.sh OLD.pdf NEW.pdf OUTDIR
# Writes a text diff and highlighted PNGs of the pages that changed.
set -u
OLD="$1"; NEW="$2"; OUT="$3"
TMP=$(mktemp -d)
mkdir -p "$OUT/pages"

pdftotext -layout "$OLD" "$TMP/old.txt"
pdftotext -layout "$NEW" "$TMP/new.txt"
diff -u --label previous --label current "$TMP/old.txt" "$TMP/new.txt" > "$OUT/text-diff.txt"

pdftoppm -r 60 -png "$OLD" "$TMP/old"
pdftoppm -r 60 -png "$NEW" "$TMP/new"

changed=0
for n in "$TMP"/new-*.png; do
	base=$(basename "$n" | sed 's/^new-//')
	o="$TMP/old-$base"
	if [ ! -f "$o" ]; then
		cp "$n" "$OUT/pages/added-$base"
		changed=$((changed + 1))
	elif ! compare -metric AE -fuzz 2% "$o" "$n" "$OUT/pages/changed-$base" >/dev/null 2>&1; then
		changed=$((changed + 1))
	else
		rm -f "$OUT/pages/changed-$base"
	fi
done
for o in "$TMP"/old-*.png; do
	base=$(basename "$o" | sed 's/^old-//')
	[ -f "$TMP/new-$base" ] || { cp "$o" "$OUT/pages/removed-$base"; changed=$((changed + 1)); }
done

{
	echo "Pages changed/added/removed: $changed"
	echo "Lines in text diff: $(grep -c '^[+-][^+-]' "$OUT/text-diff.txt")"
} | tee "$OUT/summary.txt"
rm -rf "$TMP"
