#!/bin/bash

progDir=~/alienfx/

light()
{
	setting=$1
	sudo alienware_wmi_control.sh --led-brightness ${setting}
#	sleep 0.2
}

UseColor()
{
	light=$1
	red=$2
	green=$3
	blue=$4
#	bright=$6
	bright=15
	case ${light} in
		alien)
			sudo alienware_wmi_control.sh head ${red} ${green} ${blue}
			;;
		steam)
			sudo alienware_wmi_control.sh left ${red} ${green} ${blue}
			;;
		brightness)
			sudo alienware_wmi_control.sh --led-brightness ${red}
			echo ${red}
			;;
		*)
			;;
	esac
}


run()
{
	use=$1
	config=$(manage get ${use} | tr ',' ' ')
	UseColor ${config}
}

manage()
{
	action="$1"
	case ${action} in
		get)
			#Grab Data from setting file and reformatting
			config=$(cat ${progDir}alienfx_settings.txt | tr '\n' ',' | sed 's/,,/!/g' | rev | sed 's/,//1' | rev | sed "s/ green//g" | sed "s/ blue//g" | sed "s/ red//g")
			#Assign settings to alien settings
			alien=$(echo ${config} | cut -d "!" -f 1)
			#Assign settings to steam settings
			steam=$(echo ${config} | cut -d "!" -f 2)
			#Assign settings to steam settings
			brightness=$(grep -A 1 brightness ${progDir}alienfx_settings.txt)
			#
			item="$2"
			case ${item} in
				#show alien
				alien)
					echo ${alien}
					;;
				#show steam
				steam)
					echo ${steam}
					;;
				#show brightness
				brightness)
					echo ${brightness}
					;;
				*)
					;;
			esac
			;;
		#save settings
		set)
			alienConf=""
			steamConf=""
			brightnessConf=""
			#Look for Alien
			if [[ "$2" == "alien"* ]]; then
				#format config back for settins
				alienConf=$(echo $2 | sed 's/,/ red,/2' | sed 's/,/ green,/3' | sed 's/,/ blue,/4')
			elif [[ "$3" == "alien"* ]]; then
				#format config back for settins
				alienConf=$(echo $3 | sed 's/,/ red,/2' | sed 's/,/ green,/3' | sed 's/,/ blue,/4')
			elif [[ "$4" == "brightness"* ]]; then
				#format config back for settins
				steamConf=$(echo $4 | sed 's/,/ red,/2' | sed 's/,/ green,/3' | sed 's/,/ blue,/4')
			fi
			#Look for Steam
			if [[ "$2" == "steam"* ]]; then
				#format config back for settins
				steamConf=$(echo $2 | sed 's/,/ red,/2' | sed 's/,/ green,/3' | sed 's/,/ blue,/4')
			elif [[ "$3" == "steam"* ]]; then
				#format config back for settins
				steamConf=$(echo $3 | sed 's/,/ red,/2' | sed 's/,/ green,/3' | sed 's/,/ blue,/4')
			elif [[ "$4" == "brightness"* ]]; then
				#format config back for settins
				steamConf=$(echo $4 | sed 's/,/ red,/2' | sed 's/,/ green,/3' | sed 's/,/ blue,/4')
			fi
			#Look for Brightness
			if [[ "$2" == "brightness"* ]]; then
				#format config back for settins
				brightnessConf=$(echo $2)
			elif [[ "$3" == "brightness"* ]]; then
				#format config back for settins
				brightnessConf=$(echo $3)
			elif [[ "$4" == "brightness"* ]]; then
				#format config back for settins
				brightnessConf=$(echo $4)
			fi
			Settings="${progDir}alienfx_settings.txt"
			#Save config back to settins
			echo ${alienConf} | tr ',' '\n' > ${Settings}
			echo "" >> ${Settings}
			echo ${steamConf} | tr ',' '\n' >> ${Settings}
			echo "" >> ${Settings}
			echo ${brightnessConf} | tr ',' '\n' >> ${Settings}
			;;
		#Nothing to do
		*)
			#Do nothing
			;;
	esac
}

main()
{
	act=$1
	case ${act} in
		get|set)
			manage $@
			;;
		begin)
			${progDir}alienfx.sh run alien
			${progDir}alienfx.sh run steam
			${progDir}alienfx.sh run brightness
			;;
		use|run)
			shift
			run $@
			;;
		*)
			;;
	esac
}

main $@
