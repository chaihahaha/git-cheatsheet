#!/usr/bin/env bash

repo_url=$1
repo_dir=$(basename $repo_url)
checkout_target=HEAD

git clone --filter=blob:none --no-checkout $repo_url $repo_dir
cd $repo_dir
git fetch

git ls-tree -r --name-only $checkout_target > repo_structure.txt
git config core.sparseCheckout false

echo "Now will checkout remote file by file..."

# Read the file list incrementally
file_list="repo_structure.txt"
i=0

while read -r file; do
    ((i++))
    echo "Checking out $i files: $file"

    # Checkout the selected files incrementally
    git checkout "$checkout_target" "$file"

    
done < "$file_list"
