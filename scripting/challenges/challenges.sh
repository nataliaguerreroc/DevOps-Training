#!/bin/bash

# Display only the even numbers from 1 to 100
for ((i = 1; i <= 100; i++)); do
    if ((i % 2 == 0)); then
        echo $i
    fi
done

# Compare natural numbers and display X is greater than Y, X is equal to Y or X is less than Y
X=22
Y=20

if ((X > Y)); then
    echo "$X is greater than $Y"
elif ((X == Y)); then
    echo "$X is equal to $Y"
else
    echo "$X is less than $Y"
fi

# Read N numbers from the stdio and compute their average
echo "Enter the value of N: "
read N

sum=0

echo "Enter $N numbers:"

for ((i = 1; i <= N; i++)); do
    read num
    sum=$((sum + num))
done


average=$(echo "scale=2; $sum / $N" | bc)

echo "The average of the $N numbers is: $average"

# Check if a file exists, if it doesn't exist, create it

file="example.txt"

if [ -e "$file" ]; then
    echo "$file already exists."
else
    echo "$file doesn't exist."
    touch "$file"
    echo "$file is created."
fi

# Write a script that outputs the current time and date. For example: Current time: 08:02, Current date: 2022-08-10

current_time=$(date +"%H:%M")
current_date=$(date +"%Y-%m-%d")

echo "Current time: $current_time, Current date: $current_date"


# Write a script that prints information about your OS and version, release number, and kernel version
os_info=$(cat /etc/os-release)
version=$(echo "$os_info" | grep "VERSION_ID" | cut -d '=' -f 2 | tr -d '"')
os_name=$(echo "$os_info" | grep "PRETTY_NAME" | cut -d '=' -f 2 | tr -d '"')

release=$(uname -r)

echo "OS: $os_name"
echo "Version: $version"
echo "Release number: $release"

# Write a script that checks if cups service is running. If it running, print Cups status is running. Otherwise, prints Cups's status is stopped

if systemctl is-active --quiet cups; then
    echo "Cups' status is running"
else
    echo "Cups' status is stopped"
fi
