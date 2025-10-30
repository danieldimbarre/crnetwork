-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
SERVER = IsDuplicityVersion()
-----------------------------------------------------------------------------------------------------------------------------------------
-- LEVELS
-----------------------------------------------------------------------------------------------------------------------------------------
local Levels = { 0,270,580,940,1350,1820,2360,2980,3690,4500,5440,6520,7760,9180,10810,12690,14850,17330,20180,23450,27210,31540,36510,42230,48810,56370,65060,75060,86550,99999 }
local LevelsPainel = { 0,270,580,940,1350,1820,2360,2980,3690,4500,5440,6520,7760,9180,10810,12690,14850,17330,20180,23450,27210,31540,36510,42230,48810,56370,65060,75060,86550,99999 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLASSCATEGORY
-----------------------------------------------------------------------------------------------------------------------------------------
function ClassCategory(Experience)
	for Number = #Levels,1,-1 do
		if Experience >= Levels[Number] then
			return Number
		end
	end

	return 1
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAINELCATEGORY
-----------------------------------------------------------------------------------------------------------------------------------------
function PainelCategory(Experience)
	for Number = #LevelsPainel,1,-1 do
		if Experience >= LevelsPainel[Number] then
			return Number
		end
	end

	return 1
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLELEVEL
-----------------------------------------------------------------------------------------------------------------------------------------
function TableLevel()
	return Levels
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLELEVELPAINEL
-----------------------------------------------------------------------------------------------------------------------------------------
function TableLevelPainel()
	return LevelsPainel
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAINS
-----------------------------------------------------------------------------------------------------------------------------------------
function Contains(Table,Value)
	for _,v in ipairs(Table) do
		if v == Value then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMPTYSPACE
-----------------------------------------------------------------------------------------------------------------------------------------
function EmptySpace(Message)
	return Message:gsub("%s+","")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRSTNAME
-----------------------------------------------------------------------------------------------------------------------------------------
function FirstName(Message)
	local Original = tostring(Message or "")
	local FirstName = Original:match("^(%S+)") or ""
	local CleanName = FirstName:gsub("%d","")
	CleanName = CleanName ~= "" and CleanName or "Desconhecido"

	return CleanName:sub(1,1):upper()..CleanName:sub(2):lower()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SANGUINE
-----------------------------------------------------------------------------------------------------------------------------------------
function Sanguine(Number)
	local Types = { "A+","B+","A-","B-" }

	return Types[Number]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLE.MAXN
-----------------------------------------------------------------------------------------------------------------------------------------
function table.maxn(Table)
	local Number = 0

	for Index,_ in pairs(Table) do
		local Next = tonumber(Index)
		if Next and Next > Number then
			Number = Next
		end
	end

	return Number
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COUNTTALBE
-----------------------------------------------------------------------------------------------------------------------------------------
function CountTable(Table)
	local Number = 0

	for _ in pairs(Table) do
		Number = Number + 1
	end

	return Number
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MODULE
-----------------------------------------------------------------------------------------------------------------------------------------
local modules = {}
function module(Resource,Patch)
	if not Patch then
		Patch = Resource
		Resource = "vrp"
	end

	local Key = Resource..Patch
	local Module = modules[Key]
	if Module then
		return Module
	else
		local File = LoadResourceFile(Resource,Patch..".lua")
		if File then
			local Float = load(File,Resource.."/"..Patch..".lua")
			if Float then
				local Accept,Result = xpcall(Float,debug["traceback"])
				if Accept then
					modules[Key] = Result

					return Result
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAIT
-----------------------------------------------------------------------------------------------------------------------------------------
local function wait(self)
	local rets = Citizen.Await(self.p)
	if not rets and self.r then
		rets = self.r
	end

	return table.unpack(rets,1,table.maxn(rets))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARETURN
-----------------------------------------------------------------------------------------------------------------------------------------
local function areturn(self,...)
	self.r = {...}
	self.p:resolve(self.r)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ASYNC
-----------------------------------------------------------------------------------------------------------------------------------------
function async(func)
	if func then
		Citizen.CreateThreadNow(func)
	else
		return setmetatable({ wait = wait, p = promise.new() },{ __call = areturn })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARSEINT
-----------------------------------------------------------------------------------------------------------------------------------------
function parseInt(Number,Force)
	Number = tonumber(Number) or 0
	if Force and Number <= 0 then
		Number = 1
	end

	return math.floor(Number)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SANITIZESTRING
-----------------------------------------------------------------------------------------------------------------------------------------
function sanitizeString(String,Characteres)
	return String:gsub("[^"..Characteres.."]","")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPLITSTRING
-----------------------------------------------------------------------------------------------------------------------------------------
function splitString(Full,Symbol)
	local Table = {}

	if not Symbol then
		Symbol = "-"
	end

	for Full in string.gmatch(Full,"([^"..Symbol.."]+)") do
		Table[#Table + 1] = Full
	end

	return Table
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPLITONE
-----------------------------------------------------------------------------------------------------------------------------------------
function SplitOne(Name,Symbol)
	if not Symbol then
		Symbol = "-"
	end

	return splitString(Name,Symbol)[1]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPLITBOOLEAN
-----------------------------------------------------------------------------------------------------------------------------------------
function SplitBoolean(Name,String,Symbol)
	if not Symbol then
		Symbol = "-"
	end

	return splitString(Name,Symbol)[1] == String and true or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPLITTWO
-----------------------------------------------------------------------------------------------------------------------------------------
function SplitTwo(Name,Symbol)
	if not Symbol then
		Symbol = "-"
	end

	return splitString(Name,Symbol)[2]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPLITUNIQUE
-----------------------------------------------------------------------------------------------------------------------------------------
function SplitUnique(Item)
	local Name = splitString(Item,"-")

	return Name[1] and Name[3] and Name[1]..":"..Name[3] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPTIMIZE
-----------------------------------------------------------------------------------------------------------------------------------------
function Optimize(Number)
	return math.ceil(Number * 100) / 100
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOTTED
-----------------------------------------------------------------------------------------------------------------------------------------
function Dotted(Value)
	local Value = parseInt(Value)
	local Left,Number,Right = string.match(Value,"^([^%d]*%d)(%d*)(.-)$")
	return Left..(Number:reverse():gsub("(%d%d%d)","%1."):reverse())..Right
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPLETETIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
function CompleteTimers(Seconds,Simple)
	local Days = math.floor(Seconds / 86400)
	Seconds = Seconds % 86400

	local Hours = math.floor(Seconds / 3600)
	Seconds = Seconds % 3600

	local Minutes = math.floor(Seconds / 60)
	Seconds = Seconds % 60

	local function Plural(Value,Singular,Plural)
		return Value <= 1 and Singular or Plural
	end

	if Days > 0 then
		if Hours > 0 and not Simple then
			return string.format("%d %s, %d %s e %d %s",Days,Plural(Days,"Dia","Dias"),Hours,Plural(Hours,"Hora","Horas"),Minutes,Plural(Minutes,"Minuto","Minutos"))
		else
			return string.format("%d %s e %d %s",Days,Plural(Days,"Dia","Dias"),Hours,Plural(Hours,"Hora","Horas"))
		end
	elseif Hours > 0 then
		return string.format("%d %s e %d %s",Hours,Plural(Hours,"Hora","Horas"),Minutes,Plural(Minutes,"Minuto","Minutos"))
	elseif Minutes > 0 then
		return string.format("%d %s e %d %s",Minutes,Plural(Minutes,"Minuto","Minutos"),Seconds,Plural(Seconds,"Segundo","Segundos"))
	else
		return string.format("%d %s",Seconds,Plural(Seconds,"Segundo","Segundos"))
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BONES
-----------------------------------------------------------------------------------------------------------------------------------------
local Bones = {
	[11816] = "Pelvis",
	[58271] = "Coxa Esquerda",
	[63931] = "Panturrilha Esquerda",
	[14201] = "Pe Esquerdo",
	[2108] = "Dedo do Pe Esquerdo",
	[65245] = "Pe Esquerdo",
	[57717] = "Pe Esquerdo",
	[46078] = "Joelho Esquerdo",
	[51826] = "Coxa Direita",
	[36864] = "Panturrilha Direita",
	[52301] = "Pe Direito",
	[20781] = "Dedo do Pe Direito",
	[35502] = "Pe Direito",
	[24806] = "Pe Direito",
	[16335] = "Joelho Direito",
	[23639] = "Coxa Direita",
	[6442] = "Coxa Direita",
	[57597] = "Espinha Cervical",
	[23553] = "Espinha Toraxica",
	[24816] = "Espinha Lombar",
	[24817] = "Espinha Sacral",
	[24818] = "Espinha Cocciana",
	[64729] = "Escapula Esquerda",
	[45509] = "Braco Esquerdo",
	[61163] = "Antebraco Esquerdo",
	[18905] = "Mao Esquerda",
	[18905] = "Mao Esquerda",
	[26610] = "Dedo Esquerdo",
	[4089] = "Dedo Esquerdo",
	[4090] = "Dedo Esquerdo",
	[26611] = "Dedo Esquerdo",
	[4169] = "Dedo Esquerdo",
	[4170] = "Dedo Esquerdo",
	[26612] = "Dedo Esquerdo",
	[4185] = "Dedo Esquerdo",
	[4186] = "Dedo Esquerdo",
	[26613] = "Dedo Esquerdo",
	[4137] = "Dedo Esquerdo",
	[4138] = "Dedo Esquerdo",
	[26614] = "Dedo Esquerdo",
	[4153] = "Dedo Esquerdo",
	[4154] = "Dedo Esquerdo",
	[60309] = "Mao Esquerda",
	[36029] = "Mao Esquerda",
	[61007] = "Antebraco Esquerdo",
	[5232] = "Antebraco Esquerdo",
	[22711] = "Cotovelo Esquerdo",
	[10706] = "Escapula Direita",
	[40269] = "Braco Direito",
	[28252] = "Antebraco Direito",
	[57005] = "Mao Direita",
	[58866] = "Dedo Direito",
	[64016] = "Dedo Direito",
	[64017] = "Dedo Direito",
	[58867] = "Dedo Direito",
	[64096] = "Dedo Direito",
	[64097] = "Dedo Direito",
	[58868] = "Dedo Direito",
	[64112] = "Dedo Direito",
	[64113] = "Dedo Direito",
	[58869] = "Dedo Direito",
	[64064] = "Dedo Direito",
	[64065] = "Dedo Direito",
	[58870] = "Dedo Direito",
	[64080] = "Dedo Direito",
	[64081] = "Dedo Direito",
	[28422] = "Mao Direita",
	[6286] = "Mao Direita",
	[43810] = "Antebraço Direito",
	[37119] = "Antebraço Direito",
	[2992] = "Cotovelo Direito",
	[39317] = "Pescoco",
	[31086] = "Cabeca",
	[12844] = "Cabeca",
	[65068] = "Rosto"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BONE
-----------------------------------------------------------------------------------------------------------------------------------------
function Bone(Number)
	return Bones[Number] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RANDPERCENTAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function RandPercentage(Table)
	if type(Table) ~= "table" or #Table == 0 then
		return false
	end

	local Multiplier = 0
	for Number = 1,#Table do
		Multiplier = Multiplier + (Table[Number].Chance or 0)
	end

	if Multiplier <= 0 then
		return false
	end

	local Randomize = math.random(Multiplier)
	for Number = 1,#Table do
		local Entry = Table[Number]
		Randomize = Randomize - (Entry.Chance or 0)

		if Entry.Min and Entry.Max then
			Entry.Valuation = math.random(Entry.Min,Entry.Max)
		end

		if Randomize <= 0 then
			return Entry
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATESTRING
-----------------------------------------------------------------------------------------------------------------------------------------
function GenerateString(Format)
	local Return = {}
	for Number = 1,#Format do
		local Consult = string.byte(Format,Number)
		Return[Number] = Consult == 68 and string.char(48 + math.random(0,9)) or Consult == 76 and string.char(65 + math.random(0,25)) or string.char(Consult)
	end

	return table.concat(Return)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BASE64
-----------------------------------------------------------------------------------------------------------------------------------------
local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
function Base64(data)
	return ((data:gsub(".",function(x)
		local r, b = "", x:byte()
		for i = 8,1,-1 do
			r = r..(b % 2 ^ i - b % 2 ^ (i - 1) > 0 and "1" or "0")
		end

		return r
	end).."0000"):gsub("%d%d%d?%d?%d?%d?",function(x)
		if (#x < 6) then return "" end
		local c = 0
			for i = 1, 6 do
			c = c + (x:sub(i,i) == "1" and 2 ^ (6 - i) or 0)
		end

		return b:sub(c + 1,c + 1)
	end)..({ "","==","=" })[#data % 3 + 1])
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONVERTSTRINGTOTABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function ConvertStringToTable(String)
	local Function = load("return "..String)
	if not Function then
		return nil
	end

	local Consult,Result = pcall(Function)
	if not Consult then
		return nil
	end

	return Result
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONSHASH
-----------------------------------------------------------------------------------------------------------------------------------------
local WeaponsHash = {
	[-1834847097] = "WEAPON_DAGGER",
	[-155058791] = "WEAPON_TECP",
	[-771403250] = "WEAPON_HEAVYPISTOL",
	[133987706] = "WEAPON_RAMMED_BY_CAR",
	[-1238556825] = "WEAPON_RAYMINIGUN",
	[101631238] = "WEAPON_FIREEXTINGUISHER",
	[-1600701090] = "WEAPON_BZGAS",
	[-102323637] = "WEAPON_BOTTLE",
	[1834241177] = "WEAPON_RAILGUN",
	[1317494643] = "WEAPON_HAMMER",
	[324215364] = "WEAPON_MICROSMG",
	[-1466123874] = "WEAPON_MUSKET",
	[-270015777] = "WEAPON_ASSAULTSMG",
	[984333226] = "WEAPON_HEAVYSHOTGUN",
	[911657153] = "WEAPON_STUNGUN",
	[85055149] = "WEAPON_SHOES",
	[-608341376] = "WEAPON_COMBATMG_MK2",
	[1703483498] = "WEAPON_CANDYCANE",
	[-1169823560] = "WEAPON_PIPEBOMB",
	[1141786504] = "WEAPON_GOLFCLUB",
	[1627465347] = "WEAPON_GUSENBERG",
	[-1660422300] = "WEAPON_MG",
	[-879347409] = "WEAPON_REVOLVER_MK2",
	[2144741730] = "WEAPON_COMBATMG",
	[-1074790547] = "WEAPON_ASSAULTRIFLE",
	[1064738331] = "WEAPON_BRICK",
	[-2009644972] = "WEAPON_SNSPISTOL_MK2",
	[126349499] = "WEAPON_SNOWBALL",
	[1853742572] = "WEAPON_PRECISIONRIFLE",
	[1171102963] = "WEAPON_STUNGUN_MP",
	[-1786099057] = "WEAPON_BAT",
	[-1553120962] = "WEAPON_RUN_OVER_BY_CAR",
	[-538741184] = "WEAPON_SWITCHBLADE",
	[1198256469] = "WEAPON_RAYCARBINE",
	[-1355376991] = "WEAPON_RAYPISTOL",
	[1305664598] = "WEAPON_GRENADELAUNCHER_SMOKE",
	[-38085395] = "WEAPON_DIGISCANNER",
	[177293209] = "WEAPON_HEAVYSNIPER_MK2",
	[-135142818] = "WEAPON_ACIDPACKAGE",
	[-37975472] = "WEAPON_SMOKEGRENADE",
	[-1075685676] = "WEAPON_PISTOL_MK2",
	[205991906] = "WEAPON_HEAVYSNIPER",
	[600439132] = "WEAPON_BALL",
	[100416529] = "WEAPON_SNIPERRIFLE",
	[1233104067] = "WEAPON_FLARE",
	[-618237638] = "WEAPON_EMPLAUNCHER",
	[741814745] = "WEAPON_STICKYBOMB",
	[615608432] = "WEAPON_MOLOTOV",
	[961495388] = "WEAPON_ASSAULTRIFLE_MK2",
	[-1420407917] = "WEAPON_PROXMINE",
	[-1813897027] = "WEAPON_GRENADE",
	[-952879014] = "WEAPON_MARKSMANRIFLE",
	[2132975508] = "WEAPON_BULLPUPRIFLE",
	[-1658906650] = "WEAPON_MILITARYRIFLE",
	[736523883] = "WEAPON_SMG",
	[1737195953] = "WEAPON_NIGHTSTICK",
	[-1312131151] = "WEAPON_RPG",
	[2138347493] = "WEAPON_FIREWORK",
	[1119849093] = "WEAPON_MINIGUN",
	[-72657034] = "GADGET_PARACHUTE",
	[-1568386805] = "WEAPON_GRENADELAUNCHER",
	[1785463520] = "WEAPON_MARKSMANRIFLE_MK2",
	[317205821] = "WEAPON_AUTOSHOTGUN",
	[-598887786] = "WEAPON_MARKSMANPISTOL",
	[-1716189206] = "WEAPON_KNIFE",
	[-275439685] = "WEAPON_DBSHOTGUN",
	[1470379660] = "WEAPON_GADGETPISTOL",
	[-494615257] = "WEAPON_ASSAULTSHOTGUN",
	[137902532] = "WEAPON_VINTAGEPISTOL",
	[2017895192] = "WEAPON_SAWNOFFSHOTGUN",
	[-86904375] = "WEAPON_CARBINERIFLE_MK2",
	[-1951375401] = "WEAPON_FLASHLIGHT",
	[487013001] = "WEAPON_PUMPSHOTGUN",
	[-853065399] = "WEAPON_BATTLEAXE",
	[-656458692] = "WEAPON_KNUCKLE",
	[-774507221] = "WEAPON_TACTICALRIFLE",
	[-1853920116] = "WEAPON_NAVYREVOLVER",
	[1672152130] = "WEAPON_HOMINGLAUNCHER",
	[125959754] = "WEAPON_COMPACTLAUNCHER",
	[1649403952] = "WEAPON_COMPACTRIFLE",
	[-947031628] = "WEAPON_HEAVYRIFLE",
	[-102973651] = "WEAPON_HATCHET",
	[-1810795771] = "WEAPON_POOLCUE",
	[-2067956739] = "WEAPON_CROWBAR",
	[-1746263880] = "WEAPON_DOUBLEACTION",
	[-22923932] = "WEAPON_RAILGUNXM3",
	[-1768145561] = "WEAPON_SPECIALCARBINE_MK2",
	[-1063057011] = "WEAPON_SPECIALCARBINE",
	[-1357824103] = "WEAPON_ADVANCEDRIFLE",
	[-2084633992] = "WEAPON_CARBINERIFLE",
	[-1654528753] = "WEAPON_BULLPUPSHOTGUN",
	[872155819] = "WEAPON_SERVICECARBINE",
	[1593441988] = "WEAPON_COMBATPISTOL",
	[171789620] = "WEAPON_COMBATPDW",
	[940833800] = "WEAPON_STONE_HATCHET",
	[-2066285827] = "WEAPON_BULLPUPRIFLE_MK2",
	[584646201] = "WEAPON_APPISTOL",
	[465894841] = "WEAPON_PISTOLXM3",
	[-1121678507] = "WEAPON_MINISMG",
	[727643628] = "WEAPON_CERAMICPISTOL",
	[-1045183535] = "WEAPON_REVOLVER",
	[-581044007] = "WEAPON_MACHETE",
	[453432689] = "WEAPON_PISTOL",
	[1198879012] = "WEAPON_FLAREGUN",
	[-619010992] = "WEAPON_MACHINEPISTOL",
	[-1076751822] = "WEAPON_SNSPISTOL",
	[419712736] = "WEAPON_WRENCH",
	[2024373456] = "WEAPON_SMG_MK2",
	[-1716589765] = "WEAPON_PISTOL50",
	[883325847] = "WEAPON_PETROLCAN",
	[1432025498] = "WEAPON_PUMPSHOTGUN_MK2",
	[-1569615261] = "WEAPON_UNARMED"
}