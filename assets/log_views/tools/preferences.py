import configobj
import wx
import os 
from os import path


class PreferencesDialog(wx.Dialog):
	#Creates preference dialog from config file
	def __init__(self):
		#initialize the dialog
		wx.Dialog.__init__(self, None, wx.ID_ANY, 'Preferences', size =(550, 300))
		self.createWidgets()

	def createNewConfig(self, dir):
		
		config = configobj.ConfigObj()
		config.filename = dir + "\\" + "config.ini"

		config['Labels'] = {}
		config['Labels']['username'] = "Display Name (for exports):"
		config['Labels']['timezone'] = "Timezone:"
		
		config['Values'] = {}
		config['Values']['username'] = "User"
		config['Values']['timezone'] = ["GMT+0", "GMT+0", "GMT+1", "GMT+2", "GMT+3", "GMT+4", "GMT+5", "GMT+6", "GMT+7", "GMT+8", "GMT+9", "GMT+10", "GMT+12"]
		
		config.write()

	def createWidgets(self):
		#create & layout the widgets in the dialog
		lblSizer = wx.BoxSizer(wx.VERTICAL)
		valueSizer = wx.BoxSizer(wx.VERTICAL)
		btnSizer = wx.StdDialogButtonSizer()
		colSizer = wx.BoxSizer(wx.HORIZONTAL)
		mainSizer = wx.BoxSizer(wx.VERTICAL)

		cwd = str(os.getcwd())
		print("cwd: " + cwd)
		iniFile = "config.ini"
		iniPath = cwd + "\\" + iniFile
		
		print("ini path: " + iniPath)

		if not path.exists(iniPath):
			print("ini file doesn't exist, creating.")
			self.createNewConfig(cwd)
		else:
			print("ini file exists, moving on & loading.")

		self.config = configobj.ConfigObj(iniFile)

		labels = self.config["Labels"]
		values = self.config["Values"]
		self.widgetNames = values
		font = wx.Font(12, wx.SWISS, wx.NORMAL, wx.BOLD)

		for key in labels:
			value = labels[key]
			lbl = wx.StaticText(self, label=value)
			lbl.SetFont(font)
			lblSizer.Add(lbl, 0, wx.ALL, 5)

		for key in values:
			value = values[key]
			if isinstance(value, list):
				default = value[0]
				choices = value[1:]
				cbo = wx.ComboBox(self, value=value[0],
								  size=wx.DefaultSize, choices=choices,
								  style=wx.CB_DROPDOWN|wx.CB_READONLY,
								  name=key)
				valueSizer.Add(cbo, 0, wx.ALL, 5)
			else:
				txt = wx.TextCtrl(self, value=value, name=key)
				valueSizer.Add(txt, 0, wx.ALL|wx.EXPAND, 5)
			
		saveBtn = wx.Button(self, wx.ID_OK, label="Save")
		saveBtn.Bind(wx.EVT_BUTTON, self.OnSave)
		btnSizer.Add(saveBtn)

		cancelBtn = wx.Button(self, wx.ID_CANCEL)
		btnSizer.Add(cancelBtn)

		resetBtn = wx.Button(self, wx.ID_ANY, label="Reset All")
		resetBtn.Bind(wx.EVT_BUTTON, self.OnReset)
		btnSizer.Add(resetBtn)

		btnSizer.Realize()

		colSizer.Add(lblSizer)
		colSizer.Add(valueSizer, 1, wx.EXPAND)
		mainSizer.Add(colSizer, 0, wx.EXPAND)
		mainSizer.Add(btnSizer, 0, wx.ALL | wx.ALIGN_RIGHT, 5)
		self.SetSizer(mainSizer)

	def OnReset(self, event):
		print("reset called")
		resetVal = wx.MessageBox('This will reset both config.ini and filter.ini. Are you sure?', 'Reset General Config & Filter Config', wx.YES_NO)
		if (resetVal == 2):
			print("Yes!")
			self.DoReset()
			self.EndModal(0)

			cwd = str(os.getcwd())
			iniFile = "config.ini"
			filterFile = "filters.ini"
			configPath = cwd + "\\" + iniFile
			filterPath = cwd + "\\" + filterFile
			
			#trying config
			try:
				os.remove(configPath)
			except OSError:
				pass

			try:
				os.remove(filterPath)
			except OSError:
				pass
			
			wx.MessageBox('Config.ini and Filter.ini have been reset!', 'Reset Complete', wx.OK)


	def DoReset(self):
		print("doing reset :)")

	def OnSave(self, event):
		#saves values of config to disk poggers

		for name in self.widgetNames:
			widget = wx.Window.FindWindowByName(name)
			if isinstance(widget, wx.ComboBox):
				selection = widget.GetValue()
				choices = widget.GetItems()
				choices.insert(0, selection)
				self.widgetNames[name] = choices
			else:
				value = widget.GetValue()
				self.widgetNames[name] = value
			self.config.write()
			self.EndModal(0)






