#!/bin/bash

####################################################################################################
#
# Variables
#
####################################################################################################
dialog="/usr/local/bin/dialog" # Path to dialog app
dialog_command_file="/var/tmp/dialog.log"

function dialog_command(){
  echo "$1"
  echo "$1"  >> $dialog_command_file
}
function Installdialog() {
	gitusername="bartreardon"
	gitreponame="swiftDialog"
	appNewVersion=$(curl --silent --fail "https://api.github.com/repos/$gitusername/$gitreponame/releases/latest" | grep tag_name | cut -d '"' -f 4 | sed 's/[^0-9\.]//g')
	if [ -z "$appNewVersion" ]; then
		echo "could not retrieve version number for $gitusername/$gitreponame"
		appNewVersion=""
	else
		/bin/echo "Dialog WebSite Version: $appNewVersion"
	fi
	if ! test -d "${dialogAppLocation}"; then # Look to see if the Dialog App is Installed
		echo "Dialog App is not Installed"
		localDialogVersion="0.1"
	else
		localDialogVersion=$(dialog -v) # uses dialog variable set at top of Script
		/bin/echo "Dialog Local Version: $localDialogVersion"
	fi
	if [ ! "(dialog)" ] || [ "$localDialogVersion" != "$appNewVersion" ]; then # Check to See if Dialog is Installed and the Current Version
		## Variables for Dialog download
		expectedTeamID="PWA5E9TQ59"
		archiveName="/private/tmp/dialog.pkg"
		downloadURL=$(curl --silent --fail "https://api.github.com/repos/$gitusername/$gitreponame/releases/latest"| awk -F '"' "/browser_download_url/ { print \$4; exit }")
		/bin/echo "Current Dialog version is $localDialogVersion. The latest is $appNewVersion"
		if [[ "$localDialogVersion" == "$appNewVersion" ]]; then
			/bin/echo "Latest verison of Dialog installed"
		else
			/bin/echo "Dialog is either not installed or is not the latest version, downloading"
			if ! curl --silent -L --fail "$downloadURL" -o "$archiveName"; then ## Download Dialog
				/bin/echo "Error downloading $downloadURL"
				/bin/echo "Dialog download failed."
				if test -f "$archiveName"; then
					/bin/rm -f "$archiveName"
				fi
				Exit_Process 190
			fi
			if ! spctlout=$(spctl -a -vv -t install "$archiveName" 2>&1 ); then
				/bin/echo "Error verifying $archiveName"
				if test -f "$archiveName"; then
					/bin/rm -f "$archiveName"
				fi
				Exit_Process 191
			else
				teamID=$(/bin/echo "$spctlout" | awk -F '(' '/origin=/ {print $2 }' | tr -d '()' ) ## Check to make sure it's a valid PKG from the creator
				/bin/echo "Downloaded PKG Team ID: $teamID / Expected Team ID: $expectedTeamID"
				if [ "$expectedTeamID" != "$teamID" ]; then
					/bin/echo "Team IDs do not match"
					if test -f "$archiveName"; then
						/bin/rm -f "$archiveName"
					fi
					Exit_Process 192
				fi
			fi
			if ! installer -pkg "$archiveName" -tgt "/"; then ## Install Dialog
				/bin/echo  "Error installing $archiveName"
				if test -f "$archiveName"; then
					/bin/rm -f "$archiveName"
				fi
				Exit_Process 193
			else
				/bin/echo "Dialog Installed."
				if test -f "$archiveName"; then
					/bin/rm -f "$archiveName"
					/bin/echo "Dialog Installer Removed"
				fi
			fi
		fi
	else
		echo "Dialog Installed, Moving on..."
	fi
}
Installdialog

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Important Variables
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

