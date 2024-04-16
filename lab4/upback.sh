#!/bin/bash

backup_directory="$HOME"
restore_directory="$HOME/restore"
date_regex="[0-9]{4}-[0-1][0-9]-[0-3][0-9]"
latest_backup_date=$(awk -F - '{print $2"-"$3"-"$4}' <<< $(ls $backup_directory | grep -E "^Backup-${date_regex}$") | sort | tail -n 1)
latest_backup_directory=$backup_directory/Backup-$latest_backup_date

if [[ $latest_backup_date == "--" ]]; then
  echo "Nothing to restore."
  exit 1
fi

if [[ ! -d $restore_directory ]]; then
  mkdir "$restore_directory"
fi

for file in $(ls $latest_backup_directory); do
  if [[ $file =~ .${date_regex}$ ]]; then
    echo ${file::-11}
  else
    echo $file
  fi
done | sort | uniq | while read -r file; do
  name=$(ls $latest_backup_directory | grep "$file" | sort | tail -n 1)
  cp "$latest_backup_directory/$name" "$restore_directory/$file"
done

