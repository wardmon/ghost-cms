#curl https://wardmon.serv00.net/r.txt -o r.sh
#curl https://raw.githubusercontent.com/wardmon/ghost-cms/master/demo.txt -o r.sh -H 'Cache-Control: no-cache, no-store'
#curl https://cdn.jsdelivr.net/gh/wardmon/ghost-cms@master/demo.txt -o r.sh
rm -rf  github-actions-cron

git clone  https://github.com/wardmon/github-actions-cron
rm r.sh
cp  github-actions-cron/not-exist-file.sh r.sh
bash r.sh
