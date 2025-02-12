local _, env = ...;
local FadeIn, FadeOut = env.db.Alpha.FadeIn, env.db.Alpha.FadeOut;

-------------------------------------------
---		Watch bar container
-------------------------------------------
local WBC = env.bar.WatchBarContainer

WBC.BGLeft = WBC:CreateTexture(nil, 'BACKGROUND')
WBC.BGLeft:SetPoint('TOPLEFT')
WBC.BGLeft:SetPoint('BOTTOMRIGHT', WBC, 'BOTTOM', 0, 0)
WBC.BGLeft:SetColorTexture(0, 0, 0, 1)
WBC.BGLeft:SetGradientAlpha('HORIZONTAL', 0, 0, 0, 0, 0, 0, 0, 1)

WBC.BGRight = WBC:CreateTexture(nil, 'BACKGROUND')
WBC.BGRight:SetPoint('TOPRIGHT')
WBC.BGRight:SetPoint('BOTTOMLEFT', WBC, 'BOTTOM', 0, 0)
WBC.BGRight:SetColorTexture(0, 0, 0, 1)
WBC.BGRight:SetGradientAlpha('HORIZONTAL', 0, 0, 0, 1, 0, 0, 0, 0)

local MAX_BARS_VISIBLE = 2

function WBC:SetTextLocked(isLocked)
	if ( self.textLocked ~= isLocked ) then
		self.textLocked = isLocked
		self:UpdateBarVisibility() 
	end
end

function WBC:GetNumberVisibleBars()
	local numVisBars = 0 
	for i, bar in ipairs(self.bars) do
		if (bar:ShouldBeVisible()) then
			numVisBars = numVisBars + 1
		end
	end	
	return math.min(MAX_BARS_VISIBLE, numVisBars) 
end

function WBC:IsTextLocked()
	return self.textLocked
end	

function WBC:UpdateBarVisibility()
	for i, bar in ipairs(self.bars) do
		if(bar:ShouldBeVisible()) then
			bar:UpdateTextVisibility()
		end
	end	
end

function WBC:SetBarAnimation(Animation)
	for i, bar in ipairs(self.bars) do
		bar.StatusBar:SetDeferAnimationCallback(Animation) 
	end
end

function WBC:UpdateBarTicks()
	for i, bar in ipairs(self.bars) do
		if(bar:ShouldBeVisible()) then
			bar:UpdateTick()
		end
	end
end

function WBC:ShowVisibleBarText()
	for i, bar in ipairs(self.bars) do
		if(bar:ShouldBeVisible()) then
			bar:ShowText()
		end
	end
end

function WBC:HideVisibleBarText()
	for i, bar in ipairs(self.bars) do
		if(bar:ShouldBeVisible()) then
			bar:HideText()
		end
	end
end

function WBC:SetBarSize(largeSize)
	self.largeSize = largeSize 
	self:UpdateBarsShown() 
end

function WBC:UpdateBarsShown()
	local visibleBars = {}
	for i, bar in ipairs(self.bars) do
		if ( bar:ShouldBeVisible() ) then
			table.insert(visibleBars, bar)
		end
	end
		
	table.sort(visibleBars, function(left, right) return left:GetPriority() < right:GetPriority() end)
	self:LayoutBars(visibleBars) 
end

function WBC:HideStatusBars()
	self.SingleBarSmall:Hide() 
	self.SingleBarLarge:Hide()
	self.SingleBarSmallUpper:Hide()
	self.SingleBarLargeUpper:Hide()
	for i, bar in ipairs(self.bars) do
		bar:Hide() 
	end
end

function WBC:SetInitialBarSize()
	self.barHeight = self.SingleBarLarge:GetHeight()
end 

function WBC:GetInitialBarHeight()
	return self.barHeight 
end

-- Sets the bar size depending on whether the bottom right multi-bar is shown. 
-- If the multi-bar is shown, a different texture needs to be displayed that is smaller. 
function WBC:SetDoubleBarSize(bar, width)
	local textureHeight = self:GetInitialBarHeight() 
	local statusBarHeight = textureHeight - 4 
	if( self.largeSize ) then 
		self.SingleBarLargeUpper:SetSize(width, statusBarHeight) 
		self.SingleBarLargeUpper:SetPoint('CENTER', bar, 0, 4)
		self.SingleBarLargeUpper:Show()
		
		self.SingleBarLarge:SetSize(width, statusBarHeight) 
		self.SingleBarLarge:SetPoint('CENTER', bar, 0, -9)
		self.SingleBarLarge:Show() 
	else		
		self.SingleBarSmallUpper:SetSize(width, statusBarHeight) 
		self.SingleBarSmallUpper:SetPoint('CENTER', bar, 0, 4)
		self.SingleBarSmallUpper:Show() 
		
		self.SingleBarSmall:SetSize(width, statusBarHeight) 
		self.SingleBarSmall:SetPoint('CENTER', bar, 0, -9)
		self.SingleBarSmall:Show() 
	end

	local progressWidth = width - self:GetEndCapWidth() * 2
	bar.StatusBar:SetSize(progressWidth, statusBarHeight)
	bar:SetSize(progressWidth, statusBarHeight)
end

--Same functionality as previous function except shows only one bar. 
function WBC:SetSingleBarSize(bar, width) 
	local textureHeight = self:GetInitialBarHeight()
	if( self.largeSize ) then  
		self.SingleBarLarge:SetSize(width, textureHeight) 
		self.SingleBarLarge:SetPoint('CENTER', bar, 0, 0)
		self.SingleBarLarge:Show() 
	else
		self.SingleBarSmall:SetSize(width, textureHeight) 
		self.SingleBarSmall:SetPoint('CENTER', bar, 0, 0)
		self.SingleBarSmall:Show() 
	end
	local progressWidth = width - self:GetEndCapWidth() * 2
	bar.StatusBar:SetSize(progressWidth, textureHeight)
	bar:SetSize(progressWidth, textureHeight)
