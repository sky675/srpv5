import os

def removeNums(n):
	start = 0
	stop = 5
	nNew = n[0: start:] + n[stop + 1::]
	return nNew


workingDir = 'Q:\\git_srpv5\\srpv5\\assets\\storages\\fixed_top'
for f in os.listdir(workingDir):
	old_path = os.path.join(workingDir, f)
	new_path = os.path.join(workingDir, removeNums(f))

	os.rename(old_path, new_path)
