#!/bin/bash
mkdir -p submission_reminder_app/{app,modules,assets,config}
touch submission_reminder_app/app/reminder.sh
touch submission_reminder_app/modules/functions.sh
touch submission_reminder_app/assets/submissions.txt
touch submission_reminder_app/config/config.env
touch submission_reminder_app/startup.sh
cat << 'EOF' > ./submission_reminder_app/config/config.env
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF
cat << 'EOF' > ./submission_reminder_app/modules/functions.sh
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF
chmod +x ./submission_reminder_app/modules/functions.sh
cat << 'EOF' > ./submission_reminder_app/assets/submissions.txt
student, assignment, submission status
Toyota, Shell Navigation, submitted
Ommy, Shell Navigation, not submitted
Faridah, Shell Navigation, submitted
Fatuma, Shell Navigation, not submitted
Yusilah, Shell Navigation, submitted
Adeline, Shell Navigation, not submitted
Suhaira, shell Navigation, not submitted
EOF
cat << 'EOF' >./submission_reminder_app/app/reminder.sh
#!/bin/bash

# Source environment variables and helper functions
source ./submission_reminder_app/config/config.env
source ./submission_reminder_app/modules/functions.sh

# Path to the submissions file
submissions_file="./submission_reminder_app/assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF
chmod +x ./submission_reminder_app/app/reminder.sh
cat << 'EOF' > ./submission_reminder_app/startup.sh
#!/bin/bash
if [[ ! -f "./submission_reminder_app/config/config.env" ]]; then
echo "this is submission reminder"
exit 1
fi

if [[ ! -f "./submission_reminder_app/modules/functions.sh" ]]; then
echo "this is submission reminder modules"
exit 1
fi 

if [[ ! -f "./submission_reminder_app/assets/submissions.txt" ]]; then
echo "this is submission reminder  modules"
exit 1
fi
echo " now you can execute"
bash ./submission_reminder_app/app/reminder.sh
EOF
chmod +x ./submission_reminder_app/startup.sh
echo "you have successfully created a file./submission_reminder_app/startup.sh with info"
