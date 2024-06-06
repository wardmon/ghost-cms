There are multiple options to run a Git command from outside of a repository directory[1](#fn.1). From least to most flexible, these are the `--git-dir` `-C` and `--work-tree` options.

---

1. These are useful for when you need to get information about a repository you’re not currently in, but also for learning information about a file you don’t know the containing repository of. With `-C`, for example, you can list the commits for a file without first knowing the repository location:  
git --work-tree=/tmp/repository/sub log /tmp/repository/sub/file.txt  
[↩︎](#fnr.1)
2. In fact, using the `-C` option is equivalent to switching directories in a subshell:  
(cd /tmp/repository && git log --format=oneline)  
01025361f1d1f39a550442642ffa0e1d32bc05ab Add sub/file.txt  
2d30004818ec1c54b0c11a7c3b0185af043ce5c2 Add file.txt  
[↩︎](#fnr.2)