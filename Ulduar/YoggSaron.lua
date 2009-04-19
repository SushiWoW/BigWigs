﻿----------------------------------
--      Module Declaration      --
----------------------------------

local sara = BB["Sara"]	--need the add name translated, maybe add to BabbleBoss.
local boss = BB["Yogg-Saron"]
local mod = BigWigs:New(boss, "$Revision$")
if not mod then return end
mod.zonename = BZ["Ulduar"]
mod.enabletrigger = {"sara", "boss"}
--Sara = 33134, Yogg brain = 33890, Corruptor Tentacle = 33985
mod.guid = 33288 --Yogg
mod.toggleoptions = {"phase", "link", "squeeze", "portal", "weakened", "madness", "ray", "empower", "berserk", "bosskill"}

------------------------------
--      Are you local?      --
------------------------------

local db = nil
local squeezeName = GetSpellInfo(64126)
local linkedName = GetSpellInfo(63802)
local linked = {}

----------------------------
--      Localization      --
----------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

L:RegisterTranslations("enUS", function() return {
	cmd = "YoggSaron",

	phase = "Phase",
	phase_desc = "Warn for phase changes.",
	engage_warning = "Phase 1",
	engage_trigger = "^The time to",
	phase2_warning = "Phase 2",
	phase2_trigger = "^I am the lucid dream",
	phase2_warning = "Phase 3",
	phase3_trigger = "^Look upon the true face",

	portal = "Portal",
	portal_desc = "Warn for Portals.",
	portal_trigger = "Portals open into Yogg-Saron's mind!",
	portal_message = "Portals open!",
	portal_bar = "Next Portal",

	weakened = "Weakened",
	weakened_desc = "Warn for Weakened State.",
	weakened_message = "%s is weakened!",
	weakened_trigger = "The Illusion shatters and a path to the central chamber opens!",

	madness = "Induce Madness",
	madness_desc = "Show Timer for Induce Madness.",
	madness_warning = "Induce Madness in 5sec!",
	
	ray = "Death Ray",
	ray_desc = "Warn when Sara casts a Death Ray.",
	ray_message = "Death Ray!",
	ray_bar = "~Next Death Ray",

	squeeze = squeezeName,
	squeeze_desc = "Warn which player has Squeeze.",
	squeeze_message = squeezeName .. ": %s",

	link = linkedName,
	link_desc = "Warn which players are linked.",
	link_message = linkedName .. ": %s",

	gaze = "Lunatic Gaze",
	gaze_desc = "Warn when Yogg-Saron gains Lunatic Gaze.",
	gaze_message = "Lunatic Gaze!",
	gaze_bar = "~Gaze Cooldown",

	empower = "Empowering Shadows",
	empower_desc = "Warn for Empowering Shadows.",
	empower_message = "Empowering Shadows!",
	empower_bar = "~Empower Cooldown",

	log = "|cffff0000"..boss.."|r: This boss needs data, please consider turning on your /combatlog or transcriptor and submit the logs.",
} end )

L:RegisterTranslations("koKR", function() return {
	phase = "단계",
	phase_desc = "단계 변화를 알립니다.",
	engage_warning = "1 단계",
	engage_trigger = "^짐승의",	--check
	phase2_warning = "2 단계",
	phase2_trigger = "^나는 살아있는 꿈이다",	--check
	phase2_warning = "3 단계",
	phase3_trigger = "^죽음의 진정한 얼굴을 보아라",	--check

	portal = "차원문",
	portal_desc = "차원문을 알립니다.",
	--portal_trigger = "Portals open into Yogg-Saron's mind!",
	portal_message = "차원문 열림!",
	portal_bar = "다음 차원문",

	weakened = "약화",
	weakened_desc = "약화 상태를 알립니다.",
	weakened_message = "%s 약화!",
	--weakened_trigger = "The Illusion shatters and a path to the central chamber opens!",

	madness = "광기 유발",
	madness_desc = "광기 유발의 타이머를 표시합니다.",
	madness_warning = "5초 후 광기 유발!",
	
	ray = "죽음의 광선",
	ray_desc = "죽음의 광선 시전을 알립니다.",
	ray_message = "죽음의 광선!",
	ray_bar = "~다음 광선",

	squeeze = squeezeName,
	squeeze_desc = "압착에 붙잡힌 플레이어를 알립니다.",

	link = linkedName,
	link_desc = "두뇌의 고리에 연결된 플레이어를 알립니다.",

	gaze = "광기의 시선",
	gaze_desc = "요그사론의 광기의 시선 획득을 알립니다.",
	gaze_message = "광기의 시선!",
	gaze_bar = "~시선 대기시간",

	empower = "암흑 강화",
	empower_desc = "암흑 강화를 알립니다.",
	empower_message = "암흑 강화!",
	empower_bar = "~강화 대기시간",

	log = "|cffff0000"..boss.."|r: 해당 보스의 데이터가 필요합니다. 채팅창에 /전투기록 , /대화기록 을 입력하여 기록된 데이터나 스샷등을 http://cafe.daum.net/SCU15 통해 알려주세요.",
} end )

