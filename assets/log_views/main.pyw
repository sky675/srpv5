import json

import wx
import wx.lib.agw.ultimatelistctrl as ULC
from wx.core import Size
from wx.lib.wordwrap import wordwrap

import os
from os import path

from tools.preferences import PreferencesDialog
from tools.filter import FilterDialog


class windowClass(wx.Frame):
	def __init__(self, *args, **kwargs):
		super(windowClass, self).__init__(*args, **kwargs)
		self.logfile = None
		self.allentrytypes = []
		self.SetMinSize(Size(1090,500))
		self.basicGUI()
		self.CheckConfig()

	def basicGUI(self):
		##---MENU BAR---
		menuBar = wx.MenuBar()
		fileCat = wx.Menu()
		openItem = fileCat.Append(wx.ID_OPEN, 'Open Log', 'Open a file')
		editPref = fileCat.Append(wx.ID_PREFERENCES, 'Preferences', 'Edit preferences')
		exitItem = fileCat.Append(wx.ID_EXIT, 'Exit','Exit the program')

		toolsCat = wx.Menu()
		#ithx = wx.MenuItem(menuBar, APP_ITEMHX, 'Item History', 'Create history workup for an item ID')
		itemTlItem = toolsCat.Append(wx.ID_ANY, 'Item History Workup', 'Create a history workup for an item ID')
		combatTlItem = toolsCat.Append(wx.ID_ANY, 'Combat Timeline', 'Create a verbose timeline for combat')
		mapToWorldItem = toolsCat.Append(wx.ID_ANY, 'Map to World', 'Map a string of logs with coordinates.')

		menuBar.Append(fileCat, '&File')
		menuBar.Append(toolsCat, '&Tools')
		self.SetMenuBar(menuBar)
		
		#File
		self.Bind(wx.EVT_MENU, self.ChooseLog, openItem)
		self.Bind(wx.EVT_MENU, self.onPref, editPref)
		self.Bind(wx.EVT_MENU, self.Quit, exitItem)
		
		#Tools
		self.Bind(wx.EVT_MENU, self.WIPFeature, itemTlItem)
		self.Bind(wx.EVT_MENU, self.WIPFeature, combatTlItem)
		self.Bind(wx.EVT_MENU, self.WIPFeature, mapToWorldItem)

		##---PANEL ELEMNTS---
		panel = wx.Panel(self)
		controlBox = wx.BoxSizer(wx.VERTICAL)
		tableBox = wx.BoxSizer(wx.HORIZONTAL)

		self.list = ULC.UltimateListCtrl(panel, agwStyle = ULC.ULC_REPORT|ULC.ULC_HAS_VARIABLE_ROW_HEIGHT|ULC.ULC_HRULES|ULC.ULC_VRULES) 
		self.list.InsertColumn(0, 'Entry Type', width = 100) 
		self.list.InsertColumn(1, 'Time', wx.LIST_FORMAT_LEFT, 100) 
		self.list.InsertColumn(2, 'Log Message', wx.LIST_FORMAT_LEFT, 500) 
		self.Bind(wx.EVT_LIST_ITEM_SELECTED, self.onListBox, self.list)

			##--Controls Box
		self.text = wx.TextCtrl(panel,style = wx.TE_MULTILINE|wx.TE_READONLY)

			#--Button Row 1
		butRow1 = wx.StdDialogButtonSizer()

		self.filter = wx.Button(panel, -1, "Filter Logs")
		self.filter.Bind(wx.EVT_BUTTON, self.onFilter)
		butRow1.Add(self.filter)

		self.vSearch = wx.Button(panel, -1, "Broad Search")
		self.vSearch.Bind(wx.EVT_BUTTON, self.WIPFeature)
		butRow1.Add(self.vSearch)

		butRow1.Realize()

			#--Button Row 2
		butRow2 = wx.StdDialogButtonSizer()

		self.copyRow = wx.Button(panel, -1, "Copy Selected Rows")
		self.copyRow.Bind(wx.EVT_BUTTON, self.copyRows)
		butRow2.Add(self.copyRow)
		butRow2.Realize()

		#self.copyTags = wx.Button(panel, -1, "Copy Tags")
		#butRow2.Add(self.copyTags)
		butRow2.Realize()

			#--Sizing Setup
		controlBox.Add(butRow1,0,wx.ALL | wx.ALIGN_LEFT, 5)
		controlBox.Add(butRow2,0,wx.ALL | wx.ALIGN_LEFT, 5)

		controlBox.Add(self.text,5,wx.ALL|wx.EXPAND) 

		tableBox.Add(self.list,2,wx.ALL|wx.EXPAND, 5) 
		tableBox.Add(controlBox,1,wx.ALL|wx.EXPAND, 5)
		panel.SetSizer(tableBox) 
		panel.Fit() 
		self.Centre() 
		
		self.SetTitle('Log Examiner')
		self.Show(True)

	def CheckConfig(self):
		print("Checking config...")
		cwd = str(os.getcwd())
		print("cwd: " + cwd)
		iniFile = "config.ini"
		iniPath = cwd + "\\" + iniFile
		
		print("ini path: " + iniPath)

		if not path.exists(iniPath):
			print("ini file doesn't exist, opening prefs.")
			self.preferences = PreferencesDialog()
			self.preferences.ShowModal()
			self.preferences.Destroy()
		else:
			print("config exists.")

	def copyRows(self, e):
		self.selectedItems = []
		for i in range(self.list.GetItemCount()):
			if self.list.IsSelected(i):
				selRow = self.list.GetItemData(i)
				self.selectedItems.append(selRow["entrytype"] + "\t" + str(selRow["time"]) + "\t" + selRow["message"])

		self.clipdata = ("\n".join(self.selectedItems))
		if wx.TheClipboard.Open():
			wx.TheClipboard.SetData(wx.TextDataObject(self.clipdata))
			wx.TheClipboard.Close()

	def copyTags():
		print("Copy")

	def onListBox(self, e): 
		self.text.Clear()
		selIndex = self.list.GetFirstSelected()
		entryTags = (e.GetEventObject().GetItemPyData(selIndex))
		tag_items = entryTags.items()
		for i in tag_items:
			self.text.AppendText(str(i))
			self.text.AppendText("\n")

	def onFilter(self, e):
		self.filter = FilterDialog()
		self.filter.defineEntryTypes(self.allentrytypes)
		self.filter.ShowModal()
		self.filterSettings = self.filter.filterSettings
		print("###################################")
		if self.filterSettings != None:
			self.list.DeleteAllItems()
			index = 0
			for value in self.logfile:

				if (value["entrytype"] == self.filterSettings["entrytype"][0]) or self.filterSettings["entrytype"][0] == "none":
					print(index)
					entryTags = value["tags"]
					entryTagText = ""
					tag_items = entryTags.items()
					for i in tag_items:
						entryTagText = entryTagText + (str(i))
						entryTagText = entryTagText + ("\n")

					if(self.filterSettings["param"] in entryTagText) or (self.filterSettings["param"] == ""):
						msgColValue = wordwrap(value["message"], 500, wx.ClientDC(self))
						self.list.InsertStringItem(index, value["entrytype"])
						self.list.SetStringItem(index, 1, str(value["time"]))
						self.list.SetStringItem(index, 2, msgColValue)
						self.list.SetItemPyData(index, value["tags"])
						self.list.SetItemData(index, value)
						#self.list.SetItemData(index)
						index += 1

			self.list.SetColumnWidth(0,wx.LIST_AUTOSIZE)

		if self.filterSettings == None:
			print("Canceled Filter")
			
		else:
			print("Filter requested:")
			if self.filterSettings["entrytype"][0] == "none" and self.filterSettings["param"] == "":
				print("No filter given!")
			else:
				if self.filterSettings["entrytype"][0] == "none":
					print("No entry type set")
				else:
					print("Entry type:" + str(self.filterSettings["entrytype"][0]))
				if self.filterSettings["param"] == "":
					print("No param set")
				else:
					print("Search Parameter:" + str(self.filterSettings["param"]))

		self.filter.Destroy()

	def onPref(self, e):
		self.preferences = PreferencesDialog()
		self.preferences.ShowModal()
		self.preferences.Destroy()

	def Quit(self, e):
		self.Close()

	def populateLog(self):
		self.list.DeleteAllItems()
		index = 0

		#reset filter file
		cwd = str(os.getcwd())
		filterFile = "filters.ini"
		filterPath = cwd + "\\" + filterFile
		try:
			if os.path.isfile(filterFile):
				os.remove(filterPath)
		except OSError:
			pass
		
		for value in self.logfile:
			if (value["entrytype"] not in self.allentrytypes):
				self.allentrytypes.append(value["entrytype"])
			msgColValue = wordwrap(value["message"], 500, wx.ClientDC(self))
			self.list.InsertStringItem(index, value["entrytype"])
			self.list.SetStringItem(index, 1, str(value["time"]))
			self.list.SetStringItem(index, 2, msgColValue)
			self.list.SetItemPyData(index, value["tags"])
			self.list.SetItemData(index, value)
			#self.list.SetItemData(index)
			index += 1
		self.list.SetColumnWidth(0,wx.LIST_AUTOSIZE)

	def ChooseLog(self, e):
		with wx.FileDialog(self, "Open JSON nLog file", wildcard="JSON files (*.json)|*.json",
					   style=wx.FD_OPEN | wx.FD_FILE_MUST_EXIST) as fileDialog:
					   
						if fileDialog.ShowModal() == wx.ID_CANCEL:
							return
						
						pathname = fileDialog.GetPath()
						try:
							f = open(pathname)
							jsonData = json.load(f)
							self.logfile = jsonData
							self.populateLog()
						except Exception as e:
							wx.MessageBox("Failed to open file:\n" + str(e), 'Error', wx.OK | wx.ICON_ERROR)

	def WIPFeature(self, e):
		wx.MessageBox('Feature not yet implemented, sorry.', 'Feature could not come to the phone.', wx.OK | wx.ICON_WARNING)
					

def main():
	app = wx.App()
	windowClass(None)
	app.MainLoop()

main()







