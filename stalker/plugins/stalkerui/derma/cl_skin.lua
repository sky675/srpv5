local SKIN = {}
	SKIN.PrintName		= "Stalker Derma Skin"
	SKIN.Author		= "Nate"
	SKIN.DermaVersion	= 1
	SKIN.GwenTexture	= Material( "sky/gwen/stalkergwen.png" )
	local gwenText = Material( "sky/gwen/stalkergwen.png" )

	SKIN.fontFrame = "stalkerBigFont"
	SKIN.fontTab = "nutSmallFont"
	SKIN.fontButton = "nutSmallFont"
	SKIN.Colours = table.Copy(derma.SkinList.Default.Colours)
	SKIN.Colours.Window.TitleActive = Color(0, 0, 0)
	SKIN.Colours.Window.TitleInactive = Color(255, 255, 255)

	SKIN.Colours.Button.Normal = Color(80, 80, 80)
	SKIN.Colours.Button.Hover = Color(255, 255, 255)
	SKIN.Colours.Button.Down = Color(180, 180, 180)

	SKIN.Colours.Button.Disabled = Color(0, 0, 0, 100)
	SKIN.Colours.Label.Highlight = Color(101, 133, 101)

    SKIN.Colours.Category.Line.Button_Hover = Color(101, 133, 101, 100)
    SKIN.Colours.Category.Line.Button_Selected = Color(101, 133, 101)

    SKIN.listview_hover				= Color(101, 133, 101, 100)
    SKIN.listview_selected			= Color(101, 133, 101)

	SKIN.colTextEntryTextHighlight	= Color( 101, 133, 101 )

	SKIN.tex = {}

	SKIN.tex.Selection					= GWEN.CreateTextureBorder( 384, 32, 31, 31, 4, 4, 4, 4, gwenText )
	
	SKIN.tex.Panels = {}
	SKIN.tex.Panels.Normal				= GWEN.CreateTextureBorder( 256,	0, 63, 63, 16, 16, 16, 16 )
	SKIN.tex.Panels.Bright				= GWEN.CreateTextureBorder( 256+64, 0, 63, 63, 16, 16, 16, 16 )
	SKIN.tex.Panels.Dark				= GWEN.CreateTextureBorder( 256,	64, 63, 63, 16, 16, 16, 16 )
	SKIN.tex.Panels.Highlight			= GWEN.CreateTextureBorder( 256+64, 64, 63, 63, 16, 16, 16, 16 )
	
	SKIN.tex.Button						= GWEN.CreateTextureBorder( 480, 0, 31, 31, 8, 8, 8, 8 )
	SKIN.tex.Button_Hovered				= GWEN.CreateTextureBorder( 480, 32, 31, 31, 8, 8, 8, 8 )
	SKIN.tex.Button_Dead				= GWEN.CreateTextureBorder( 480, 64, 31, 31, 8, 8, 8, 8 )
	SKIN.tex.Button_Down				= GWEN.CreateTextureBorder( 480, 96, 31, 31, 8, 8, 8, 8 )
	SKIN.tex.Shadow						= GWEN.CreateTextureBorder( 448, 0, 31, 31, 8, 8, 8, 8 )
	
	SKIN.tex.Tree						= GWEN.CreateTextureBorder( 256, 128, 127, 127, 16, 16, 16, 16 )
	SKIN.tex.Checkbox_Checked			= GWEN.CreateTextureNormal( 448, 32, 15, 15 )
	SKIN.tex.Checkbox					= GWEN.CreateTextureNormal( 464, 32, 15, 15 )
	SKIN.tex.CheckboxD_Checked			= GWEN.CreateTextureNormal( 448, 48, 15, 15 )
	SKIN.tex.CheckboxD					= GWEN.CreateTextureNormal( 464, 48, 15, 15 )
	SKIN.tex.RadioButton_Checked		= GWEN.CreateTextureNormal( 448, 64, 15, 15 )
	SKIN.tex.RadioButton				= GWEN.CreateTextureNormal( 464, 64, 15, 15 )
	SKIN.tex.RadioButtonD_Checked		= GWEN.CreateTextureNormal( 448, 80, 15, 15 )
	SKIN.tex.RadioButtonD				= GWEN.CreateTextureNormal( 464, 80, 15, 15 )
	SKIN.tex.TreePlus					= GWEN.CreateTextureNormal( 448, 96, 15, 15 )
	SKIN.tex.TreeMinus					= GWEN.CreateTextureNormal( 464, 96, 15, 15 )
	SKIN.tex.TextBox					= GWEN.CreateTextureBorder( 0, 150, 127, 21, 4, 4, 4, 4 )
	SKIN.tex.TextBox_Focus				= GWEN.CreateTextureBorder( 0, 172, 127, 21, 4, 4, 4, 4 )
	SKIN.tex.TextBox_Disabled			= GWEN.CreateTextureBorder( 0, 194, 127, 21, 4, 4, 4, 4 )
	SKIN.tex.MenuBG_Column				= GWEN.CreateTextureBorder( 128, 128, 127, 63, 24, 8, 8, 8 )
	SKIN.tex.MenuBG						= GWEN.CreateTextureBorder( 128, 192, 127, 63, 8, 8, 8, 8 )
	SKIN.tex.MenuBG_Hover				= GWEN.CreateTextureBorder( 128, 256, 127, 31, 8, 8, 8, 8 )
	SKIN.tex.MenuBG_Spacer				= GWEN.CreateTextureNormal( 128, 288, 127, 3 )
	SKIN.tex.Menu_Strip					= GWEN.CreateTextureBorder( 0, 128, 127, 21, 8, 8, 8, 8 )
	SKIN.tex.Menu_Check					= GWEN.CreateTextureNormal( 448, 112, 15, 15 )
	SKIN.tex.Tab_Control				= GWEN.CreateTextureBorder( 0, 256, 127, 127, 8, 8, 8, 8 )
	SKIN.tex.TabB_Active				= GWEN.CreateTextureBorder( 0,		416, 63, 31, 8, 8, 8, 8 )
	SKIN.tex.TabB_Inactive				= GWEN.CreateTextureBorder( 128,	416, 63, 31, 8, 8, 8, 8 )
	SKIN.tex.TabT_Active				= GWEN.CreateTextureBorder( 0,		384, 63, 31, 8, 8, 8, 8 )
	SKIN.tex.TabT_Inactive				= GWEN.CreateTextureBorder( 128,	384, 63, 31, 8, 8, 8, 8 )
	SKIN.tex.TabL_Active				= GWEN.CreateTextureBorder( 64,		384, 31, 63, 8, 8, 8, 8 )
	SKIN.tex.TabL_Inactive				= GWEN.CreateTextureBorder( 64+128, 384, 31, 63, 8, 8, 8, 8 )
	SKIN.tex.TabR_Active				= GWEN.CreateTextureBorder( 96,		384, 31, 63, 8, 8, 8, 8 )
	SKIN.tex.TabR_Inactive				= GWEN.CreateTextureBorder( 96+128, 384, 31, 63, 8, 8, 8, 8 )
	SKIN.tex.Tab_Bar					= GWEN.CreateTextureBorder( 128, 352, 127, 31, 4, 4, 4, 4 )
	
	SKIN.tex.Window = {}
	
	SKIN.tex.Window.Normal			= GWEN.CreateTextureBorder( 0, 0, 127, 127, 8, 24, 8, 8 )
	SKIN.tex.Window.Inactive		= GWEN.CreateTextureBorder( 128, 0, 127, 127, 8, 24, 8, 8 )
	
	SKIN.tex.Window.Close			= GWEN.CreateTextureNormal( 32, 448, 31, 24 )
	SKIN.tex.Window.Close_Hover		= GWEN.CreateTextureNormal( 64, 448, 31, 24 )
	SKIN.tex.Window.Close_Down		= GWEN.CreateTextureNormal( 96, 448, 31, 24 )
	
	SKIN.tex.Window.Maxi			= GWEN.CreateTextureNormal( 32 + 96 * 2, 448, 31, 24 )
	SKIN.tex.Window.Maxi_Hover		= GWEN.CreateTextureNormal( 64 + 96 * 2, 448, 31, 24 )
	SKIN.tex.Window.Maxi_Down		= GWEN.CreateTextureNormal( 96 + 96 * 2, 448, 31, 24 )
	
	SKIN.tex.Window.Restore			= GWEN.CreateTextureNormal( 32 + 96 * 2, 448 + 32, 31, 24 )
	SKIN.tex.Window.Restore_Hover	= GWEN.CreateTextureNormal( 64 + 96 * 2, 448 + 32, 31, 24 )
	SKIN.tex.Window.Restore_Down	= GWEN.CreateTextureNormal( 96 + 96 * 2, 448 + 32, 31, 24 )
	
	SKIN.tex.Window.Mini			= GWEN.CreateTextureNormal( 32 + 96, 448, 31, 24 )
	SKIN.tex.Window.Mini_Hover		= GWEN.CreateTextureNormal( 64 + 96, 448, 31, 24 )
	SKIN.tex.Window.Mini_Down		= GWEN.CreateTextureNormal( 96 + 96, 448, 31, 24 )
	
	SKIN.tex.Scroller = {}
	SKIN.tex.Scroller.TrackV				= GWEN.CreateTextureBorder( 384,		208, 15, 127, 4, 4, 4, 4 )
	SKIN.tex.Scroller.ButtonV_Normal		= GWEN.CreateTextureBorder( 384 + 16,	208, 15, 127, 4, 4, 4, 4 )
	SKIN.tex.Scroller.ButtonV_Hover			= GWEN.CreateTextureBorder( 384 + 32,	208, 15, 127, 4, 4, 4, 4 )
	SKIN.tex.Scroller.ButtonV_Down			= GWEN.CreateTextureBorder( 384 + 48,	208, 15, 127, 4, 4, 4, 4 )
	SKIN.tex.Scroller.ButtonV_Disabled		= GWEN.CreateTextureBorder( 384 + 64,	208, 15, 127, 4, 4, 4, 4 )
	
	SKIN.tex.Scroller.TrackH				= GWEN.CreateTextureBorder( 384, 128,		127, 15, 4, 4, 4, 4 )
	SKIN.tex.Scroller.ButtonH_Normal		= GWEN.CreateTextureBorder( 384, 128 + 16,	127, 15, 4, 4, 4, 4 )
	SKIN.tex.Scroller.ButtonH_Hover			= GWEN.CreateTextureBorder( 384, 128 + 32,	127, 15, 4, 4, 4, 4 )
	SKIN.tex.Scroller.ButtonH_Down			= GWEN.CreateTextureBorder( 384, 128 + 48,	127, 15, 4, 4, 4, 4 )
	SKIN.tex.Scroller.ButtonH_Disabled		= GWEN.CreateTextureBorder( 384, 128 + 64,	127, 15, 4, 4, 4, 4 )
	
	SKIN.tex.Scroller.LeftButton_Normal		= GWEN.CreateTextureBorder( 464,		208, 15, 15, 2, 2, 2, 2 )
	SKIN.tex.Scroller.LeftButton_Hover		= GWEN.CreateTextureBorder( 480,		208, 15, 15, 2, 2, 2, 2 )
	SKIN.tex.Scroller.LeftButton_Down		= GWEN.CreateTextureBorder( 464,		272, 15, 15, 2, 2, 2, 2 )
	SKIN.tex.Scroller.LeftButton_Disabled	= GWEN.CreateTextureBorder( 480 + 48,	272, 15, 15, 2, 2, 2, 2 )
	
	SKIN.tex.Scroller.UpButton_Normal		= GWEN.CreateTextureBorder( 464,		208 + 16, 15, 15, 2, 2, 2, 2 )
	SKIN.tex.Scroller.UpButton_Hover		= GWEN.CreateTextureBorder( 480,		208 + 16, 15, 15, 2, 2, 2, 2 )
	SKIN.tex.Scroller.UpButton_Down			= GWEN.CreateTextureBorder( 464,		272 + 16, 15, 15, 2, 2, 2, 2 )
	SKIN.tex.Scroller.UpButton_Disabled		= GWEN.CreateTextureBorder( 480 + 48,	272 + 16, 15, 15, 2, 2, 2, 2 )
	
	SKIN.tex.Scroller.RightButton_Normal	= GWEN.CreateTextureBorder( 464,		208 + 32, 15, 15, 2, 2, 2, 2 )
	SKIN.tex.Scroller.RightButton_Hover		= GWEN.CreateTextureBorder( 480,		208 + 32, 15, 15, 2, 2, 2, 2 )
	SKIN.tex.Scroller.RightButton_Down		= GWEN.CreateTextureBorder( 464,		272 + 32, 15, 15, 2, 2, 2, 2 )
	SKIN.tex.Scroller.RightButton_Disabled	= GWEN.CreateTextureBorder( 480 + 48,	272 + 32, 15, 15, 2, 2, 2, 2 )
	
	SKIN.tex.Scroller.DownButton_Normal		= GWEN.CreateTextureBorder( 464,		208 + 48, 15, 15, 2, 2, 2, 2 )
	SKIN.tex.Scroller.DownButton_Hover		= GWEN.CreateTextureBorder( 480,		208 + 48, 15, 15, 2, 2, 2, 2 )
	SKIN.tex.Scroller.DownButton_Down		= GWEN.CreateTextureBorder( 464,		272 + 48, 15, 15, 2, 2, 2, 2 )
	SKIN.tex.Scroller.DownButton_Disabled	= GWEN.CreateTextureBorder( 480 + 48,	272 + 48, 15, 15, 2, 2, 2, 2 )
	
	SKIN.tex.Menu = {}
	SKIN.tex.Menu.RightArrow = GWEN.CreateTextureNormal( 464, 112, 15, 15 )
	
	SKIN.tex.Input = {}
	
	SKIN.tex.Input.ComboBox = {}
	SKIN.tex.Input.ComboBox.Normal		= GWEN.CreateTextureBorder( 384, 336,	127, 31, 8, 8, 32, 8 )
	SKIN.tex.Input.ComboBox.Hover		= GWEN.CreateTextureBorder( 384, 336+32, 127, 31, 8, 8, 32, 8 )
	SKIN.tex.Input.ComboBox.Down		= GWEN.CreateTextureBorder( 384, 336+64, 127, 31, 8, 8, 32, 8 )
	SKIN.tex.Input.ComboBox.Disabled		= GWEN.CreateTextureBorder( 384, 336+96, 127, 31, 8, 8, 32, 8 )
	
	SKIN.tex.Input.ComboBox.Button = {}
	SKIN.tex.Input.ComboBox.Button.Normal	= GWEN.CreateTextureNormal( 496, 272, 15, 15 )
	SKIN.tex.Input.ComboBox.Button.Hover	= GWEN.CreateTextureNormal( 496, 272+16, 15, 15 )
	SKIN.tex.Input.ComboBox.Button.Down		= GWEN.CreateTextureNormal( 496, 272+32, 15, 15 )
	SKIN.tex.Input.ComboBox.Button.Disabled	= GWEN.CreateTextureNormal( 496, 272+48, 15, 15 )
	
	SKIN.tex.Input.UpDown = {}
	SKIN.tex.Input.UpDown.Up = {}
	SKIN.tex.Input.UpDown.Up.Normal		= GWEN.CreateTextureCentered( 384,		112, 7, 7 )
	SKIN.tex.Input.UpDown.Up.Hover		= GWEN.CreateTextureCentered( 384+8,	112, 7, 7 )
	SKIN.tex.Input.UpDown.Up.Down		= GWEN.CreateTextureCentered( 384+16,	112, 7, 7 )
	SKIN.tex.Input.UpDown.Up.Disabled	= GWEN.CreateTextureCentered( 384+24,	112, 7, 7 )
	
	SKIN.tex.Input.UpDown.Down = {}
	SKIN.tex.Input.UpDown.Down.Normal	= GWEN.CreateTextureCentered( 384,		120, 7, 7 )
	SKIN.tex.Input.UpDown.Down.Hover	= GWEN.CreateTextureCentered( 384+8,	120, 7, 7 )
	SKIN.tex.Input.UpDown.Down.Down		= GWEN.CreateTextureCentered( 384+16,	120, 7, 7 )
	SKIN.tex.Input.UpDown.Down.Disabled	= GWEN.CreateTextureCentered( 384+24,	120, 7, 7 )
	
	SKIN.tex.Input.Slider = {}
	SKIN.tex.Input.Slider.H = {}
	SKIN.tex.Input.Slider.H.Normal		= GWEN.CreateTextureNormal( 416, 32,	15, 15 )
	SKIN.tex.Input.Slider.H.Hover		= GWEN.CreateTextureNormal( 416, 32+16, 15, 15 )
	SKIN.tex.Input.Slider.H.Down		= GWEN.CreateTextureNormal( 416, 32+32, 15, 15 )
	SKIN.tex.Input.Slider.H.Disabled	= GWEN.CreateTextureNormal( 416, 32+48, 15, 15 )
	
	SKIN.tex.Input.Slider.V = {}
	SKIN.tex.Input.Slider.V.Normal		= GWEN.CreateTextureNormal( 416+16, 32, 15, 15 )
	SKIN.tex.Input.Slider.V.Hover		= GWEN.CreateTextureNormal( 416+16, 32+16, 15, 15 )
	SKIN.tex.Input.Slider.V.Down		= GWEN.CreateTextureNormal( 416+16, 32+32, 15, 15 )
	SKIN.tex.Input.Slider.V.Disabled	= GWEN.CreateTextureNormal( 416+16, 32+48, 15, 15 )
	
	SKIN.tex.Input.ListBox = {}
	SKIN.tex.Input.ListBox.Background		= GWEN.CreateTextureBorder( 256, 256, 63, 127, 8, 8, 8, 8, gwenText )
	SKIN.tex.Input.ListBox.Hovered			= GWEN.CreateTextureBorder( 320, 320, 31, 31, 8, 8, 8, 8, gwenText )
	SKIN.tex.Input.ListBox.EvenLine			= GWEN.CreateTextureBorder( 352, 256, 31, 31, 8, 8, 8, 8, gwenText )
	SKIN.tex.Input.ListBox.OddLine			= GWEN.CreateTextureBorder( 352, 288, 31, 31, 8, 8, 8, 8, gwenText )
	SKIN.tex.Input.ListBox.EvenLineSelected	= GWEN.CreateTextureBorder( 320, 256, 31, 31, 8, 8, 8, 8, gwenText )
	SKIN.tex.Input.ListBox.OddLineSelected	= GWEN.CreateTextureBorder( 320, 288, 31, 31, 8, 8, 8, 8, gwenText )
	
	SKIN.tex.ProgressBar = {}
	SKIN.tex.ProgressBar.Back	= GWEN.CreateTextureBorder( 384,	0, 31, 31, 8, 8, 8, 8 )
	SKIN.tex.ProgressBar.Front	= GWEN.CreateTextureBorder( 384+32, 0, 31, 31, 8, 8, 8, 8 )
	
	SKIN.tex.CategoryList = {}
	SKIN.tex.CategoryList.Outer		= GWEN.CreateTextureBorder( 256, 384, 63, 63, 8, 8, 8, 8 )
	SKIN.tex.CategoryList.InnerH	= GWEN.CreateTextureBorder( 320, 384, 63, 20, 8, 8, 8, 8 )
	SKIN.tex.CategoryList.Inner		= GWEN.CreateTextureBorder( 320, 384 + 21, 63, 63 - 21, 8, 0, 8, 8 )
	SKIN.tex.CategoryList.Header	= GWEN.CreateTextureBorder( 320, 352, 63, 31, 8, 8, 8, 8 )
	
	SKIN.tex.Tooltip = GWEN.CreateTextureBorder( 384, 64, 31, 31, 8, 8, 8, 8 )
	
	SKIN.Colours = {}
	
	SKIN.Colours.Window = {}
	SKIN.Colours.Window.TitleActive		= GWEN.TextureColor( 4 + 8 * 0, 508 )
	SKIN.Colours.Window.TitleInactive	= GWEN.TextureColor( 4 + 8 * 1, 508 )
	
	SKIN.Colours.Button = {}
	SKIN.Colours.Button.Normal			= GWEN.TextureColor( 4 + 8 * 2, 508 )
	SKIN.Colours.Button.Hover			= GWEN.TextureColor( 4 + 8 * 3, 508 )
	SKIN.Colours.Button.Down			= GWEN.TextureColor( 4 + 8 * 2, 500 )
	SKIN.Colours.Button.Disabled		= GWEN.TextureColor( 4 + 8 * 3, 500 )
	
	SKIN.Colours.Tab = {}
	SKIN.Colours.Tab.Active = {}
	SKIN.Colours.Tab.Active.Normal		= GWEN.TextureColor( 4 + 8 * 4, 508 )
	SKIN.Colours.Tab.Active.Hover		= GWEN.TextureColor( 4 + 8 * 5, 508 )
	SKIN.Colours.Tab.Active.Down		= GWEN.TextureColor( 4 + 8 * 4, 500 )
	SKIN.Colours.Tab.Active.Disabled	= GWEN.TextureColor( 4 + 8 * 5, 500 )
	
	SKIN.Colours.Tab.Inactive = {}
	SKIN.Colours.Tab.Inactive.Normal	= GWEN.TextureColor( 4 + 8 * 6, 508 )
	SKIN.Colours.Tab.Inactive.Hover		= GWEN.TextureColor( 4 + 8 * 7, 508 )
	SKIN.Colours.Tab.Inactive.Down		= GWEN.TextureColor( 4 + 8 * 6, 500 )
	SKIN.Colours.Tab.Inactive.Disabled	= GWEN.TextureColor( 4 + 8 * 7, 500 )
	
	SKIN.Colours.Label = {}
	SKIN.Colours.Label.Default			= GWEN.TextureColor( 4 + 8 * 8, 508 )
	SKIN.Colours.Label.Bright			= GWEN.TextureColor( 4 + 8 * 9, 508 )
	SKIN.Colours.Label.Dark				= GWEN.TextureColor( 4 + 8 * 8, 500 )
	SKIN.Colours.Label.Highlight		= GWEN.TextureColor( 4 + 8 * 9, 500 )
	
	SKIN.Colours.Tree = {}
	SKIN.Colours.Tree.Lines				= GWEN.TextureColor( 4 + 8 * 10, 508 ) ---- !!!
	SKIN.Colours.Tree.Normal			= GWEN.TextureColor( 4 + 8 * 11, 508 )
	SKIN.Colours.Tree.Hover				= GWEN.TextureColor( 4 + 8 * 10, 500 )
	SKIN.Colours.Tree.Selected			= GWEN.TextureColor( 4 + 8 * 11, 500 )
	
	SKIN.Colours.Properties = {}
	SKIN.Colours.Properties.Line_Normal			= GWEN.TextureColor( 4 + 8 * 12, 508 )
	SKIN.Colours.Properties.Line_Selected		= GWEN.TextureColor( 4 + 8 * 13, 508 )
	SKIN.Colours.Properties.Line_Hover			= GWEN.TextureColor( 4 + 8 * 12, 500 )
	SKIN.Colours.Properties.Title				= GWEN.TextureColor( 4 + 8 * 13, 500 )
	SKIN.Colours.Properties.Column_Normal		= GWEN.TextureColor( 4 + 8 * 14, 508 )
	SKIN.Colours.Properties.Column_Selected		= GWEN.TextureColor( 4 + 8 * 15, 508 )
	SKIN.Colours.Properties.Column_Hover		= GWEN.TextureColor( 4 + 8 * 14, 500 )
	SKIN.Colours.Properties.Column_Disabled		= Color( 240, 240, 240 )
	SKIN.Colours.Properties.Border				= GWEN.TextureColor( 4 + 8 * 15, 500 )
	SKIN.Colours.Properties.Label_Normal		= GWEN.TextureColor( 4 + 8 * 16, 508 )
	SKIN.Colours.Properties.Label_Selected		= GWEN.TextureColor( 4 + 8 * 17, 508 )
	SKIN.Colours.Properties.Label_Hover			= GWEN.TextureColor( 4 + 8 * 16, 500 )
	SKIN.Colours.Properties.Label_Disabled		= GWEN.TextureColor( 4 + 8 * 16, 508 )
	
	SKIN.Colours.Category = {}
	SKIN.Colours.Category.Header				= GWEN.TextureColor( 4 + 8 * 18, 500 )
	SKIN.Colours.Category.Header_Closed			= GWEN.TextureColor( 4 + 8 * 19, 500 )
	SKIN.Colours.Category.Line = {}
	SKIN.Colours.Category.Line.Text				= GWEN.TextureColor( 4 + 8 * 20, 508 )
	SKIN.Colours.Category.Line.Text_Hover		= GWEN.TextureColor( 4 + 8 * 21, 508 )
	SKIN.Colours.Category.Line.Text_Selected	= GWEN.TextureColor( 4 + 8 * 20, 500 )
	SKIN.Colours.Category.Line.Button			= GWEN.TextureColor( 4 + 8 * 21, 500 )
	SKIN.Colours.Category.Line.Button_Hover		= GWEN.TextureColor( 4 + 8 * 22, 508 )
	SKIN.Colours.Category.Line.Button_Selected	= GWEN.TextureColor( 4 + 8 * 23, 508 )
	SKIN.Colours.Category.LineAlt = {}
	SKIN.Colours.Category.LineAlt.Text				= GWEN.TextureColor( 4 + 8 * 22, 500 )
	SKIN.Colours.Category.LineAlt.Text_Hover		= GWEN.TextureColor( 4 + 8 * 23, 500 )
	SKIN.Colours.Category.LineAlt.Text_Selected		= GWEN.TextureColor( 4 + 8 * 24, 508 )
	SKIN.Colours.Category.LineAlt.Button			= GWEN.TextureColor( 4 + 8 * 25, 508 )
	SKIN.Colours.Category.LineAlt.Button_Hover		= GWEN.TextureColor( 4 + 8 * 24, 500 )
	SKIN.Colours.Category.LineAlt.Button_Selected	= GWEN.TextureColor( 4 + 8 * 25, 500 )
	
	SKIN.Colours.TooltipText = GWEN.TextureColor( 4 + 8 * 26, 500 )
	SKIN.tex.Input = {}
	SKIN.tex.Input.ComboBox = {}
	SKIN.tex.Input.ComboBox.Normal		= GWEN.CreateTextureBorder( 384, 336,	127, 31, 8, 8, 32, 8 )
	SKIN.tex.Input.ComboBox.Hover		= GWEN.CreateTextureBorder( 384, 336+32, 127, 31, 8, 8, 32, 8 )
	SKIN.tex.Input.ComboBox.Down		= GWEN.CreateTextureBorder( 384, 336+64, 127, 31, 8, 8, 32, 8 )
	SKIN.tex.Input.ComboBox.Disabled	= GWEN.CreateTextureBorder( 384, 336+96, 127, 31, 8, 8, 32, 8 )
	
	SKIN.tex.Input.ComboBox.Button = {}
	SKIN.tex.Input.ComboBox.Button.Normal	= GWEN.CreateTextureNormal( 496, 272, 15, 15 )
	SKIN.tex.Input.ComboBox.Button.Hover	= GWEN.CreateTextureNormal( 496, 272+16, 15, 15 )
	SKIN.tex.Input.ComboBox.Button.Down		= GWEN.CreateTextureNormal( 496, 272+32, 15, 15 )
	SKIN.tex.Input.ComboBox.Button.Disabled	= GWEN.CreateTextureNormal( 496, 272+48, 15, 15 )
	
	SKIN.tex.Input.UpDown = {}
	SKIN.tex.Input.UpDown.Up = {}
	SKIN.tex.Input.UpDown.Up.Normal		= GWEN.CreateTextureCentered( 384,		112, 7, 7 )
	SKIN.tex.Input.UpDown.Up.Hover		= GWEN.CreateTextureCentered( 384+8,	112, 7, 7 )
	SKIN.tex.Input.UpDown.Up.Down		= GWEN.CreateTextureCentered( 384+16,	112, 7, 7 )
	SKIN.tex.Input.UpDown.Up.Disabled	= GWEN.CreateTextureCentered( 384+24,	112, 7, 7 )
	
	SKIN.tex.Input.UpDown.Down = {}
	SKIN.tex.Input.UpDown.Down.Normal	= GWEN.CreateTextureCentered( 384,		120, 7, 7 )
	SKIN.tex.Input.UpDown.Down.Hover	= GWEN.CreateTextureCentered( 384+8,	120, 7, 7 )
	SKIN.tex.Input.UpDown.Down.Down		= GWEN.CreateTextureCentered( 384+16,	120, 7, 7 )
	SKIN.tex.Input.UpDown.Down.Disabled	= GWEN.CreateTextureCentered( 384+24,	120, 7, 7 )
	
	SKIN.tex.Input.Slider = {}
	SKIN.tex.Input.Slider.H = {}
	SKIN.tex.Input.Slider.H.Normal		= GWEN.CreateTextureNormal( 416, 32,	15, 15 )
	SKIN.tex.Input.Slider.H.Hover		= GWEN.CreateTextureNormal( 416, 32+16, 15, 15 )
	SKIN.tex.Input.Slider.H.Down		= GWEN.CreateTextureNormal( 416, 32+32, 15, 15 )
	SKIN.tex.Input.Slider.H.Disabled	= GWEN.CreateTextureNormal( 416, 32+48, 15, 15 )
	
	SKIN.tex.Input.Slider.V = {}
	SKIN.tex.Input.Slider.V.Normal		= GWEN.CreateTextureNormal( 416+16, 32, 15, 15 )
	SKIN.tex.Input.Slider.V.Hover		= GWEN.CreateTextureNormal( 416+16, 32+16, 15, 15 )
	SKIN.tex.Input.Slider.V.Down		= GWEN.CreateTextureNormal( 416+16, 32+32, 15, 15 )
	SKIN.tex.Input.Slider.V.Disabled	= GWEN.CreateTextureNormal( 416+16, 32+48, 15, 15 )
	
	SKIN.tex.Input.ListBox = {}
	SKIN.tex.Input.ListBox.Background		= GWEN.CreateTextureBorder( 256, 256, 63, 127, 8, 8, 8, 8 )
	SKIN.tex.Input.ListBox.Hovered			= GWEN.CreateTextureBorder( 320, 320, 31, 31, 8, 8, 8, 8 )
	SKIN.tex.Input.ListBox.EvenLine			= GWEN.CreateTextureBorder( 352, 256, 31, 31, 8, 8, 8, 8 )
	SKIN.tex.Input.ListBox.OddLine			= GWEN.CreateTextureBorder( 352, 288, 31, 31, 8, 8, 8, 8 )
	SKIN.tex.Input.ListBox.EvenLineSelected	= GWEN.CreateTextureBorder( 320, 256, 31, 31, 8, 8, 8, 8 )
	SKIN.tex.Input.ListBox.OddLineSelected	= GWEN.CreateTextureBorder( 320, 288, 31, 31, 8, 8, 8, 8 )
	
	
	function SKIN:PaintFrame(panel)
		local iw, ih = 611, 382
		local w, h = panel:GetWide(), panel:GetTall()
		local iratio = w/iw
		local titlePos = 38 * iratio
		--nut.util.drawBlur(panel, 10)

		--surface.SetDrawColor(45, 45, 45, 200)
		--surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())

		--surface.SetDrawColor(nut.config.get("color"))
		--surface.DrawRect(0, 0, panel:GetWide(), 24)
		surface.SetDrawColor(255,255,255,255)
		local old = DisableClipping( true )
		surface.SetMaterial(Material('sky/panel_bg.png'))
		surface.DrawTexturedRect(0, -5, w, h+5)
		
		--surface.SetDrawColor(Color(107, 85, 66))
		--surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall(), 2)
		--top/bottom
		surface.SetMaterial(Material('sky/tp/tops.png'))
		surface.DrawTexturedRect(0, -5, w, 4)
		surface.DrawTexturedRectRotated(w*0.5, h-2, w, 4, 180)
		

		--left/right caps
	 	surface.SetMaterial(Material('sky/tp/lcap.png'))
		surface.DrawTexturedRect(0, 0, 4, h)
		surface.DrawTexturedRectRotated(w-2, h*0.5, 4, h, 180)
		DisableClipping( old )


	end

	function SKIN:DrawGenericBackground(x, y, w, h)
		surface.SetDrawColor(45, 45, 45, 240)
		surface.DrawRect(x, y, w, h)

		surface.SetDrawColor(0, 0, 0, 180)
		surface.DrawOutlinedRect(x, y, w, h)

		surface.SetDrawColor(100, 100, 100, 25)
		surface.DrawOutlinedRect(x + 1, y + 1, w - 2, h - 2)
	end

	function SKIN:PaintPanel(panel)
		if (not panel.m_bBackground) then return end
		if (panel.GetPaintBackground and not panel:GetPaintBackground()) then
			return
		end

		local w, h = panel:GetWide(), panel:GetTall()

		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawRect(0, 0, w, h)
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	function SKIN:PaintButton(panel)
		if (not panel.m_bBackground) then return end
		if (panel.GetPaintBackground and not panel:GetPaintBackground()) then
			return
		end

		local w, h = panel:GetWide(), panel:GetTall()
		local alpha = 50

		if (panel:GetDisabled()) then
			alpha = 10
		elseif (panel.Depressed) then
			alpha = 180
		elseif (panel.Hovered) then
			alpha = 75
		end

		surface.SetDrawColor(30, 30, 30, alpha)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(0, 0, 0, 180)
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.SetDrawColor(180, 180, 180, 2)
		surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
	end
    
	--[[---------------------------------------------------------
		VScrollBar
	-----------------------------------------------------------]]
	function SKIN:PaintVScrollBar( panel, w, h )

		draw.RoundedBox(10, 0, 0, w, h, Color(80,80,80, 100))

	end

	--[[---------------------------------------------------------
		ScrollBarGrip
	-----------------------------------------------------------]]
	function SKIN:PaintScrollBarGrip( panel, w, h )

		if ( panel:GetDisabled() ) then
			return draw.RoundedBox(0, 0, 0, w, h, Color(121,44,41, 100))
		end

		if ( panel.Depressed ) then
			return draw.RoundedBox(0, 0, 0, w, h, Color(47,158,97, 100))
		end

		if ( panel.Hovered ) then
			return draw.RoundedBox(0, 0, 0, w, h, Color(173,173,173, 100))
		end

		return draw.RoundedBox(0, 0, 0, w, h, Color(112,112,112, 100))

	end

	--[[---------------------------------------------------------
		ButtonDown
	-----------------------------------------------------------]]
	function SKIN:PaintButtonDown( panel, w, h )

		if ( !panel.m_bBackground ) then return end

		if ( panel.Depressed || panel:IsSelected() ) then
			return draw.RoundedBoxEx(10, 0, 0, w, h, Color(47,158,97, 100), false, false, true, true)
		end

		if ( panel:GetDisabled() ) then
			return draw.RoundedBoxEx(10, 0, 0, w, h, Color(121,44,41, 100), false, false, true, true)
		end

		if ( panel.Hovered ) then
			return draw.RoundedBoxEx(10, 0, 0, w, h, Color(173,173,173, 100), false, false, true, true)
		end

		draw.RoundedBoxEx(10, 0, 0, w, h, Color(112,112,112, 100), false, false, true, true)

	end

	--[[---------------------------------------------------------
		ButtonUp
	-----------------------------------------------------------]]
	function SKIN:PaintButtonUp( panel, w, h )

		if ( !panel.m_bBackground ) then return end

		if ( panel.Depressed || panel:IsSelected() ) then
			return draw.RoundedBoxEx(10, 0, 0, w, h, Color(47,158,97, 100), true, true, false, false)
		end

		if ( panel:GetDisabled() ) then
			return draw.RoundedBoxEx(10, 0, 0, w, h, Color(121,44,41, 100), true, true, false, false)
		end

		if ( panel.Hovered ) then
			return draw.RoundedBoxEx(10, 0, 0, w, h, Color(173,173,173, 100), true, true, false, false)
		end

		draw.RoundedBoxEx(10, 0, 0, w, h, Color(112,112,112, 100), true, true, false, false)

	end
    --[[---------------------------------------------------------
	Close Button
	-----------------------------------------------------------]]
	function SKIN:PaintWindowCloseButton( panel, w, h )

		if ( !panel.m_bBackground ) then return end

		if ( panel:GetDisabled() ) then
			surface.SetMaterial(Material('sky/dermaelm/exitdis.png'))
			return surface.DrawTexturedRect(0, 0, h, h)
		end

		if ( panel.Depressed || panel:IsSelected() ) then
			surface.SetMaterial(Material('sky/dermaelm/exitdep.png'))
			return surface.DrawTexturedRect(0, 2, h, h)
		end

		if ( panel.Hovered ) then
			surface.SetMaterial(Material('sky/dermaelm/exit.png'))
			return surface.DrawTexturedRect(0, 0, h, h)
		end

		surface.SetMaterial(Material('sky/dermaelm/exit.png'))
		return surface.DrawTexturedRect(0, 0, h, h)

	end

	--------------------
	--CAT VIEW
	--------------------
	function SKIN:PaintListBox( panel, w, h )
	
	end

	function SKIN:PaintCollapsibleCategory( panel, w, h )
		--if ( !panel.m_bBackground ) then return end
		
		if ( h <= panel:GetHeaderHeight() ) then
			-- TL TR BL BR (roundedboxex)

			--closed button
			draw.RoundedBoxEx(8, 0, 0, w, h, Color(100, 100, 100, 180), true, true, true, true )
	
			-- Little hack, draw the ComboBox's dropdown arrow to tell the player the category is collapsed and not empty
			if ( !panel:GetExpanded() ) then self.tex.Input.ComboBox.Button.Down( w - 18, h / 2 - 8, 15, 15 ) end
			return
		end
	
		--open buttons
		draw.RoundedBoxEx(8, 0, 0, w, h, Color(100, 100, 100, 180), true, true, false, false )
		--draw.RoundedBoxEx(8, 0, panel:GetHeaderHeight(), w, h - panel:GetHeaderHeight(), Color(200, 100, 100, 100), true, true, true, true )
		--self.tex.CategoryList.Inner( 0, panel:GetHeaderHeight(), w, h - panel:GetHeaderHeight() )
	
	end
	
	function SKIN:PaintCategoryList( panel, w, h )
	
		--self.tex.CategoryList.Outer( 0, 0, w, h, panel:GetBackgroundColor() )
	
	end
	
	function SKIN:PaintCategoryButton( panel, w, h )
	
		if ( panel.AltLine ) then
	
			if ( panel.Depressed || panel.m_bSelected ) then surface.SetDrawColor( self.Colours.Category.LineAlt.Button_Selected )
			elseif ( panel.Hovered ) then surface.SetDrawColor( self.Colours.Category.LineAlt.Button_Hover )
			else surface.SetDrawColor( self.Colours.Category.LineAlt.Button ) end
	
		else
	
			if ( panel.Depressed || panel.m_bSelected ) then surface.SetDrawColor( self.Colours.Category.Line.Button_Selected )
			elseif ( panel.Hovered ) then surface.SetDrawColor( self.Colours.Category.Line.Button_Hover )
			else surface.SetDrawColor( self.Colours.Category.Line.Button ) end
	
		end
	
		surface.DrawRect( 0, 0, w, h )
	
	end


	--------------------
	--TOOLTIP
	--------------------
	-- function SKIN:PaintTooltip( panel, w, h )

	-- 	surface.SetMaterial(Material('sky/tooltip.png'))
	-- 	surface.DrawTexturedRect(0, 0, w, h)

	
	-- end


	-- I don't think we gonna need minimize button and maximize button.
	function SKIN:PaintWindowMinimizeButton(panel, w, h)
	end

	function SKIN:PaintWindowMaximizeButton(panel, w, h)
	end
derma.DefineSkin("stalker", "Stalker Themed UI", SKIN)
derma.RefreshSkins()
