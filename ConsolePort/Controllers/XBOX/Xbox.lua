local _, db = ...
---------------------------------------------------------------
if not db.Controllers then db.Controllers = {} end
---------------------------------------------------------------
---------------------------------------------------------------
--[[ Xbox One Controller template by Munk
---------------------------------------------------------------

Color:
	Hex color codes for the right hand action buttons.
	Used to color text and tint spell effect on cursor.

Settings:
	Default controller settings that should be applied when
	loading the template, but may be customized afterwards.

Layout:
	The config binding layout to correctly align each button
	with its corresponding spot in the controller blueprint.

Bindings:
	Default bindings for each controller button.

]]-------------------------------------------------------------

db.Controllers.XBOX = {
	Hint = 'Use WoWmapper to play the game with any type of Xbox controller.',
	Color = {
		['UP'] 			= 	'FFE74F',
		['LEFT'] 		= 	'00A2FF',
		['RIGHT']		= 	'FA4451',
		['DOWN'] 		= 	'52C14E',
	},
	Settings = {
		['CP_M1'] 		= 'CP_TL2',
		['CP_M2'] 		= 'CP_TR2',
		['CP_T1'] 		= 'CP_TL1',
		['CP_T2'] 		= 'CP_TR1',
		-------------------------------
		['skipGuideBtn'] = false,
		-------------------------------
		['interactWith'] = 'CP_T1',
		['mouseOverMode'] = true,
		-------------------------------
	},
	Layout = {
		['CP_TL1']		= {index = 1, anchor = 'LEFT'},
		['CP_TL2']		= {index = 2, anchor = 'LEFT'},
		['CP_T_L3'] 	= {index = 3, anchor = 'LEFT'},
		['CP_L_UP']		= {index = 4, anchor = 'LEFT'},
		['CP_L_LEFT']	= {index = 5, anchor = 'LEFT'},
		['CP_L_DOWN']	= {index = 6, anchor = 'LEFT'},
		['CP_L_RIGHT']	= {index = 7, anchor = 'LEFT'},
		['CP_X_LEFT']	= {index = 8, anchor = 'LEFT'},
		-------------------------------------------------
		['CP_TR1']		= {index = 1, anchor = 'RIGHT'},
		['CP_TR2']		= {index = 2, anchor = 'RIGHT'},
		['CP_R_UP']		= {index = 3, anchor = 'RIGHT'},
		['CP_R_RIGHT']	= {index = 4, anchor = 'RIGHT'},
		['CP_R_DOWN']	= {index = 5, anchor = 'RIGHT'},
		['CP_R_LEFT']	= {index = 6, anchor = 'RIGHT'},
		['CP_T_R3'] 	= {index = 7, anchor = 'RIGHT'},
		['CP_X_RIGHT']	= {index = 8, anchor = 'RIGHT'},
		-------------------------------------------------
		['CP_X_CENTER'] = {index = 3, anchor = 'CENTER'},
		-------------------------------------------------
	},
	Bindings = {
		-- XYAB
		['CP_R_UP'] = 	{
			['']		 	= 'ACTIONBUTTON2',
			['SHIFT-'] 		= 'ACTIONBUTTON7',
			['CTRL-'] 		= 'MULTIACTIONBAR1BUTTON2',
			['CTRL-SHIFT-'] = 'MULTIACTIONBAR1BUTTON7',
		},
		['CP_R_DOWN'] = {
			['']		 	= 'JUMP',
			['SHIFT-'] 		= 'TARGETNEARESTENEMY',
			['CTRL-']  		= 'INTERACTMOUSEOVER',
			['CTRL-SHIFT-'] = 'CLICK ConsolePortUtilityToggle:LeftButton',
		},
		['CP_R_LEFT'] = {
			['']		 	= 'ACTIONBUTTON1',
			['SHIFT-'] 		= 'ACTIONBUTTON6',
			['CTRL-'] 		= 'MULTIACTIONBAR1BUTTON1',
			['CTRL-SHIFT-'] = 'MULTIACTIONBAR1BUTTON6',
		},
		['CP_R_RIGHT'] = {
			['']		 	= 'ACTIONBUTTON3',
			['SHIFT-'] 		= 'ACTIONBUTTON8',
			['CTRL-'] 		= 'MULTIACTIONBAR1BUTTON3',
			['CTRL-SHIFT-'] = 'MULTIACTIONBAR1BUTTON8',
		},
		-- Trigger buttons
		['CP_T1'] =	{
			['']		 	= 'ACTIONBUTTON4',
			['SHIFT-'] 		= 'ACTIONBUTTON9',
			['CTRL-'] 		= 'MULTIACTIONBAR1BUTTON4',
			['CTRL-SHIFT-'] = 'MULTIACTIONBAR1BUTTON9',
		},
		['CP_T2'] = 	{
			['']		 	= 'ACTIONBUTTON5',
			['SHIFT-'] 		= 'ACTIONBUTTON10',
			['CTRL-'] 		= 'MULTIACTIONBAR1BUTTON5',
			['CTRL-SHIFT-'] = 'MULTIACTIONBAR1BUTTON10',
		},
		-- D-Pad
		['CP_L_UP'] = {
			['']		 	= 'MULTIACTIONBAR1BUTTON12',
			['SHIFT-'] 		= 'MULTIACTIONBAR2BUTTON2',
			['CTRL-'] 		= 'MULTIACTIONBAR2BUTTON6',
			['CTRL-SHIFT-'] = 'MULTIACTIONBAR2BUTTON10',
		},
		['CP_L_DOWN'] = {
			['']		 	= 'ACTIONBUTTON11',
			['SHIFT-'] 		= 'MULTIACTIONBAR2BUTTON4',
			['CTRL-']  		= 'MULTIACTIONBAR2BUTTON8',
			['CTRL-SHIFT-']	= 'MULTIACTIONBAR2BUTTON12',
		},
		['CP_L_LEFT'] = {
			['']		 	= 'MULTIACTIONBAR1BUTTON11',
			['SHIFT-'] 		= 'MULTIACTIONBAR2BUTTON1',
			['CTRL-'] 		= 'MULTIACTIONBAR2BUTTON5',
			['CTRL-SHIFT-'] = 'MULTIACTIONBAR2BUTTON9',
		},
		['CP_L_RIGHT'] = {
			['']		 	= 'ACTIONBUTTON12',
			['SHIFT-'] 		= 'MULTIACTIONBAR2BUTTON3',
			['CTRL-'] 		= 'MULTIACTIONBAR2BUTTON7',
			['CTRL-SHIFT-'] = 'MULTIACTIONBAR2BUTTON11',
		},
		-- Center buttons
		['CP_X_LEFT'] = {
			['']		 	= 'OPENALLBAGS',
			['SHIFT-'] 		= 'TOGGLEWORLDMAP',
			['CTRL-'] 		= 'CP_CAMZOOMOUT',
			['CTRL-SHIFT-'] = 'CP_CAMZOOMIN',
		},
		['CP_X_CENTER'] = {
			['']		 	= 'TOGGLECHARACTER0',
			['SHIFT-'] 		= 'TOGGLESPELLBOOK',
			['CTRL-'] 		= 'TOGGLETALENTS',
			['CTRL-SHIFT-'] = 'CLICK ConsolePortNameplateCycle:LeftButton',
		},
		['CP_X_RIGHT'] = {
			['']		 	= 'TOGGLEGAMEMENU',
			['SHIFT-'] 		= 'TOGGLEAUTORUN',
			['CTRL-'] 		= 'CLICK ConsolePortRaidCursorToggle:LeftButton',
			['CTRL-SHIFT-'] = 'OPENCHAT',
		},		
		-- Stick buttons
		['CP_T_R3'] = {},
		['CP_T_L3'] = {},
	},
}