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
