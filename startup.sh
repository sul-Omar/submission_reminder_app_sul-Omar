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
