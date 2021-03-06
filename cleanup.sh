
CONFIG=$1
NETID=$2
ext=".utdallas.edu"


n=1

cat $CONFIG | sed -e "s/#.*//" | sed -e "/^\s*$/d" |
(
read line 
numhosts=$( echo $line | awk '{ print $1 }' ) 

while [[ $n -le numhosts ]] 
do
	read line
	node=$( echo $line | awk '{ print $1 }' )
	hostname=$( echo $line | awk '{ print $2 }' )
	port=$( echo $line | awk '{ print $3 }' )
	echo $hostname
	if [[ $hostname == dc* ]]		
	then
		n=$(( n + 1 ))
		ssh -o StrictHostKeyChecking=no $NETID@$hostname$ext killall -u $NETID &
	fi
	sleep 1
done
)
echo "Cleanup complete"
