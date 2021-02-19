#! /bin/bash


passwd="Vnair98#"
presy=$(date +"%Y")
prev=$(( presy - 1 ))
prevy=$(ls /.snapshots/ | grep -o "${prev}")
if [ -z prevy ]
then
	presm=$(date +"%m")
	prevm=$(( presm - 1 ))
	ls /.snapshots/ | grep -o "${prevm}" > del.txt
	for r in $(ls /.snapshots/ | grep -o "${prevm}" > del.txt)
	do
		#echo $passwd | sudo -S rm -rf /.snapshots/`$r`
		echo $passwd | sudo -S btrfs subvolume delete /.snapshot/`$r`
	done
else
	for r in $(ls /.snapshots/ | grep -o "${prevy}" > del.txt)
        do
                #echo $passwd | sudo -S rm -rf /.snapshots/`$r`

		echo $passwd | sudo -S btrfs subvolume delete /.snapshot/`$r`
        done
fi

echo "Creating snapshot root-$(date +"%Y-%m-%d")"

echo $passwd | sudo -S btrfs subvol snapshot / /.snapshots/root-$(date +"%Y-%m-%d")

