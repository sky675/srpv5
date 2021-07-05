import configobj
import wx
import os 
from os import path


class FilterDialog(wx.Dialog):
	#Creates preference dialog from config file
	def __init__(self):
		self.filterSettings = None
		#initialize the dialog
		wx.Dialog.__init__(self, None, wx.ID_ANY, 'Filter', size =(550, 300))
		self.createWidgets()

	def createNewFilterConfig(self, dir):
		
		config = configobj.ConfigObj()
		config.filename = dir + "\\" + "filters.ini"

		config['Labels'] = {}
		config['Labels']['entrytype'] = "Entry Type:"
		config['Labels']['param'] = "Tag Value:"
		
		config['Values'] = {}
		config['Values']['entrytype'] = ["none", "none", "chat", "attack", "item", "observer", "charload", "chardelete", "charcreate", "shipmentcreate", "shipmenttake", "vendortrade"]
		config['Values']['param'] = ""
		
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
		iniFile = "filters.ini"
		iniPath = cwd + "\\" + iniFile
		
		print("ini path: " + iniPath)

		if not path.exists(iniPath):
			print("filter.ini file doesn't exist, creating.")
			self.createNewFilterConfig(cwd)
		else:
			print("filter.ini file exists, moving on & loading.")

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
			
		saveBtn = wx.Button(self, wx.ID_OK, label="Filter")
		saveBtn.Bind(wx.EVT_BUTTON, self.OnFilter)
		btnSizer.AddButton(saveBtn)

		cancelBtn = wx.Button(self, wx.ID_CANCEL)
		btnSizer.Add(cancelBtn)
		btnSizer.Realize()

		colSizer.Add(lblSizer)
		colSizer.Add(valueSizer, 1, wx.EXPAND)
		mainSizer.Add(colSizer, 0, wx.EXPAND)
		mainSizer.Add(btnSizer, 0, wx.ALL | wx.ALIGN_RIGHT, 5)
		self.SetSizer(mainSizer)

	def OnFilter(self, event):
		#return config options
		self.filterSettings = {}
		for name in self.widgetNames:
			widget = wx.Window.FindWindowByName(name)
			if isinstance(widget, wx.ComboBox):
				selection = widget.GetValue()
				choices = widget.GetItems()
				choices.insert(0, selection)
				self.filterSettings[name] = choices
			else:
				value = widget.GetValue()
				self.filterSettings[name] = value
			self.EndModal(0)






