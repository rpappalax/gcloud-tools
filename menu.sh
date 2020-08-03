
#!/bin/bash

## ----------------------------------
# Step #1: Define variables
# ----------------------------------
STD='\033[0;0;39m'
NONE='\033[00m'
RED='\033[01;31m'
BLUE='\033[01;34m'
 
# ----------------------------------
# Step #2: User defined function
# ----------------------------------
pause(){
  echo
  read -p "Press [Enter] key to continue..." fackEnterKey
  echo
}

cmd_exec(){
        echo
        echo ${MSG} 
        echo -e "\n${BLUE}$ ${CMD}${NONE}\n"
        exec ${CMD}
        pause
}
auth_list(){
        CMD="gcloud auth list"
        MSG="listing accounts whose credentials are stored locally..."
        cmd_exec ${CMD} ${MSG}
}
 
config_list(){
        MSG="listing properties in your active SDK config..."
        CMD="gcloud config list"
        cmd_exec ${CMD} ${MSG}
}

container_activity(){
        echo
        echo "create new container"
        read -p 'enter project name: ' PROJECT 
        read -p 'enter container name: ' CONTAINER
        CMD="gcloud builds submit --tag gcr.io/${PROJECT}/${CONTAINER}" .
        cmd_exec ${CMD} ${MSG}
}

instance_create(){
        echo
        read -p 'enter instance name: ' INSTANCE
        MSG="create new instance: ${INSTANCE}"
        CMD="gcloud compute instances create $INSTANCE"
        cmd_exec ${CMD} ${MSG}
}

instance_activity(){
        echo
        echo "stop | start | delete instance"
        read -p 'enter instance name: ' INSTANCE
        read -p 'enter action (stop|start|delete): ' ACTIVITY 
        MSG="${ACTIVITY} instance: ${INSTANCE}"
        CMD="gcloud compute instances ${ACTIVITY} ${INSTANCE}"
        cmd_exec ${CMD} ${MSG}
}


instance_create_with_container(){
        echo
        read -p 'enter container name: ' CONTAINER
        read -p 'enter container image name: ' IMAGE
        MSG="create new container instance: ${CONTAINER} with container image: ${IMAGE}"
        CMD="gcloud compute instances create-with-container $CONTAINER--container-image=${IMAGE}"
        echo -e "\n${BLUE}$ ${CMD}${NONE}\n"
        exec $CMD
        pause
}
 
# function to display menus
show_menus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~"	
	echo " M A I N - M E N U"
	echo "~~~~~~~~~~~~~~~~~~~~~"
        echo
	echo "0. Exit"
	echo "1. gcloud auth list"
	echo "2. gcloud config list"
	echo "3. gcloud create instance"
        echo "4. gcloud compute instances [start|stop|delete]"
	echo "5. gcloud create instance with container"
}

read_options(){
	local choice
        echo
	read -p "Enter choice [ 0 - 5] " choice
	case $choice in
		1) auth_list ;;
		2) config_list ;;
		3) instance_create;;
		4) instance_activity;;
		5) instance_create_with_container;;
		0) tput sgr0; exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}
 
# ----------------------------------------------
# Step #3: Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------
trap '' SIGINT SIGQUIT SIGTSTP
 
# -----------------------------------
# Step #4: Main logic - infinite loop
# ------------------------------------
while true
do
 
	show_menus
	read_options
done



