HERE=$(dirname $BASH_SOURCE)

mkdir -p /etc/yum.repos.d/backup
mv /etc/yum.repos.d/Rocky-*.repo /etc/yum.repos.d/backup

repos="
AppStream
BaseOS
extras
PowerTools
"

for repo in $repos; do
	dnf config-manager --add-repo https://ftp.kaist.ac.kr/rocky-linux/8/$repo/x86_64/os
done

wget https://ftp.kaist.ac.kr/rocky-linux/RPM-GPG-KEY-Rocky-8 -o $HERE/data/rocky8.gpg
rpm --import $HERE/data/rocky8.gpg
