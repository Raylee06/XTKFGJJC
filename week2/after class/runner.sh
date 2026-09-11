#!/usr/bin/env bash

TARGET_SCRIPT="./test_script.sh"
STDOUT_FILE="stdout.log"
STDERR_FILE="stderr.log"
TEMP_OUT=$(mktemp)
TEMP_ERR=$(mktemp)
COUNT=0

cleanup() {
    rm -f "$TEMP_OUT" "$TEMP_ERR"
}
trap cleanup EXIT INT TERM

if [ ! -f "$TARGET_SCRIPT" ]; then
    cat > "$TARGET_SCRIPT" << 'EOF'
#!/usr/bin/env bash

n=$(( RANDOM % 100 ))

if [[ n -eq 42 ]]; then
    echo "Something went wrong"
    >&2 echo "The error was using magic numbers"
    exit 1
fi

echo "Everything went according to plan"
EOF
    chmod +x "$TARGET_SCRIPT"
fi

> "$STDOUT_FILE"
> "$STDERR_FILE"

echo "Running until failure..."
START_TIME=$(date +%s)

while true; do
    COUNT=$((COUNT + 1))
    
    "$TARGET_SCRIPT" > "$TEMP_OUT" 2> "$TEMP_ERR"
    EXIT_CODE=$?
    
    cat "$TEMP_OUT" >> "$STDOUT_FILE"
    cat "$TEMP_ERR" >> "$STDERR_FILE"
    
    if [ $EXIT_CODE -ne 0 ]; then
        END_TIME=$(date +%s)
        ELAPSED=$((END_TIME - START_TIME))
        
        echo ""
        echo "=========================================="
        echo "Script FAILED after $COUNT runs!"
        echo "=========================================="
        echo "Exit code: $EXIT_CODE"
        echo "Time elapsed: ${ELAPSED}s"
        echo ""
        echo "--- Standard Output ---"
        cat "$TEMP_OUT"
        echo ""
        echo "--- Standard Error ---"
        cat "$TEMP_ERR"
        echo ""
        echo "Logs saved to:"
        echo "  STDOUT: $STDOUT_FILE ($(wc -l < "$STDOUT_FILE") lines)"
        echo "  STDERR: $STDERR_FILE ($(wc -l < "$STDERR_FILE") lines)"
        echo "=========================================="
        
        cleanup
        exit 0
    fi
    
    if [ $((COUNT % 50)) -eq 0 ]; then
        echo -ne "\rRuns: $COUNT | Still running..."
    fi
done
