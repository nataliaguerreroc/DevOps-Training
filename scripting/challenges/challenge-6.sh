# Write a script that prints how many parameters are passed and which ones? For example, if I run the script like this: ./script1 p1 p2 p3 p4, then it should print: 4 params were passed and they're these ones: p1, p2, p3, p4

num_params=$#
params=("$@")

echo "$num_params params were passed and they're these ones: ${params[*]}"

