import os




workingDir = 'Q:\\git_srpv5\\srpv5\\assets\\markup_icons'
i = 1
for f in os.listdir(workingDir):
	old_path = os.path.join(workingDir, f)
	new_path = os.path.join(workingDir, 'icon_'+str(i)+'.png')

	os.rename(old_path, new_path)
	i = i + 1