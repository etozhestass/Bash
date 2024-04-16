#!/bin/bash

copy_file() {
    if [ -z "$1" ]; then
        echo "Ошибка: не указано имя файла для копирования."
        return 1   
    fi

    if [ ! -f "$1" ]; then
        echo "Ошибка: файл '$1' не существует."
        return 1
    fi

    rsync --append --partial --progress "$1" ~/temp/
}

copy_file "$1"

