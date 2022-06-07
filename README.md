

# Setup Your Mac via swiftDialog

 Purpose: Leverages swiftDialog v1.10.1 (or later) (https://github.com/bartreardon/swiftDialog/releasesand 
 Jamf Pro Policy Custom Events to allow end-users to self-complete Mac setup post-enrollment
 via Jamf Pro's Self Service. (See Jamf Pro Known Issues PI100009 - PI-004775.)

# Inspired by: Rich Trouton (@rtrouton) and Bart Reardon (@bartreardon)

# Based on: Adam Codega (@adamcodega)'s https://github.com/acodega/dialog-scripts/blob/main/MDMAppsDeploysh


# HISTORY

# Version 0.0.1, 19-Mar-2022, Dan K. Snelson (@dan-snelson)
   Original version

# Version 0.0.2, 20-Mar-2022, Dan K. Snelson (@dan-snelson)
   Corrected initial indeterminate progress bar. (Thanks, @bartreardon!)

# Version 0.0.3, 21-Mar-2022, Dan K. Snelson (@dan-snelson)
   Re-corrected initial indeterminate progress bar.

# Version 0.0.4, 16-Apr-2022, Dan K. Snelson (@dan-snelson)
   Updated for Listview processing https://github.com/bartreardon/swiftDialog/pull/103
   Added dynamic, policy-based icons

# Version 0.0.5, 21-Apr-2022, Dan K. Snelson (@dan-snelson)
   Standardized references to listitem code to more easily leverage statustext
   Simplified "jamf policy -event" code

# Version 0.0.6, 22-Apr-2022, Dan K. Snelson (@dan-snelson)
   Added error-checking to appCheck (thanks for the idea, @@adamcodega!)

# Version 0.1.1, 6-June-2022, Clayton Council (NYC-IHC)
	Customized for FCB Health (IHC-All)
		- Added base64 Image function to tmp folder
		- Message Dialog and Preferences
		- Used a Dropdown to select the specific Site
    - The application array is specific to each Site

