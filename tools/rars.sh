#!/bin/sh
set -eu

tools_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
rars_java=${RARS_JAVA:-}
if [ -z "$rars_java" ]; then
    for candidate in "$tools_dir"/.runtime/*/Contents/Home/bin/java; do
        if [ -x "$candidate" ]; then
            rars_java=$candidate
            break
        fi
    done
fi
if [ -z "$rars_java" ]; then
    rars_java=java
fi
if [ ! -f "$tools_dir/rars.jar" ]; then
    echo "Download RARS 1.6 as tools/rars.jar; see README.md." >&2
    exit 1
fi
exec "$rars_java" -jar "$tools_dir/rars.jar" "$@"
