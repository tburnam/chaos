uniqlines = set(open('./sites.txt').readlines())
#print(len(uniqlines))

lines = open('./sites.txt').readlines()
print(len(lines))

lines = open('./sitesFiltered.txt').readlines()
print(len(lines))


bar = open('./sitesFiltered.txt', 'w').writelines(set(uniqlines))

