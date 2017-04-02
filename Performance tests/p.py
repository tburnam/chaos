#!/usr/bin/python
import time

with open("speed.txt") as f:
	content = f.readlines()
# you may also want to remove whitespace characters like `\n` at the end of each line
content = str.join("", [x.strip() for x in content])
print(content);
v = content[content.index("100"):]
speeds = [x for x in v.split() if x[-1] == "k"]


with open("results.txt", "a") as myfile:
	myfile.write("{0}: {1}\n".format(time.strftime("%d/%m/%Y | %H:%M:%S"), speeds[-1]))



#x = [word for word in lastLine if word[-1] == "k"]
#print(x)
