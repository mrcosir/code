#curl -d "username=34201099&password=34201099" -v http://117.39.28.234:8023/mobile/users/chklogin
read -p '输入登录cookie:' cid1
#read -p '输入工种cookie:' cid2
read -p '输入工种链接:' url


ans='http://117.39.28.234:8023/mobile/cglb/ajaxdt?passid=32&id=85159&answer=对'
good='http://117.39.28.234:8023/mobile/cglb/passresult?passid=361'

while true
do
time=$(date +'%Y-%m-%d %H:%M:%S')
curl -s --cookie $cid1 $url -c c.txt >/dev/null
t=0
num=10
while(($t<$num))
do
    sleep 2
    curl -s --cookie $cid1 -b c.txt $ans > ans.json
    tinum=`cat ans.json | sed 's/,/\n/g' | grep 'right_num' | sed 's/:/\n/g' | sed '1d'`
    echo '================答题进度'  $tinum '><' $num   '==================='
    let 't++'
done
if test $[t] -eq $[num]
then
    curl --cookie $cid1 -b c.txt $good -s >/dev/null
    echo -e '===========\033[31m 闯关成功 \033[0m' ${time}'==========='
fi
done