
#!/bin/bash

## ----------------------------------
# gcloud cheat sheet
## ----------------------------------
#https://cloud.google.com/sdk/docs/cheatsheet

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
        eval ${CMD}
}

auth_list(){
        CMD="gcloud auth list"
        MSG="listing accounts whose credentials are stored locally..."
        cmd_exec ${CMD} ${MSG}
        pause
}

projects_list(){
        MSG="gcloud list projects"
        CMD="gcloud projects list"
        cmd_exec ${CMD} ${MSG}
        pause
}

project_set(){
        read -p 'enter project name: ' PROJECT 
        MSG="gcloud config set project"
        CMD="gcloud config set project ${PROJECT}"
        cmd_exec ${CMD} ${MSG}
        pause
}

auth_switch(){
        echo "switch accounts"
        CMD="gcloud auth list"
        MSG="listing accounts whose credentials are stored locally..."
        cmd_exec ${CMD} ${MSG}
        read -p 'enter account name: ' ACCOUNT 
        CMD="gcloud auth login ${ACCOUNT}"
        MSG="switching accounts..."
        cmd_exec ${CMD} ${MSG}
        pause
}
 
config_list(){
        MSG="listing properties in your active SDK config..."
        CMD="gcloud config list"
        cmd_exec ${CMD} ${MSG}
        pause
}

container_activity(){
        echo
        echo "create new container"
        read -p 'enter project name: ' PROJECT 
        read -p 'enter container name: ' CONTAINER
        CMD="gcloud builds submit --tag gcr.io/${PROJECT}/${CONTAINER}" .
        cmd_exec ${CMD} ${MSG}
        pause
}

instance_create(){
        echo
        read -p 'enter instance name: ' INSTANCE
        MSG="create new instance: ${INSTANCE}"
        CMD="gcloud compute instances create $INSTANCE"
        cmd_exec ${CMD} ${MSG}
        pause
}

instance_activity(){
        echo
        echo "stop | start | delete instance"
        read -p 'enter instance name: ' INSTANCE
        read -p 'enter action (stop|start|delete): ' ACTIVITY 
        MSG="${ACTIVITY} instance: ${INSTANCE}"
        CMD="gcloud compute instances ${ACTIVITY} ${INSTANCE}"
        cmd_exec ${CMD} ${MSG}
        pause
}


instance_create_with_container(){
        echo
        read -p 'enter container name: ' CONTAINER
        read -p 'enter container image name: ' IMAGE
        MSG="create new container instance: ${CONTAINER} with container image: ${IMAGE}"
        CMD="gcloud compute instances create-with-container $CONTAINER--container-image=${IMAGE}"
        cmd_exec ${CMD} ${MSG}
        pause
}

instance_ssh(){
        echo
        read -p 'enter instance name: ' INSTANCE
        MSG="gcloud compute ssh - SSH into a virtual machine instance"
        CMD="gcloud compute ssh ${INSTANCE}"
        cmd_exec ${CMD} ${MSG}
        pause
}

instances_list(){
        MSG="listing compute instances..."
        CMD="gcloud compute instances list"
        cmd_exec ${CMD} ${MSG}
        pause
}
 
# function to display menus
show_menus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~"	
	echo " M A I N - M E N U"
	echo "~~~~~~~~~~~~~~~~~~~~~"
        echo
	echo "1. gcloud auth list"
	echo "2. gcloud auth switch" 
	echo "3. gcloud projects list" 
	echo "4. gcloud project set" 
	echo "5. gcloud config list"
	echo "6. gcloud create instance"
        echo "7. gcloud compute instances [start|stop|delete]"
	echo "8. gcloud create instance with container"
	echo "9. gcloud compute instances list"
	echo "10. gcloud compute ssh"
}

read_options(){
	local choice
        echo
	read -p "Enter choice [1-5] or return to exit: " choice
        echo
	case $choice in
		1)  auth_list ;;
		2)  auth_switch;;
		3)  projects_list;;
		4)  project_set;;
		5)  config_list ;;
		6)  instance_create;;
		7)  instance_activity;;
		8)  instance_create_with_container;;
		9)  instances_list;;
		10) instance_ssh;;
		*) tput sgr0; exit 0;;
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



