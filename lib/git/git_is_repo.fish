function git_is_repo -d "Check if directory is a repository"
  command git rev-parse --git-dir >/dev/null ^/dev/null
end
