#!/usr/bin/python

with open("results.txt") as f:
	content = f.readlines()
	
total = 0.0
count = 0
for line in content:
	total = total + int(line.split()[-1][:-1])
	count = count + 1
	
print("Average speed over {0} runs: {1:.2f}k".format(count, (total / count)))