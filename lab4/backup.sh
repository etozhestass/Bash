#!/bin/bash

function get_current_timestamp() {
  date +%d.%m.%Y\ %H:%M:%S
}

function get_file_size() {
  wc -c "$1" | awk '{print $1}'
}

source_directory="$HOME/source"
backup_directory="$HOME"
backup_report_file="$backup_directory/backup-report"
current_date=$(date +%Y-%m-%d)
last_backup_date=$(awk -F - '{print $2"-"$3"-"$4}' <<< $(ls $backup_directory | grep "^Backup-[0-9]\{4\}-[0-1][0-9]-[0-3][0-9]$") | sort | tail -n 1)
let backup_cutoff=$(date +%s -d $current_date)-7*24*60*60
last_backup_timestamp=$(date +%s -d $last_backup_date)

if [[ ! -f $backup_report_file ]]; then
  touch "$backup_report_file"
fi

if [[ $last_backup_date == "--" ]] || [[ $last_backup_timestamp -lt $backup_cutoff ]]; then
  new_backup_dir=$backup_directory/Backup-$current_date
  mkdir "$new_backup_dir" && cp "$source_directory"/* "$new_backup_dir"
  echo "  Backup done $(get_current_timestamp) in directory $new_backup_dir"
  echo "Add: "
  for file in "$new_backup_dir"/*; do
    echo " + $(basename "$file")"
  done
else
  existing_backup_dir=$backup_directory/Backup-$last_backup_date
  echo "  Backup updated $(get_current_timestamp) in directory $existing_backup_dir"
  echo "Add: "
  for file in "$source_directory"/*; do
    if [[ ! -f $existing_backup_dir/$(basename "$file") ]]; then
      cp "$file" "$existing_backup_dir/"
      echo " + $(basename "$file")"
    fi
  done
  echo "Modified: "
  for file in "$source_directory"/*; do
    if [[ $(get_file_size "$existing_backup_dir/$(basename "$file")") -ne $(get_file_size "$file") ]]; then
      cp "$file" "$existing_backup_dir/$(basename "$file").$current_date"
      echo " ! $(basename "$file") $(basename "$file").$current_date"
    fi
  done
fi >> "$backup_report_file"