ORG_NAME="Your Organization Name"
ICON_LOGO="/Library/Application Support/JAMF/Jamf.app/Contents/Resources/AppIcon.icns"
MESSAGE="What is your site?"
START_MESSAGE="Imaging in proccess please wait "
JAMFCOMMAND="/usr/local/bin/jamf policy -trigger"
currentUser=$(scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }')

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# For each configuration step (i.e., app to be installed), enter a pipe-separated list of:
# Display Name  -f1 | Filepath for validation -f2 | Jamf Pro Policy Custom Event Name  -f3| Icon hash -f4
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#Change -f3 for specific office 

siteapps=(
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
)

siteapps1=(
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    )
siteapps2=(
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    )
siteapps3=(
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    )
siteapps4=(
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    )
siteapps5=(
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash")
siteapps6=(
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash")
siteapps7=(
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash")

siteapps8=(
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    "App Name for display |/Applications/location|Custom Trigger|Jamf icon Hash"
    )

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Site Variables
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

siteMESSAGE="Starting Image Proccess for site 

This Proccess can take anywhere from 35 - 45 min to complete

Please be patient...
"

site1MESSAGE="Starting Image Proccess for site1

This Proccess can take anywhere from 35 - 45 min to complete

Please be patient...
"

site2MESSAGE="Starting Image Proccess for site2 

This Proccess can take anywhere from 35 - 45 min to complete

Please be patient...
"
site3MESSAGE="Starting Image Proccess for site3

This Proccess can take anywhere from 35 - 45 min to complete

Please be patient...
"

site4MESSAGE="Starting Image Proccess for site4

This Proccess can take anywhere from 35 - 45 min to complete

Please be patient...
"

site5MESSAGE="Starting Image Proccess for site5 

This Proccess can take anywhere from 35 - 45 min to complete

Please be patient...
"
site6MESSAGE="Starting Image Proccess for site6 

This Proccess can take anywhere from 35 - 45 min to complete

Please be patient...
"

site7MESSAGE="Starting Image Proccess for site7 

This Proccess can take anywhere from 35 - 45 min to complete

Please be patient...
"

site8MESSAGE="Starting Image Proccess for site8 

This Proccess can take anywhere from 35 - 45 min to complete

Please be patient...
"


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Initial Dialog Window 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

runDialog () {
    ${dialog} \
            --title "$ORG_NAME" \
            --alignment "center" \
            --centericon true \
            --iconsize "250" \
            --messagefont "size=16" \
            --icon '/Library/Application Support/JAMF/Jamf.app/Contents/Resources/AppIcon.icns' \
            --message  "Please select your site to begin Imaging" bold \
            --selectvalues site,site1,site2,site3,site4,site5,site6,site7,site8 \
            --selecttitle "Select Your Office" \
            --selectdefault site \
            --button1text Start \
            --button2text Cancel \
            --button2action "exit 0" \         
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Set Overlay Icon based on Self Service icon
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

overlayicon="/Library/Application Support/JAMF/Jamf.app/Contents/Resources/AppIcon.icns"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Finalise app installations
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

function finalise(){
  dialog_command "icon: SF=checkmark.circle.fill,weight=bold,colour1=#00ff44,colour2=#075c1e"
  dialog_command "progresstext: Installation of applications complete."
  sleep 5
  dialog_command "icon: https://ics.services.jamfcloud.com/icon/hash_90958d0e1f8f8287a86a1198d21cded84eeea44886df2b3357d909fe2e6f1296"
  dialog_command "progresstext: Updating computer inventory …"
  dialog_command "icon: SF=checkmark.seal.fill,weight=bold,colour1=#00ff44,colour2=#075c1e"
  dialog_command "progresstext: Complete"
  dialog_command "progress: complete"
  dialog_command "button1text: Done"
  dialog_command "button1: enable"
  exit 0
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Check for app installation
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

function appCheck(){
    if  [ -e "$(echo "$app" | cut -d '|' -f2)" ]; then
        dialog_command "listitem: $(echo "$app" | cut -d '|' -f1): success"
    else
        dialog_command "listitem: title: $(echo "$app" | cut -d '|' -f1), status: fail, statustext: Failed"
    fi
    dialog_command "progress: increment"
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Create the list of apps
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
listitems=""
for app in "${siteapps[@]}"; do
  listitems="$listitems --listitem '$(echo "$app" | cut -d '|' -f1)'"
done

site1listitems=""
for $app in "${siteapps1[@]}"; do
  site1listitems="$site1listitems --listitem '$(echo "$app" | cut -d '|' -f1)'"
done

site2listitems=""
for app in "${siteapps2[@]}"; do
  site2listitems="$site2listitems --listitem '$(echo "$app" | cut -d '|' -f1)'"
done

site3listitems=""
for app in "${site3pp[@]}"; do
  site3listitems="$site3listitems --listitem '$(echo "$app" | cut -d '|' -f1)'"
done

site4listitems=""
for app in "${siteapps4[@]}"; do
  site4listitems="$site4listitems --listitem '$(echo "$app" | cut -d '|' -f1)'"
done

site5listitems=""
for app in "${siteapps5[@]}"; do
  site5listitems="$site5listitems --listitem '$(echo "$app" | cut -d '|' -f1)'"
done

site6listitems=""
for  app in "${siteapps6[@]}"; do
   site6listitems="$ site6listitems --listitem '$(echo "$app" | cut -d '|' -f1)'"
done

site7listitems=""
for app in "${siteapps7[@]}"; do
  site7listitems="$site7listitems --listitem '$(echo "$app" | cut -d '|' -f1)'"
done

site8listitems=""
for app in "${siteapps8[@]}"; do
  site8listitems="$site8listitems --listitem '$(echo "$app" | cut -d '|' -f1)'"
done

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Start of Proccess
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
SELECTION=$(eval "runDialog"| grep "SelectedOption" | awk -F ": " '{print $NF}')

case "$SELECTION" in
   "site") echo "Starting Image Proccess for site" 
        dialog -t --title "$ORG_NAME"  --alignment "center"  --centericon true  --iconsize "250"  --messagefont size=16,bold  --icon "$ICON_LOGO"  --button1text Start --message  "$siteMESSAGE" ;
       
        dialogCMD="$dialog -p --title \"${ORG_NAME}\" \
                --message \"${START_MESSAGE}\" \
                --icon \"$ICON_LOGO\" \
                --progress $progress_total \
                --button1text \"Please Wait\" \
                --button1disabled \
                --ontop \
                --"$listitems" \
                --overlayicon \"$overlayicon\" \
                --titlefont 'size=28' \
                --messagefont 'size=14' \
                --quitkey b"

        eval "$dialogCMD" &
            sleep 2
            
    for app in "${siteapps[@]}"; do
        dialog_command "listitem: title: $(echo "$siteapps" | cut -d '|' -f1), status: wait, statustext: Pending"
    done

    (for app in "${siteapps[@]}"; do
        dialog_command "icon: https://ics.services.jamfcloud.com/icon/hash_$(echo "$app" | cut -d '|' -f4)"
        dialog_command "listitem: title: $(echo "$app" | cut -d '|' -f1), status: pending, statustext: Installing"
        dialog_command "progresstext: Installing $(echo "$app" | cut -d '|' -f1) … this will take some time"
        /usr/local/bin/jamf policy -event "$(echo "$app" | cut -d '|' -f3 )" -verbose
        appCheck &
    done

    wait)
  
    finalise
   ;;
   "site1") echo "Starting Image Proccess for site1" 
        dialog -t  --title "$ORG_NAME"  --alignment "center"  --centericon true  --iconsize "250"  --messagefont size=16,bold  --icon "$ICON_LOGO"  --button1text Start --message  "$site1MESSAGE"
        dialogCMD="$dialog -p --title \"${ORG_NAME}\" \
                --message \"${START_MESSAGE}\" \
                --icon \"$ICON_LOGO\" \
                --progress $progress_total \
                --button1text \"Please Wait\" \
                --button1disabled \
                --ontop \
                --"$site1listitems" \
                --overlayicon \"$overlayicon\" \
                --titlefont 'size=28' \
                --messagefont 'size=14' \
                --quitkey b"

        eval "$dialogCMD" &
            sleep 2
            
    for app in "${siteapps1[@]}"; do
        dialog_command "listitem: title: $(echo "$app" | cut -d '|' -f1), status: wait, statustext: Pending"
    done

    (for app in "${siteapps1[@]}"; do
        dialog_command "icon: https://ics.services.jamfcloud.com/icon/hash_$(echo "$app" | cut -d '|' -f4)"
        dialog_command "listitem: title: $(echo "$app" | cut -d '|' -f1), status: pending, statustext: Installing"
        dialog_command "progresstext: Installing $(echo "$app" | cut -d '|' -f1) … this will take some time"
        /usr/local/bin/jamf policy -event "$(echo "$app" | cut -d '|' -f3 )" -verbose
        siteapps1Check &
    done

    wait)

    finalise
   ;;
   "site2") echo "Starting Image Proccess for site2" 
        dialog -t  --title "$ORG_NAME"  --alignment "center"  --centericon true  --iconsize "250"  --messagefont size=16,bold  --icon "$ICON_LOGO"  --button1text Start --message  "$site2MESSAGE"
        dialogCMD="$dialog -p --title \"${ORG_NAME}\" \
                --message \"${START_MESSAGE}\" \
                --icon \"$ICON_LOGO\" \
                --progress $progress_total \
                --button1text \"Please Wait\" \
                --button1disabled \
                --ontop \
                --"$site2listitems" \
                --overlayicon \"$overlayicon\" \
                --titlefont 'size=28' \
                --messagefont 'size=14' \
                --quitkey b"

        eval "$dialogCMD" &
            sleep 2
            
    ffor app in "${siteapps2[@]}"; do
        dialog_command "listitem: title: $(echo "$app" | cut -d '|' -f1), status: wait, statustext: Pending"
    done

    (for app in "${siteapps2[@]}"; do
        dialog_command "icon: https://ics.services.jamfcloud.com/icon/hash_$(echo "$app" | cut -d '|' -f4)"
        dialog_command "listitem: title: $(echo "$app" | cut -d '|' -f1), status: pending, statustext: Installing"
        dialog_command "progresstext: Installing $(echo "$app" | cut -d '|' -f1) … this will take some time"
        /usr/local/bin/jamf policy -event "$(echo "$app" | cut -d '|' -f3 )" -verbose
        siteapps1Check &
    done

    wait)

    finalise
   ;;
   "site3") echo "Starting Image Proccess for site3" 
        dialog -t  --title "$ORG_NAME"  --alignment "center"  --centericon true  --iconsize "250"  --messagefont size=16,bold  --icon "$ICON_LOGO"  --button1text Start --message  "$site3MESSAGE"
        dialogCMD="$dialog -p --title \"${ORG_NAME}\" \
                --message \"${START_MESSAGE}\" \
                --icon \"$ICON_LOGO\" \
                --progress $progress_total \
                --button1text \"Please Wait\" \
                --button1disabled \
                --ontop \
                --"$site3listitems" \
                --overlayicon \"$overlayicon\" \
                --titlefont 'size=28' \
                --messagefont 'size=14' \
                --quitkey b"

        eval "$dialogCMD" &
            sleep 2
            
    for app in "${siteapps3[@]}"; do
        dialog_command "listitem: title: $(echo "$app" | cut -d '|' -f1), status: wait, statustext: Pending"
    done

    (for app in "${siteapps3[@]}"; do
        dialog_command "icon: https://ics.services.jamfcloud.com/icon/hash_$(echo "$app" | cut -d '|' -f4)"
        dialog_command "listitem: title: $(echo "$app" | cut -d '|' -f1), status: pending, statustext: Installing"
        dialog_command "progresstext: Installing $(echo "$app" | cut -d '|' -f1) … this will take some time"
        /usr/local/bin/jamf policy -event "$(echo "$app" | cut -d '|' -f3 )" -verbose
        siteapps1Check &
    done

    wait)

    finalise
   ;;
   "site4") echo "Starting Image Proccess for site5" 
        dialog -t  --title "$ORG_NAME"  --alignment "center"  --centericon true  --iconsize "250"  --messagefont size=16,bold  --icon "$ICON_LOGO"  --button1text Start --message  "$site4MESSAGE"
        dialogCMD="$dialog -p --title \"${ORG_NAME}\" \
                --message \"${START_MESSAGE}\" \
                --icon \"$ICON_LOGO\" \
                --progress $progress_total \
                --button1text \"Please Wait\" \
                --button1disabled \
                --ontop \
                --"$site4listitems" \
                --overlayicon \"$overlayicon\" \
                --titlefont 'size=28' \
                --messagefont 'size=14' \
                --quitkey b"

        eval "$dialogCMD" &
            sleep 2
            
    for app in "${siteapps4[@]}"; do
        dialog_command "listitem: title: $(echo "$app" | cut -d '|' -f1), status: wait, statustext: Pending"
    done

    (for app in "${siteapps4[@]}"; do
        dialog_command "icon: https://ics.services.jamfcloud.com/icon/hash_$(echo "$app" | cut -d '|' -f4)"
        dialog_command "listitem: title: $(echo "$app" | cut -d '|' -f1), status: pending, statustext: Installing"
        dialog_command "progresstext: Installing $(echo "$app" | cut -d '|' -f1) … this will take some time"
        /usr/local/bin/jamf policy -event "$(echo "$app" | cut -d '|' -f3 )" -verbose
        siteapps1Check &
    done

    wait)

    finalise
   ;;
   "site5") echo "Starting Image Proccess for site7" 
        dialog -t  --title "$ORG_NAME"  --alignment "center"  --centericon true  --iconsize "250"  --messagefont size=16,bold  --icon "$ICON_LOGO"  --button1text Start --message  "$site5MESSAGE"
        dialogCMD="$dialog -p --title \"${ORG_NAME}\" \
                --message \"${START_MESSAGE}\" \
                --icon \"$ICON_LOGO\" \
                --progress $progress_total \
                --button1text \"Please Wait\" \
                --button1disabled \
                --ontop \
                --"$site5listitems" \
                --overlayicon \"$overlayicon\" \
                --titlefont 'size=28' \
                --messagefont 'size=14' \
                --quitkey b"

        eval "$dialogCMD" &
            sleep 2
            
    for app in "${siteapps5[@]}"; do
        dialog_command "listitem: title: $(echo "$app" | cut -d '|' -f1), status: wait, statustext: Pending"
    done

    (for app in "${siteapps5[@]}"; do
        dialog_command "icon: https://ics.services.jamfcloud.com/icon/hash_$(echo "$app" | cut -d '|' -f4)"
        dialog_command "listitem: title: $(echo "$app" | cut -d '|' -f1), status: pending, statustext: Installing"
        dialog_command "progresstext: Installing $(echo "$app" | cut -d '|' -f1) … this will take some time"
        /usr/local/bin/jamf policy -event "$(echo "$app" | cut -d '|' -f3 )" -verbose
        siteapps1Check &
    done

    wait)

    finalise
   ;;
   "site6") echo "Starting Image Proccess for site5" 
        dialog -t  --title "$ORG_NAME"  --alignment "center"  --centericon true  --iconsize "250"  --messagefont size=16,bold  --icon "$ICON_LOGO"  --button1text Start --message  "$site6MESSAGE"
        dialogCMD="$dialog -p --title \"${ORG_NAME}\" \
                --message \"${START_MESSAGE}\" \
                --icon \"$ICON_LOGO\" \
                --progress $progress_total \
                --button1text \"Please Wait\" \
                --button1disabled \
                --ontop \
                --"$site6listitems" \
                --overlayicon \"$overlayicon\" \
                --titlefont 'size=28' \
                --messagefont 'size=14' \
                --quitkey b"

        eval "$dialogCMD" &
            sleep 2
            
    for app in "${siteapps6[@]}"; do
        dialog_command "listitem: title: $(echo "$app" | cut -d '|' -f1), status: wait, statustext: Pending"
    done

    (for app in "${siteapps6[@]}"; do
        dialog_command "icon: https://ics.services.jamfcloud.com/icon/hash_$(echo "$app" | cut -d '|' -f4)"
        dialog_command "listitem: title: $(echo "$app" | cut -d '|' -f1), status: pending, statustext: Installing"
        dialog_command "progresstext: Installing $(echo "$app" | cut -d '|' -f1) … this will take some time"
        /usr/local/bin/jamf policy -event "$(echo "$app" | cut -d '|' -f3 )" -verbose
        siteapps1Check &
    done

    wait)

   finalise
   ;;
   "site7") echo "Starting Image Proccess for site6" 
        dialog -t  --title "$ORG_NAME"  --alignment "center"  --centericon true  --iconsize "250"  --messagefont size=16,bold  --icon "$ICON_LOGO"  --button1text Start --message  "$site7MESSAGE"
        dialogCMD="$dialog -p --title \"${ORG_NAME}\" \
                --message \"${START_MESSAGE}\" \
                --icon \"$ICON_LOGO\" \
                --progress $progress_total \
                --button1text \"Please Wait\" \
                --button1disabled \
                --ontop \
                --"$site7listitems" \
                --overlayicon \"$overlayicon\" \
                --titlefont 'size=28' \
                --messagefont 'size=14' \
                --quitkey b"

        eval "$dialogCMD" &
            sleep 2
            
    for app in "${siteapps7[@]}"; do
        dialog_command "listitem: title: $(echo "$app" | cut -d '|' -f1), status: wait, statustext: Pending"
    done

    (for app in "${siteapps7[@]}"; do
        dialog_command "icon: https://ics.services.jamfcloud.com/icon/hash_$(echo "$app" | cut -d '|' -f4)"
        dialog_command "listitem: title: $(echo "$app" | cut -d '|' -f1), status: pending, statustext: Installing"
        dialog_command "progresstext: Installing $(echo "$app" | cut -d '|' -f1) … this will take some time"
        /usr/local/bin/jamf policy -event "$(echo "$app" | cut -d '|' -f3 )" -verbose
        siteapps1Check &
    done

    wait)

    site6finalise
   ;;
   "site8") echo "Starting Image Proccess for site8" 
        dialog -t  --title "$ORG_NAME"  --alignment "center"  --centericon true  --iconsize "250"  --messagefont size=16,bold  --icon "$ICON_LOGO"  --button1text Start --message  "$site8MESSAGE"
        dialogCMD="$dialog -p --title \"${ORG_NAME}\" \
                --message \"${START_MESSAGE}\" \
                --icon \"$ICON_LOGO\" \
                --progress $progress_total \
                --button1text \"Please Wait\" \
                --button1disabled \
                --ontop \
                --"$site8listitems" \
                --overlayicon \"$overlayicon\" \
                --titlefont 'size=28' \
                --messagefont 'size=14' \
                --quitkey b"

        eval "$dialogCMD" &
            sleep 2
            
    for app in "${siteapps8[@]}"; do
        dialog_command "listitem: title: $(echo "$app" | cut -d '|' -f1), status: wait, statustext: Pending"
    done

    (for app in "${siteapps8[@]}"; do
        dialog_command "icon: https://ics.services.jamfcloud.com/icon/hash_$(echo "$app" | cut -d '|' -f4)"
        dialog_command "listitem: title: $(echo "$app" | cut -d '|' -f1), status: pending, statustext: Installing"
        dialog_command "progresstext: Installing $(echo "$app" | cut -d '|' -f1) … this will take some time"
        /usr/local/bin/jamf policy -event "$(echo "$app" | cut -d '|' -f3 )" -verbose
        siteapps1Check &
    done

    wait)

    finalise
   ;;

esac



exit 0
