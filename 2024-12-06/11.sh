echo "脚本第一个参数是：$1";
case "$1" in
    # List patterns for the conditions you want to meet
    1) echo "python";python 1;;
    2) echo "nodejs";node 11;;
    *) echo "It is not null."; bash 1.sh;;  # match everything
esac

head -n 100 1.html
bash fb.sh >> /dev/null