#!/bin/bash
if [ $# == 1 ]; then
    version=$1
else
    echo -n “Docker Version: “
    read version
    echo -n “Year: “
    read year
    echo “Using: $month $year”
fi
Usage state