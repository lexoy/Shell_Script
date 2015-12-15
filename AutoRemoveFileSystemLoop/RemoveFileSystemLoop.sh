#! /bin/bash

#######################################################################
# This Shell Script Remove Linux File System loop Automation.
# file system loop exist
#.
#├── a
#│   ├── a_r -> .
#│   ├── a_r1 -> .
#│   ├── a_r2 -> .
#│   ├── b
#│   │   ├── b_r -> .
#│   │   ├── b_r0 -> .
#│   │   ├── b_r1 -> .
#│   │   ├── b_r2 -> .
#│   │   ├── b_r3 -> .
#│   │   ├── b_r4 -> .
#│   │   ├── b_r5 -> .
#│   │   └── b_r6 -> .
#│   ├── file_a
#│   └── my_file -> file_a
#└── RemoveFileSystemLoop.sh
##
##
# after this script
#.
#├── a
#│   ├── b
#│   ├── file_a
#│   └── my_file -> file_a
#└── RemoveFileSystemLoop.sh
#######################################################################

function Check()
{
	var=$(ls -l $1)
	split=${var:${#var}-1}
	if [ $split = "." ]; then
		Delete $(ls $1)
	fi
}

function Delete()
{
	rm -vrf $1
}

function Iterator()
{
	for x in $(ls)
	do
		if [ -L "$x" ]; then
			Check $x
		elif [ -d "$x" ]; then
			cd "$x"
			Iterator
			cd ..
		else
			echo "$x"
		fi
	done		
}

Iterator
