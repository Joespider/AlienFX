[Alienware FX]
[IMPORANT] The following commands must be allowed to run sudo without authentication
	Help Site: https://linuxhandbook.com/sudo-without-password/
	user@computer:~$ sudo alienware_wmi_control.sh *

Files:
	1) alienfx.py			--->	Type: Python Script (GUI)
						Purpose: user interface;
							set light settings

	2) alienfx.sh			--->	Type: Bash Shell Script (alienfx engine)
						Purpose: reading settings;
							writing settings;
							executing settings

	3) alienfx_settings.txt		--->	Type: Text File
						Purpose: alienfx.py read/write file
							alienfx.sh read/write file

	4) AlienwareFX(custom).glade	--->	Type: XML
						Purpose: Python GUI GTK layout

	5) alienware head.png		--->	Type: PNG picture
						Purpose: alienfx.py component

	6) alienfx.png			--->	Type: PNG picture
						Purpose: alienfx.py component

	7) steamlogo.png		--->	Type: PNG picture
						Purpose: alienfx.py component


Usage:
	Run GUI: user@computer:~$ python alienfx.py
	Run Engine: user@computer:~$ ./alienfx.sh execute
		WARNING! This will run both "alien" and "steam" at the same time. There is NO Threading (theading allows processes to run at the same time) and thus may not function as intended.
		WARNING! THIS WILL BE CONTINUOUS
	Test Engine (alien): user@computer:~$ ./alienfx.sh run alien
	Test Engine (steam): user@computer:~$ ./alienfx.sh run steam
	Test Engine (continuous): user@computer:~$ while true; do ./alienfx.sh run steam; done

