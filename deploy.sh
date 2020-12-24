#!/bin/sh

# If a command fails then the deploy stops
set -e
rm -rf public

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Build the project.
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

# Gi push on to original
git add .
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"
git push origin main

printf "\033[0;32mAdding to Github pages...\033[0m\n"
# Go To Public folder
cp -r public/* ../kohtaroyamakawa.github.io
cd ../kohtaroyamakawa.github.io
# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin main
