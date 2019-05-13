#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "Usage: generate_plist.sh script_location output_file"
    exit 1
fi

m4 --define script_location=$1 com.activitylogger.osx.plist.template > $2