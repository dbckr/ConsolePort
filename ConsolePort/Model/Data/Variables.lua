-- Consts
local STICK_SELECT = {'Movement', 'Camera'};
local MODID_SELECT = {'SHIFT', 'CTRL', 'ALT'};
local MODID_EXTEND = {'SHIFT', 'CTRL', 'ALT', 'CTRL-SHIFT', 'ALT-SHIFT', 'ALT-CTRL'};
local ADVANCED_OPT = RED_FONT_COLOR:WrapTextInColorCode(ADVANCED_OPTIONS);
local INTERACT_OPT = UNIT_FRAME_DROPDOWN_SUBSECTION_TITLE_INTERACT;

local unpack, __, db = unpack, ...; __ = 1;
setfenv(__, setmetatable(db('Data'), {__index = _G}));
------------------------------------------------------------------------------------------------------------
-- Default cvar data (global)
------------------------------------------------------------------------------------------------------------
db:Register('Variables', {
	--------------------------------------------------------------------------------------------------------
	-- Crosshair:
	--------------------------------------------------------------------------------------------------------
	crosshairEnable = {Bool(true);
		head = 'Crosshair';
		sort = 1;
		name = 'Enable';
		desc = 'Enables a crosshair to reveal your hidden center cursor position at all times.';
		note = 'Use together with [@cursor] macros to place reticle spells in a single click.';
	};
	crosshairSizeX = {Number(24, 1, true);
		head = 'Crosshair';
		sort = 2;
		name = 'Width';
		desc = 'Width of the crosshair, in scaled pixel units.';
	};
	crosshairSizeY = {Number(24, 1, true);
		head = 'Crosshair';
		sort = 3;
		name = 'Height';
		desc = 'Height of the crosshair, in scaled pixel units.';
	};
	crosshairCenter = {Number(0.2, 0.05, true);
		head = 'Crosshair';
		sort = 4;
		name = 'Center Gap';
		desc = 'Center gap, as fraction of overall crosshair size.';
	};
	crosshairThickness = {Number(2, 0.025, true);
		head = 'Crosshair';
		sort = 5;
		name = 'Thickness';
		desc = 'Thickness in scaled pixel units.';
		note = 'Value below two may appear interlaced or not at all.';
	};
	crosshairColor = {Color('ff00fcff');
		head = 'Crosshair';
		sort = 6;
		name = 'Color';
		desc = 'Color of the crosshair.';
	};
	--------------------------------------------------------------------------------------------------------
	-- Interact button:
	--------------------------------------------------------------------------------------------------------
	interactButton = {Button('PADRSHOULDER', true):Set('none', true);
		head = INTERACT_OPT;
		sort = 1;
		name = 'Interact Button';
		desc = 'Button or combination used to interact for a given condition. By default, interacts using centered cursor.';
		note = 'Use a shoulder button combined with crosshair for smooth and precise interactions.';
	};
	interactCondition = {String('[vehicleui] nil; [@target,noharm][@target,noexists][@target,harm,dead] TURNORACTION; nil');
		head = INTERACT_OPT;
		sort = 2;
		name = 'Interact Condition';
		desc = 'Macro condition to enable the interact button override.';
		note = 'Takes the format of...\n'
			.. BLUE_FONT_COLOR:WrapTextInColorCode('[condition] bindingID; nil')
			.. '\n...where each condition/binding is separated by a semicolon, and "nil" clears the override.';
	};
	--------------------------------------------------------------------------------------------------------
	-- Mouse:
	--------------------------------------------------------------------------------------------------------
	mouseHandlingEnabled = {Bool(true);
		head = MOUSE_LABEL;
		sort = 1;
		name = 'Enable Mouse Handling';
		desc = 'Enable custom mouse handling, overriding Blizzard defaults intended for use without addons.';
		note = 'While disabled, cursor timeout, and toggling between free-roaming and center-fixed cursor are also disabled.';
	};
	mouseFreeCursorReticle = {Bool(false);
		head = MOUSE_LABEL;
		sort = 2;
		name = 'Free Cursor Reticle Targeting';
		desc = 'Reticle targeting uses free cursor instead of center-fixed cursor.';
	};
	mouseHideCursorOnMovement = {Bool(false);
		head = MOUSE_LABEL;
		sort = 3;
		name = 'Hide Cursor On Movement';
		desc = 'Cursor hides when you start moving, if free of obstacles.';
		note = 'Requires Settings > Hide Cursor on Stick Input set to None.';
	};
	mouseAlwaysCentered = {Bool(false);
		head = MOUSE_LABEL;
		sort = 5;
		name = 'Always Show Mouse Cursor';
		desc = 'Always keep cursor centered and visible when controlling camera.';
	};
	mouseAutoClearCenter = {Number(2.0, 0.25);
		head = MOUSE_LABEL;
		sort = 6;
		name = 'Automatic Cursor Timeout';
		desc = 'Time in seconds to automatically hide centered cursor.';
	};
	doubleTapTimeout = {Number(0.25, 0.05, true);
		head = MOUSE_LABEL;
		sort = 7;
		name = 'Double Tap Timeframe';
		desc = 'Timeframe to toggle the mouse cursor when double-tapping a selected modifier.';
	};
	doubleTapModifier = {Select('<none>', '<none>', unpack(MODID_SELECT));
		head = MOUSE_LABEL;
		sort = 8;
		name = 'Double Tap Modifier';
		desc = 'Which modifier to use to toggle the mouse cursor when double-tapped.';
	};
	--------------------------------------------------------------------------------------------------------
	-- Radial:
	--------------------------------------------------------------------------------------------------------
	radialClearFocusTime = {Number(0.5, 0.025);
		head = 'Radial Menus';
		sort = 1;
		name = 'Radial Focus Timeout';
		desc = 'Time to clear focus after intercepting stick input, in seconds.';
	};
	radialScale = {Number(1, 0.025, true);
		head = 'Radial Menus';
		sort = 2;
		name = 'Ring Scale';
		desc = 'Scale of all radial menus, relative to UI scale.';
	};
	radialActionDeadzone = {Range(0.5, 0.05, 0, 1);
		head = 'Radial Menus';
		sort = 3;
		name = 'Radial Deadzone';
		desc = 'Deadzone for simple pie menus.';
	};
	radialCosineDelta = {Delta(1);
		head = 'Radial Menus';
		sort = 5;
		name = 'Axis Interpretation';
		desc = 'Correlation between stick position and pie selection.';
		note = '+ Normal\n- Inverted';
	};
	radialPrimaryStick = {Select('Movement', unpack(STICK_SELECT));
		head = 'Radial Menus';
		sort = 6;
		name = 'Primary Stick';
		desc = 'Stick to use for main radial actions.';
		note = 'Make sure your choice does not conflict with your bindings.';
	};
	radialRemoveButton = {Button('PADRSHOULDER');
		head = 'Radial Menus';
		sort = 8;
		name = 'Remove Button';
		desc = 'Button used to remove a selected item from an editable pie menu.';
	};
	--------------------------------------------------------------------------------------------------------
	-- Raid cursor:
	--------------------------------------------------------------------------------------------------------
	raidCursorDirect = {Bool(false);
		head = 'Raid Cursor';
		sort = 1;
		name = 'Direct Targeting';
		desc = 'Change target each time the cursor is moved, instead of routing appropriate spells.';
		note = 'The cursor cannot route macros or ambiguous spells. Enable this if you use a lot of macros.';
	};
	raidCursorScale = {Number(1, 0.1);
		head = 'Raid Cursor';
		sort = 2;
		name = 'Scale';
		desc = 'Scale of the cursor.';
	};
	raidCursorModifier = {Select('<none>', '<none>', unpack(MODID_EXTEND));
		head = 'Raid Cursor';
		sort = 3;
		name = 'Modifier';
		desc = 'Which modifier to use with the directional pad to move the cursor.';
		note = 'The bindings underlying the button combinations will be unavailable while the cursor is in use.';
	};
	--------------------------------------------------------------------------------------------------------
	-- Interface cursor:
	--------------------------------------------------------------------------------------------------------
	UIenableCursor = {Bool(true);
		head = 'Interface Cursor';
		sort = 1;
		name = ENABLE;
		desc = 'Enable interface cursor. Disable to use mouse-based interface interaction.';
	};
	UIpointerDefaultIcon = {Bool(true);
		head = 'Interface Cursor';
		sort = 2;
		name = 'Show Default Button';
		desc = 'Show the default mouse action button.';
	};
	UIpointerAnimation = {Bool(true);
		head = 'Interface Cursor';
		sort = 3;
		name = 'Enable Animation';
		desc = 'Pointer arrow rotates in the direction of travel.';
	};
	UIaccessUnlimited = {Bool(false);
		head = 'Interface Cursor';
		sort = 4;
		name = 'Unlimited Navigation';
		desc = 'Allow cursor to interact with the entire interface, not only panels.';
		note = 'Combine with use on demand for full cursor control.';
	};
	UIshowOnDemand = {Bool(false);
		head = 'Interface Cursor';
		sort = 5;
		name = 'Use On Demand';
		desc = 'Cursor appears on demand, instead of in response to a panel showing up.';
		note = 'Requires Toggle Interface Cursor binding & Unlimited Navigation to use the cursor.';
	};
	UIholdRepeatDisable = {Bool(false);
		head = 'Interface Cursor';
		sort = 6;
		name = 'Disable Repeated Movement';
		desc = 'Disable repeated cursor movements - each click will only move the cursor once.';
	};
	UIholdRepeatDelay = {Number(.125, 0.025);
		head = 'Interface Cursor';
		sort = 7;
		name = 'Repeated Movement Delay';
		desc = 'Delay until a movement is repeated, when holding down a direction, in seconds.';
	};
	UIleaveCombatDelay = {Number(0.5, 0.1);
		head = 'Interface Cursor';
		sort = 8;
		name = 'Reactivation Delay';
		desc = 'Delay before reactivating interface cursor after leaving combat, in seconds.';
	};
	UIpointerSize = {Number(22, 2, true);
		head = 'Interface Cursor';
		sort = 9;
		name = 'Pointer Size';
		desc = 'Size of pointer arrow, in pixels.';
	};
	UIpointerOffset = {Number(-2, 1);
		head = 'Interface Cursor';
		sort = 10;
		name = 'Pointer Offset';
		desc = 'Offset of pointer arrow, from the selected node center, in pixels.';
	};
	UItravelTime = {Range(4, 1, 1, 10);
		head = 'Interface Cursor';
		sort = 11;
		name = 'Travel Time';
		desc = 'How long the cursor should take to transition from one node to another.';
		note = 'Higher is slower.';
	};
	UICursorLeftClick = {Button('PAD1');
		head = 'Interface Cursor';
		sort = 12;
		name = KEY_BUTTON1;
		desc = 'Button to replicate left click. This is the primary interface action.';
		note = 'While held down, can simulate dragging by clicking on the directional pad.';
	};
	UICursorRightClick = {Button('PAD2');
		head = 'Interface Cursor';
		sort = 13;
		name = KEY_BUTTON2;
		desc = 'Button to replicate right click. This is the secondary interface action.';
		note = 'This button is necessary to use or sell an item directly from your bags.';
	};
	UICursorSpecial = {Button('PAD4');
		head = 'Interface Cursor';
		sort = 14;
		name = 'Special Button';
		desc = 'Button to handle special actions, such as adding items to the utility ring.';
	};
	UImodifierCommands = {Select('SHIFT', unpack(MODID_SELECT));
		head = 'Interface Cursor';
		sort = 15;
		name = 'Modifier';
		desc = 'Which modifier to use for modified commands';
		note = 'The modifier can be used to scroll together with the directional pad.';
		opts = MODID_SELECT;
	};
	--------------------------------------------------------------------------------------------------------
	-- Unit hotkeys:
	--------------------------------------------------------------------------------------------------------
	unitHotkeyGhostMode = {Bool(false);
		head = 'Unit Hotkeys';
		sort = 1;
		name = 'Always Show';
		desc = 'Hotkey prompts linger on unit frames after targeting.';
	};
	unitHotkeyIgnorePlayer = {Bool(false);
		head = 'Unit Hotkeys';
		sort = 2;
		name = 'Ignore Player';
		desc = 'Always ignore player, regardless of unit pool.';
	};
	unitHotkeySize = {Number(32, 1);
		head = 'Unit Hotkeys';
		sort = 3;
		name = 'Size';
		desc = 'Size of unit hotkeys (px)';
	};
	unitHotkeyOffsetX = {Number(0, 1, true);
		head = 'Unit Hotkeys';
		sort = 4;
		name = 'Horizontal Offset';
		desc = 'Horizontal offset of the hotkey prompt position, in pixels.';
	};
	unitHotkeyOffsetY = {Number(0, 1, true);
		head = 'Unit Hotkeys';
		sort = 5;
		name = 'Vertical Offset';
		desc = 'Vertical offset of the hotkey prompt position, in pixels.';
	};
	unitHotkeyPool = {String('player$;party%d$;raid%d+$');
		head = 'Unit Hotkeys';
		sort = 6;
		name = 'Unit Pool';
		desc = 'Match criteria for unit pool, each type separated by semicolon.';
		note = '$: end of match token\n+: matches multiple tokens\n%d: matches number';
	};
	--------------------------------------------------------------------------------------------------------
	-- Misc:
	--------------------------------------------------------------------------------------------------------
	autoExtra = {Bool(true);
		head = ACCESSIBILITY_LABEL;
		sort = 1;
		name = 'Automatically Bind Extra Items';
		desc = 'Automatically add tracked quest items and extra spells to main utility ring.';
	};
	autoSellJunk = {Bool(true);
		head = ACCESSIBILITY_LABEL;
		sort = 2;
		name = 'Automatically Sell Junk';
		desc = 'Automatically sell junk when interacting with a merchant.';
	};
	showAbilityBriefing = {Bool(true);
		head = ACCESSIBILITY_LABEL;
		sort = 3;
		name = 'Show Ability Briefings';
		desc = 'Displays a briefing for newly acquired abilities.';
		note = 'Requires ConsolePort World.';
	};
	mouseFollowOnStickMounted = {Bool(false);
		head = ACCESSIBILITY_LABEL;
		sort = 4;
		name = 'Follow On Stick While Mounted';
		desc = 'Sets your camera to "follow on a stick" when you are mounted.';
		note = 'Enable Settings > Camera > Follow On A Stick instead of this option if this is your preferred permanent camera style.';
	};
	UIscale = {Number(1, 0.025, true);
		head = ACCESSIBILITY_LABEL;
		sort = 5;
		name = 'Global Scale';
		desc = 'Scale of most ConsolePort frames, relative to UI scale.';
		note = 'Action bar is scaled separately.';
	};
	--------------------------------------------------------------------------------------------------------
	-- Advanced:
	--------------------------------------------------------------------------------------------------------
	bindingOverlapEnable = {Bool(false);
		head = ADVANCED_OPT;
		sort = 1;
		name = 'Allow Binding Overlap';
		desc = 'Allow binding multiple combos to the same binding.'
	};
	bindingAllowSticks = {Bool(false);
		head = ADVANCED_OPT;
		sort = 2;
		name = 'Allow Radial Bindings';
		desc = 'Allow binding discrete radial stick inputs.';
	};
	bindingShowExtraBars = {Bool(false);
		head = ADVANCED_OPT;
		sort = 3;
		name = 'Show All Action Bars';
		desc = 'Show bonus bar configuration for characters without stances.'
	};
	disableHotkeyRendering = {Bool(false);
		head = ADVANCED_OPT;
		sort = 4;
		name = 'Disable Hotkey Rendering';
		desc = 'Disables customization to hotkeys on regular action bar.'
	};
	actionPageCondition = {String(nil);
		head = ADVANCED_OPT;
		sort = 5;
		name = 'Action Page Condition';
		desc = 'Macro condition to evaluate action bar page.';
	};
	actionPageResponse = {String(nil);
		head = ADVANCED_OPT;
		sort = 6;
		name = 'Action Page Response';
		desc = 'Response to condition for custom processing.'
	};
	classFileOverride = {String(nil);
		head = ADVANCED_OPT;
		sort = 7;
		name = 'Override Class File';
		desc = 'Override class theme for interface styling.';
	};
})  --------------------------------------------------------------------------------------------------------
