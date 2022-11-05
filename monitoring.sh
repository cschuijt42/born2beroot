echo -n "#Architecture: "
uname -a

echo -n "#Physical CPUs: "
nproc --all

echo -n "#vCPUs: "
cat /proc/cpuinfo | grep processor | wc -l

echo -n "#Memory Usage: "
free --mega | grep 'Mem:' | awk '{printf ("%d MB free, %d MB total (%.2f%%)", $2, $4, $2/$4*100)}'

echo -n "#Disk Usage (/): "
df -h | grep 'cschuijt42--vg-root' | awk '{printf ("%s used of %s (%.2f%%)", $3, $2, $5)}' 
echo -n "#Disk Usage (/home): "
df -h | grep 'cschuijt42--vg-home' | awk '{printf ("%s used of %s (%.2f%%)", $3, $2, $5)}' 

echo -n "#CPU Load: "
mpstat | grep 'all' | awk '{printf("%.2f%%\n", 100-$13)}'

echo -n "#Last boot: "
who -b | awk '{print ($3, "at", $4)}'

echo -n "#LVM Use: "
if [[cat /etc/fstab | grep 'root' == /dev/mapper* ]]
then
echo "yes"
else
echo "no"
fi

echo -n "#TCP Connections established: "
ss -s | grep 'TCP:' | awk '{printf ("%d\n", $4)}'

echo -n "#Users logged in: "
who | wc -l

echo -n "#Network IP: "
hostname -I

echo -n "#Network MAC: "
ip addr | grep 'link/ether' | awk '{print ($2)}'

echo -n "#Sudo commands: "
grep 'sudo' /var/log/auth.log | grep 'COMMAND' | wc -l
