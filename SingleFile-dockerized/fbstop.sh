ps -ef | grep filebrowser | awk '{print $2}'|xargs kill
ps -ef | grep dufs| awk '{print $2}'|xargs kill