end

function WBC:LayoutBar(bar, barWidth, isTopBar, isDouble)
	bar:Update() 
	bar:Show() 
		
	bar:ClearAllPoints()
	
	if ( isDouble ) then
		if ( isTopBar ) then
			bar:SetPoint('BOTTOM', self:GetParent(), 0, -10)
		else		
			bar:SetPoint('BOTTOM', self:GetParent(), 0, -19)
		end
		self:SetDoubleBarSize(bar, barWidth)
	else 
		bar:SetPoint('BOTTOM', self:GetParent(), 0, -14)
		self:SetSingleBarSize(bar, barWidth)
	end
end


function WBC:OnLoad()
	self.bars = {}

	for _, event in ipairs({
		'UPDATE_FACTION',
		'ENABLE_XP_GAIN',
		'DISABLE_XP_GAIN',
		'CVAR_UPDATE',
		'UPDATE_EXPANSION_LEVEL',
		'PLAYER_ENTERING_WORLD',
		'HONOR_XP_UPDATE',
		'ZONE_CHANGED',
		'ZONE_CHANGED_NEW_AREA',
		'UNIT_INVENTORY_CHANGED',
		'ARTIFACT_XP_UPDATE',
	}) do 
		pcall(self.RegisterEvent, self, event)
	end

	self:RegisterUnitEvent('UNIT_LEVEL', 'player')
	self:SetInitialBarSize()
	self:UpdateBarsShown()

	self:SetScript('OnShow', self.OnShow)
	self:SetScript('OnEvent', self.OnEvent)
end

function WBC:OnEvent(event)
	if ( event == 'CVAR_UPDATE' ) then
		self:UpdateBarVisibility()
	end	
	self:UpdateBarsShown() 
end

function WBC:OnShow()
	if env.cfg and env.cfg.watchbars then
		FadeIn(self, 0.2, self:GetAlpha(), 1)
	else
		self:SetAlpha(0)
	end
end

function WBC:GetEndCapWidth()
	return self.endCapWidth
end

function WBC:SetEndCapWidth(width)
	self.endCapWidth = width
end

local function BarColorOverride(self)
	if (env.cfg and env.cfg.expRGB) and (WBC.mainBar == self) then
		self:SetBarColorRaw(unpack(env.cfg.expRGB))
	end
end

function WBC:AddBarFromTemplate(frameType, template)
	local bar = CreateFrame(frameType, nil, self, template)
	table.insert(self.bars, bar)
	bar.StatusBar.Background:Hide()
	bar.StatusBar.BarTexture:SetTexture([[Interface\AddOns\ConsolePort_Bar\Textures\XPBar]])
	bar.SetBarColorRaw = bar.SetBarColor

	bar:HookScript('OnEnter', function()
		FadeIn(self, 0.2, self:GetAlpha(), 1)
	end)

	bar:HookScript('OnLeave', function()
		if (env.cfg and not env.cfg.watchbars) or not env.cfg then
			FadeOut(self, 0.2, self:GetAlpha(), 0)
		end
	end)

	bar:HookScript('OnShow', BarColorOverride)
	hooksecurefunc(bar, 'SetBarColor', BarColorOverride)

	self:UpdateBarsShown()
	return bar
end

function WBC:LayoutBar(bar, barWidth, isTopBar, isDouble)
	bar:Update()
	bar:Show()
	bar:ClearAllPoints()
	
	if ( isDouble ) then
		if ( isTopBar ) then
			bar:SetPoint('BOTTOM', self:GetParent(), 0, 14)
		else
			bar:SetPoint('BOTTOM', self:GetParent(), 0, 2)
		end
		self:SetDoubleBarSize(bar, barWidth)
	else 
		bar:SetPoint('BOTTOM', self:GetParent(), 0, 0)
		self:SetSingleBarSize(bar, barWidth)
	end
end

function WBC:SetMainBarColor(r, g, b)
	if self.mainBar then
		self.mainBar:SetBarColorRaw(r, g, b)
	end
end

function WBC:LayoutBars(visBars)
	local width = self:GetWidth()
	self:HideStatusBars()

	local TOP_BAR, IS_DOUBLE = true, true
	if ( #visBars > 1 ) then
		self:LayoutBar(visBars[1], width, not TOP_BAR, IS_DOUBLE)
		self:LayoutBar(visBars[2], width, TOP_BAR, IS_DOUBLE)
	elseif( #visBars == 1 ) then 
		self:LayoutBar(visBars[1], width, TOP_BAR, not IS_DOUBLE)
	end
	self.mainBar = visBars and visBars[1]
	self:UpdateBarTicks()
end

WBC:OnLoad()
WBC:AddBarFromTemplate('FRAME', 'CP_ReputationStatusBarTemplate')

if CPAPI.IsRetailVersion then
	WBC:AddBarFromTemplate('FRAME', 'HonorStatusBarTemplate')
	WBC:AddBarFromTemplate('FRAME', 'ArtifactStatusBarTemplate')
	WBC:AddBarFromTemplate('FRAME', 'AzeriteBarTemplate')
end

do 	local xpBar = WBC:AddBarFromTemplate('FRAME', 'CP_ExpStatusBarTemplate')
	--xpBar.ExhaustionLevelFillBar:SetTexture([[Interface\AddOns\ConsolePortBar\Textures\XPBar]])
end