L:RegisterTranslations("frFR", function() return {
	phase = "Phase",
	phase_desc = "Prévient quand la rencontre entre dans une nouvelle phase.",
	engage_warning = "Phase 1",
	engage_trigger = "^Il sera bientôt temps de", -- à vérifier
	phase2_warning = "Phase 2",
	phase2_trigger = "^Je suis le rêve éveillé", -- à vérifier
	phase2_warning = "Phase 3",
	phase3_trigger = "^Contemplez le vrai visage de la mort", -- à vérifier

	portal = "Portail",
	portal_desc = "Prévient de l'arrivée des portails.",
	portal_trigger = "Portals open into Yogg-Saron's mind!", -- à traduire (Des portails s'ouvrent dans l'esprit de Yogg-Saron !")
	portal_message = "Portails ouverts !",
	portal_bar = "Prochain portail",

	weakened = "Affaibli",
	weakened_desc = "Prévient quand Yogg-Saron est affaibli.",
	weakened_message = "%s est affaibli !",
	weakened_trigger = "The Illusion shatters and a path to the central chamber opens!", -- à traduire (L'Illusion se brise et un passage vers la chambre centrale s'ouvre !)

	madness = "Susciter la folie",
	madness_desc = "Affiche le délai avant la fin de l'incantation de Susciter la folie.",
	madness_warning = "Susciter la folie dans 5 sec. !",
	
	--ray = "Death Ray",
	--ray_desc = "Warn when Sara casts a Death Ray.",
	--ray_message = "Death Ray!",
	--ray_bar = "~Next Death Ray",

	squeeze = squeezeName, -- doesn't appear in the dropdown menu if not mentioned here
	squeeze_desc = "Prévient quand un joueur subit les effets d'un Ecrasement.",

	link = linkedName,
	link_desc = "Indique quels joueurs sont liées.",

	gaze = "Regard lunatique",
	gaze_desc = "Prévient quand Yogg-Saron incante un Regard lunatique.",
	gaze_message = "Regard lunatique !",
	gaze_bar = "Recharge Regard",

	empower = "Renforcement des ombres",
	empower_desc = "Prévient de l'arrivée des Renforcements des ombres.",
	empower_message = "Renforcement des ombres !",
	empower_bar = "~Recharge Renforcement",

	log = "|cffff0000"..boss.."|r : ce boss a besoin de donnees, merci d'activer votre /combatlog ou Transcriptor et de nous transmettre les logs.",
} end )

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Ray", 63891)
	self:AddCombatListener("SPELL_CAST_START", "Madness", 64059)
	self:AddCombatListener("SPELL_CAST_START", "Empower", 64465)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Squeeze", 64126)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Linked", 63802)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Gaze", 64163)
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	db = self.db.profile

	BigWigs:Print(L["log"])
	wipe(linked)
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Ray(_, spellID)
	if db.ray then
		self:IfMessage(L["ray_message"], "Attention", spellID)
		self:Bar(L["ray"], 15, spellID)
		self:Bar(L["ray_bar"], 22, spellID)
	end
end

function mod:Squeeze(player, spellID)
	if db.squeeze then
		self:IfMessage(L["squeeze_message"]:format(player), "Positive", spellID)
	end
end

local function printLinked(spellID)
	local msg = nil
	for k in pairs(linked) do
		if not msg then
			msg = k
		else
			msg = msg .. ", " .. k
		end
	end
	mod:IfMessage(L["link_message"]:format(msg), "Attention", spellID, "Alert")
	wipe(linked)
end

function mod:Linked(player, spellID)
	if db.link then
		linked[player] = true
		self:ScheduleEvent("BWLinkedWarn", printLinked, 0.2, spellID)
	end
end

function mod:Gaze(_, spellID)
	if db.gaze then
		self:IfMessage(L["gaze_message"], "Attention", spellID)
		self:Bar(L["gaze"], 4, spellID)
		self:Bar(L["gaze_bar"], 13, spellID)
	end
end

function mod:Madness()
	if db.madness then
		self:Bar(L["madness"], 60, 64059)
		self:ScheduleEvent("MadnessWarning", "BigWigs_Message", 55, L["madness_warning"], "Attention")
	end
end

function mod:Empower()
	if db.empower then
		self:IfMessage(L["empower_message"], "Attention", 64465)
		self:Bar(L["empower_bar"], 46, 64465)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L["portal_trigger"] and db.portal then
		self:IfMessage(L["portal_message"], "Attention", 35717)
		self:Bar(L["portal_bar"], 90, 35717)
	elseif msg == L["weakened_trigger"] and db.weakened then
		self:IfMessage(L["weakened_message"]:format(boss), "Attention", 50661) --50661, looks like a weakened :)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg:find(L["engage_trigger"]) then
		phase = 1
		if db.phase then
			self:Message(L["engage_warning"], "Important", nil, "Alarm")
		end
		if db.berserk then
			self:Enrage(900, true, true)
		end
	elseif msg == L["phase2_trigger"] then
		phase = 2
		if db.phase then
			self:IfMessage(L["phase2_warning"], "Important", nil, "Alarm")
		end
		if db.portal then
			self:Bar(L["portal_bar"], 78, 35717)
		end
	elseif msg:find(L["phase3_trigger"]) then
		phase = 3
		self:CancelAllScheduledEvents()
		self:TriggerEvent("BigWigs_StopBar", self, L["portal_bar"])
		self:TriggerEvent("BigWigs_StopBar", self, L["madness"])
		if db.phase then
			self:IfMessage(L["phase3_warning"], "Important", nil, "Alarm")
		end
		if db.empower then
			self:Bar(L["empower"], 46, 64486)
		end
	end
end

