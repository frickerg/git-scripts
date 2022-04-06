cd C:/dev/jenga3
rm C:/dev/git-scripts/output/branches_older_than_a_year.txt

for branch in $(git branch -a | sed 's/^\s*//' | sed 's/^remotes\///' | grep -v 'main$\|develop$'); do
  if ! ( [[ -f "$branch" ]] || [[ -d "$branch" ]] ) && [[ "$(git log $branch --since "1 year ago" | wc -l)" -eq 0 ]]; then
    local_branch_name=$(echo "$branch" | sed 's/remotes\/origin\///')
    echo "${local_branch_name}" | tee -a C:/dev/git-scripts/output/branches_older_than_a_year.txt
  fi
done
