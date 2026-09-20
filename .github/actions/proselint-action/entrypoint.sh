#!/bin/sh -l
echo "Running proselint on .md files..."
# 查找当前目录及子目录下所有的 .md 文件并运行 proselint
find . -name "*.md" -not -path "./venv/*" -exec proselint {} +
