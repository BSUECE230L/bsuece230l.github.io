#!/usr/bin/env bash
set -e

# Usage check
if [ -z "$1" ]; then
  echo "❌ Error: commit message required"
  echo "Usage: ./script.sh \"your commit message\""
  exit 1
fi

COMMIT_MSG="$1"

echo "🔄 Pulling latest changes..."
git pull --rebase

echo "🐍 Running build script..."
python3 build.py

echo "➕ Staging changes..."
git add -A

# Only commit if there are staged changes
if git diff --cached --quiet; then
  echo "ℹ️ No changes to commit."
else
  echo "📝 Committing changes..."
  git commit -m "$COMMIT_MSG"
fi

echo "🚀 Pushing to remote..."
git push

echo "✅ Done!"

