#! /bin/bash


passwd="Vnair98#"
presy=$(date +"%Y")
prev=$(( presy - 1 ))
prevy=$(ls /.snapshots/ | grep -o "${prev}")
#echo $prevy
if [ -z $prevy ]
then
	#echo "In Month"
	presm=$(date +"%m")
	prevm=$(( presm - 1 ))
	ls /.snapshots/ | grep -o ".*[${prevm}].*" > del.txt
	for r in $(ls /.snapshots/ | grep -o ".*[${prevm}].*")
	do
		#echo $passwd | sudo -S rm -r /.snapshots/`$r`
		#echo $r
		echo $passwd | sudo -S btrfs subvolume delete /.snapshots/${r}/
	done
else
	for r in $(ls /.snapshots/ | grep -o ".*[${prev}].*" > del.txt)
        do
                #echo $passwd | sudo -S rm -r /.snapshots/`$r`

		echo $passwd | sudo -S btrfs subvolume delete /.snapshots/${r}/
        done
fi

#echo "Creating snapshot root-$(date +"%Y-%m-%d")"

echo $passwd | sudo -S btrfs subvol snapshot / /.snapshots/root-$(date +"%Y-%m-%d")

#echo "Creating snapshot home-$(date +"%Y-%m-%d")"

echo $passwd | sudo -S btrfs subvol snapshot /home /.snapshots/home-$(date +"%Y-%m-%d")
