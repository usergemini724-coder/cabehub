local Players      = game:GetService("Players")
local UserInput    = game:GetService("UserInputService")
local StarterGui   = game:GetService("StarterGui")
local TeleportSvc  = game:GetService("TeleportService")
local VirtualUser  = game:GetService("VirtualUser")
local Lighting     = game:GetService("Lighting")
local RunService   = game:GetService("RunService")
local LP      = Players.LocalPlayer
local Camera  = workspace.CurrentCamera
local ENV     = (typeof(getgenv) == "function" and getgenv()) or _G
local PLACEID = 107778070777162
if ENV.__EGG_FINDER_CLEANUP then
pcall(ENV.__EGG_FINDER_CLEANUP)
end
if ENV.__CABE_HUB_CLEANUP then
pcall(ENV.__CABE_HUB_CLEANUP)
end
local Logic = (function()
local Logic = {}
Logic.TIERS = {
{ name = "Common",    rank = 1,  rgb = { 0.72, 0.74, 0.78 } },
{ name = "Uncommon",  rank = 2,  rgb = { 0.42, 0.85, 0.52 } },
{ name = "Rare",      rank = 3,  rgb = { 0.32, 0.62, 1.00 } },
{ name = "Epic",      rank = 4,  rgb = { 0.68, 0.38, 0.98 } },
{ name = "Legendary", rank = 5,  rgb = { 1.00, 0.62, 0.16 } },
{ name = "Mythic",    rank = 6,  rgb = { 1.00, 0.30, 0.36 } },
{ name = "Cosmic",    rank = 7,  rgb = { 0.20, 0.92, 0.92 } },
{ name = "Secret",    rank = 8,  rgb = { 1.00, 0.86, 0.25 } },
{ name = "Eternal",   rank = 9,  rgb = { 0.86, 0.55, 1.00 } },
{ name = "Divine",    rank = 10, rgb = { 1.00, 1.00, 1.00 } },
}
Logic.UNKNOWN = { name = "Unknown", rank = 3, rgb = { 0.60, 0.60, 0.60 } }
Logic.EGG_TABLE = {
["chicken"] = "Common", ["dog"] = "Common", ["frog"] = "Common",
["duckling"] = "Common", ["jerboa"] = "Common",
["bird"] = "Uncommon", ["catfish"] = "Uncommon", ["fennec"] = "Uncommon",
["burrowing owl"] = "Rare", ["raccoon"] = "Rare", ["turtle"] = "Rare",
["camel"] = "Rare", ["toucan"] = "Rare", ["chimpanzee"] = "Rare",
["penguin"] = "Rare", ["lava gecko"] = "Rare", ["parrotfish"] = "Rare",
["dodo"] = "Rare", ["race lizard"] = "Rare",
["bear"] = "Epic", ["fox"] = "Epic", ["trulimero trulicina"] = "Epic",
["swan"] = "Epic", ["tob tobi tob tob"] = "Epic", ["crocodile"] = "Epic",
["walrus"] = "Epic", ["lava frog"] = "Epic", ["swordfish"] = "Epic",
["centapede"] = "Epic", ["crane"] = "Epic", ["whiskers"] = "Epic",
["brr brr patapim"] = "Legendary", ["axolotl"] = "Legendary",
["snake"] = "Legendary", ["gorilla"] = "Legendary",
["orangutini ananassini"] = "Legendary", ["polar bear"] = "Legendary",
["flaming bull"] = "Legendary", ["lava iguana"] = "Legendary",
["shark"] = "Legendary", ["pterodactyl"] = "Legendary",
["cosmic gecko"] = "Legendary", ["salamander"] = "Legendary",
["crustacia"] = "Legendary", ["spideron"] = "Legendary",
["scorpio"] = "Legendary", ["rift eye"] = "Legendary",
["void angler"] = "Legendary", ["race seahorse"] = "Legendary",
["light dove"] = "Legendary", ["flame sprite"] = "Legendary",
["prism gecko"] = "Legendary", ["jesterpop"] = "Legendary",
["hooded gerbil"] = "Legendary", ["mimic chest"] = "Legendary",
["sand spider"] = "Mythic", ["scorpion"] = "Mythic", ["spider"] = "Mythic",
["tiger"] = "Mythic", ["sabertooth tiger"] = "Mythic", ["mammoth"] = "Mythic",
["chillin chilli"] = "Mythic", ["orca"] = "Mythic", ["ankylosaurus"] = "Mythic",
["cosmic gorilla"] = "Mythic", ["red panda"] = "Mythic", ["bladehide"] = "Mythic",
["froggo"] = "Mythic", ["voidmaw"] = "Mythic", ["shardling"] = "Mythic",
["winged lamb"] = "Mythic", ["toro"] = "Mythic", ["petal beetle"] = "Mythic",
["enchanted bluejay"] = "Mythic", ["wheel hamster"] = "Mythic",
["frogfly"] = "Mythic", ["toxic rat"] = "Mythic", ["terrorbird"] = "Mythic",
["candlefang"] = "Mythic", ["toadstool"] = "Mythic", ["crowshade"] = "Mythic",
["leviathan"] = "Cosmic", ["royal sphinx"] = "Cosmic", ["king mammoth"] = "Cosmic",
["whale shark"] = "Cosmic", ["beluga whale"] = "Cosmic", ["triceratops"] = "Cosmic",
["bronto"] = "Cosmic", ["la vacca saturno saturnita"] = "Cosmic",
["koi"] = "Cosmic", ["snowy owl"] = "Cosmic", ["mantaris"] = "Cosmic",
["rhinotaur"] = "Cosmic", ["crawler"] = "Cosmic", ["ventinal"] = "Cosmic",
["shattered ram"] = "Cosmic", ["sacred moth"] = "Cosmic", ["holy peacock"] = "Cosmic",
["demon hound"] = "Cosmic", ["imp"] = "Cosmic", ["astral jackalope"] = "Cosmic",
["spirit panda"] = "Cosmic", ["stacked turtle"] = "Cosmic", ["spiderpig"] = "Cosmic",
["toucax"] = "Cosmic", ["three headed chicken"] = "Cosmic", ["radcoon"] = "Cosmic",
["giant sloth"] = "Cosmic", ["nibbles"] = "Cosmic", ["race bird"] = "Cosmic",
["spirit knight"] = "Cosmic", ["patchwork imp"] = "Cosmic",
["haunted scorpio"] = "Cosmic", ["hexed pumpkin"] = "Cosmic",
["king snake"] = "Secret", ["arxpays cluster"] = "Secret", ["cerberus"] = "Secret",
["kraken"] = "Secret", ["tralaledon"] = "Secret", ["trex"] = "Secret",
["cosmic dragon"] = "Secret", ["cosmic skeleton boss"] = "Secret",
["stag"] = "Secret", ["mutant shark"] = "Secret", ["crocodon"] = "Secret",
["wendigo"] = "Secret", ["mawbreaker"] = "Secret", ["shardwing"] = "Secret",
["pure jellyfish"] = "Secret", ["centaur"] = "Secret", ["gargoyle"] = "Secret",
["razorfang"] = "Secret", ["starry fox"] = "Secret", ["sharkodile"] = "Secret",
["nuceodile"] = "Secret", ["eyeball crab"] = "Secret", ["dunkleosteus"] = "Secret",
["skeletal glyptodon"] = "Secret", ["skeletal terrorbird"] = "Secret",
["skeletal giant sloth"] = "Secret", ["race cheetah"] = "Secret",
["experiment #001"] = "Secret", ["graveyard brute"] = "Secret",
["bloodbloom"] = "Secret", ["werewolf"] = "Secret",
["ice dragon"] = "Eternal", ["phoenix"] = "Eternal", ["lava dragon"] = "Eternal",
["el maja"] = "Eternal", ["mosasaurus"] = "Eternal",
["eternal lunar dragon"] = "Eternal", ["oni tiger"] = "Eternal",
["gorilla king"] = "Eternal", ["krakenoid"] = "Eternal",
["world eater"] = "Eternal", ["void serpent"] = "Eternal",
["shattered drake"] = "Eternal", ["pegasus"] = "Eternal",
["skeleton horse"] = "Eternal", ["celestial sunlion"] = "Eternal",
["terra snapper"] = "Eternal", ["rhinobear"] = "Eternal",
["nuclear mantis"] = "Eternal", ["deadstinger"] = "Eternal",
["gigantus"] = "Eternal", ["skeletal dunkleosteus"] = "Eternal",
["skeletal gigantus"] = "Eternal", ["engine snail"] = "Eternal",
["ghost reaper"] = "Eternal", ["gorillastein"] = "Eternal",
["shelltide voyager"] = "Eternal",
["unicorn"] = "Divine", ["kitsune"] = "Divine", ["nightflame"] = "Divine",
["dreadscale"] = "Divine", ["shattered colossus"] = "Divine",
["archangel"] = "Divine", ["world burner"] = "Divine",
["royal skywhale"] = "Divine", ["spirit world guardian"] = "Divine",
["cthulhu"] = "Divine", ["octophant"] = "Divine", ["sabertooth"] = "Divine",
["skeletal sabertooth"] = "Divine", ["voidseer pumpkin"] = "Divine",
}
Logic.KEYWORDS = {
"divine", "eternal", "secret", "cosmic", "mythic", "legendary",
"epic", "rare", "uncommon", "common",
}
Logic.EXCLUDE = {
["egg"] = true, ["eggs"] = true, ["eggshop"] = true, ["egg shop"] = true,
["egggui"] = true, ["eggicon"] = true, ["eggtimer"] = true,
["eggshell"] = true, ["egg counter"] = true, ["eggcounter"] = true,
["egg pad"] = true, ["eggsac"] = true,
}
Logic.CLASS_WHITELIST = {
Model = true, MeshPart = true, Part = true, UnionOperation = true, WedgePart = true,
}
function Logic.normalize(raw)
if type(raw) ~= "string" then return "" end
local s = raw:lower()
s = s:gsub("[\128-\255]+", " ")
s = s:gsub("[^%w%s#%-_%(%)]", " ")
s = s:gsub("%s+", " ")
s = s:gsub("^%s+", "")
s = s:gsub("%s+$", "")
return s
end
function Logic.stripEggSuffix(name)
local s = Logic.normalize(name)
s = s:gsub("%s*%(%d+%)$", "")
s = s:gsub("%s*%-%s*copy$", "")
s = s:gsub("%s+eggs?$", "")
return s
end
function Logic.isEggName(raw)
local n = Logic.normalize(raw)
if n == "" then return false end
if Logic.EXCLUDE[n] then return false end
if not n:find("egg", 1, true) then return false end
if n:match("^eggs?%s*%(?%d+%)?$") then return false end
if n:find("gui", 1, true) and n:find("egg", 1, true) then return false end
return true
end
function Logic.rarityOfName(raw)
local s = Logic.stripEggSuffix(raw)
if s == "" then return nil end
local direct = Logic.EGG_TABLE[s]
if direct then
for _, t in ipairs(Logic.TIERS) do
if t.name == direct then return t end
end
end
local bestKey, bestTier = nil, nil
for key, tierName in pairs(Logic.EGG_TABLE) do
if s:find(key, 1, true) then
if not bestKey or #key > #bestKey then
bestKey = key
for _, t in ipairs(Logic.TIERS) do
if t.name == tierName then bestTier = t end
end
end
end
end
if bestTier then return bestTier end
for _, kw in ipairs(Logic.KEYWORDS) do
if s:find(kw, 1, true) then
for _, t in ipairs(Logic.TIERS) do
if t.name:lower() == kw then return t end
end
end
end
return nil
end
function Logic.resolveRarity(rawName, attrRarity)
if type(attrRarity) == "string" then
local want = Logic.normalize(attrRarity)
for _, t in ipairs(Logic.TIERS) do
if t.name:lower() == want then return t end
end
end
return Logic.rarityOfName(rawName) or Logic.UNKNOWN
end
function Logic.displayName(raw)
local s = Logic.normalize(raw)
s = s:gsub("%s*%(%d+%)$", "")
return (s:gsub("^%l", string.upper))
end
function Logic.rank(entries, opts)
opts = opts or {}
local out = {}
for _, e in ipairs(entries or {}) do
local keep = true
if opts.minRank and e.rank < opts.minRank then keep = false end
if keep and opts.maxDistance and e.distance > opts.maxDistance then keep = false end
if keep and opts.hideOwn and e.isOwn then keep = false end
if keep and opts.query and opts.query ~= "" then
if not e.name:find(opts.query:lower(), 1, true) then keep = false end
end
if keep then table.insert(out, e) end
end
table.sort(out, function(a, b)
if opts.mode == "rarity" then
if a.rank ~= b.rank then return a.rank > b.rank end
return a.distance < b.distance
end
if a.distance ~= b.distance then return a.distance < b.distance end
return a.rank > b.rank
end)
return out
end
function Logic.best(entries, opts)
opts = opts or {}
local ranked = Logic.rank(entries, {
minRank = opts.minRank,
maxDistance = opts.maxDistance,
query = opts.query,
hideOwn = opts.hideOwn,
mode = "rarity",
})
return ranked[1]
end
function Logic.signature(entries)
local parts = {}
for _, e in ipairs(entries or {}) do
table.insert(parts, e.id .. ":" .. e.rank .. ":" .. math.floor(e.distance))
end
return table.concat(parts, "|")
end
function Logic.fmtDistance(d)
if d >= 1000 then return string.format("%.1fk", d / 1000) end
return string.format("%d", math.floor(d))
end
return Logic
end)()
local CONFIG = {
placeId = PLACEID,
scanInterval = 0.9,
rescanEvery = 6,
scanBudgetMs = 45,
maxDistance = 3000,
maxEntries = 1200,
walkSpeed = 16,
jumpPower = 50,
noclip = false,
infiniteJump = false,
antiAfk = false,
fpsBoost = false,
tpCooldown = 1.5,
tpSteps = 8,
tpHopDelay = 0.03,
tpJitter = 2.0,
stealJitter = 1.2,
minRarity = "Rare",
esp = true,
espMax = 120,
showOwn = true,
tpOffset = Vector3.new(0, 4, 0),
stealDelay = 0.18,
autoSteal = false,
autoStealRadius = 120,
autoStealInterval = 0.6,
toggleKey = Enum.KeyCode.RightControl,
configFile = "CabeHub_config.json",
}
local PERSIST_KEYS = {
"esp", "minRarity", "maxDistance", "showOwn", "autoSteal", "autoStealRadius",
"walkSpeed", "jumpPower", "noclip", "infiniteJump", "antiAfk", "fpsBoost",
}
local function loadConfig()
if typeof(readfile) ~= "function" or typeof(isfile) ~= "function" then return end
if not isfile(CONFIG.configFile) then return end
local raw = select(2, pcall(readfile, CONFIG.configFile))
if type(raw) ~= "string" then return end
local ok, data = pcall(function()
return game:GetService("HttpService"):JSONDecode(raw)
end)
if not ok or type(data) ~= "table" then return end
for _, key in ipairs(PERSIST_KEYS) do
local v = data[key]
if type(v) == type(CONFIG[key]) then CONFIG[key] = v end
end
end
local function saveConfig()
if typeof(writefile) ~= "function" then return end
local data = {}
for _, key in ipairs(PERSIST_KEYS) do data[key] = CONFIG[key] end
pcall(function()
writefile(CONFIG.configFile, game:GetService("HttpService"):JSONEncode(data))
end)
end
loadConfig()
local State = {
entries = {},
esp = {},
uiVisible = true,
running = true,
lastScanMs = 0,
lastFullScan = 0,
listSignature = "",
busy = false,
scanCount = 0,
current = {},
}
local connections = {}
local function notify(text, dur)
pcall(function()
StarterGui:SetCore("SendNotification", {
Title = "Egg Finder",
Text = text,
Duration = dur or 3,
})
end)
end
local function color(rgb)
return Color3.new(rgb[1], rgb[2], rgb[3])
end
local function rootPart()
local char = LP.Character
local hrp = char and char:FindFirstChild("HumanoidRootPart")
return hrp
end
local function pivotOf(inst)
if inst:IsA("BasePart") then return inst.Position end
local ok, cf = pcall(function() return inst:GetPivot().Position end)
if ok then return cf end
local prim = inst.PrimaryPart or inst:FindFirstChildWhichIsA("BasePart")
return prim and prim.Position or nil
end
local function distanceTo(inst)
local hrp = rootPart()
local pos = pivotOf(inst)
if not pos then return math.huge end
local origin = hrp and hrp.Position or Camera.Position
return (pos - origin).Magnitude
end
local function ownerOf(inst)
local attrNames = { "Owner", "OwnerName", "PlayerName", "BelongsTo", "Username" }
for _, name in ipairs(attrNames) do
local v = inst:GetAttribute(name)
if type(v) == "string" and v ~= "" then return v end
end
local node = inst
for _ = 1, 6 do
node = node.Parent
if not node or node == workspace then break end
for _, plr in ipairs(Players:GetPlayers()) do
if node.Name == plr.Name or node.Name == plr.DisplayName then
return plr.Name
end
end
local ownerAttr = node:GetAttribute("Owner")
if type(ownerAttr) == "string" and ownerAttr ~= "" then return ownerAttr end
end
return nil
end
local function promptOf(inst)
local found = inst:FindFirstChildWhichIsA("ProximityPrompt", true)
if found then return found end
local parent = inst.Parent
if parent then
found = parent:FindFirstChildWhichIsA("ProximityPrompt", true)
end
return found
end
local function attrRarity(inst)
for _, name in ipairs({ "Rarity", "RarityName", "Tier", "EggRarity" }) do
local v = inst:GetAttribute(name)
if type(v) == "string" then return v end
end
return nil
end
local function dropEntry(inst)
if State.entries[inst] then
State.entries[inst] = nil
State.count = math.max((State.count or 1) - 1, 0)
end
end
local function indexInstance(inst)
if State.entries[inst] then return end
if (State.count or 0) >= CONFIG.maxEntries then return end
if not inst:IsDescendantOf(workspace) then return end
if not Logic.CLASS_WHITELIST[inst.ClassName] then return end
local byName = Logic.isEggName(inst.Name)
if not byName then
if not Logic.rarityOfName(inst.Name) or not promptOf(inst) then return end
end
local tier = Logic.resolveRarity(inst.Name, attrRarity(inst))
if tier == Logic.UNKNOWN then
if not promptOf(inst) then return end
end
local ownerName = ownerOf(inst)
State.entries[inst] = {
inst = inst,
id = tostring(inst.GetDebugId and inst:GetDebugId() or inst.Name),
name = Logic.displayName(inst.Name),
rarity = tier.name,
rank = tier.rank,
rgb = tier.rgb,
distance = distanceTo(inst),
owner = ownerName,
isOwn = ownerName == LP.Name,
hasPrompt = promptOf(inst) ~= nil,
}
State.count = (State.count or 0) + 1
end
local function prune()
for inst, entry in pairs(State.entries) do
if not inst.Parent or not entry.inst:IsDescendantOf(workspace) then
dropEntry(inst)
end
end
end
local function fullScan()
local started = os.clock()
local budget = CONFIG.scanBudgetMs / 1000
local processed = 0
for _, inst in ipairs(workspace:GetDescendants()) do
processed += 1
if Logic.CLASS_WHITELIST[inst.ClassName]
and (Logic.isEggName(inst.Name)
or (inst:IsA("Model") and Logic.rarityOfName(inst.Name) ~= nil)) then
indexInstance(inst)
end
if processed % 250 == 0 and os.clock() - started > budget then
State.budgetHit = true
break
end
end
State.budgetHit = false
State.lastScanMs = (os.clock() - started) * 1000
local floorInterval = math.max(CONFIG.scanInterval, State.lastScanMs * 2 / 1000)
State.scanInterval = math.min(floorInterval, 5)
end
local function refreshDistances()
for inst, entry in pairs(State.entries) do
entry.distance = distanceTo(inst)
end
end
local function computeList()
return Logic.rank((function()
local out = {}
for _, entry in pairs(State.entries) do table.insert(out, entry) end
return out
end)(), {
minRank = Logic.resolveRarity(CONFIG.minRarity, nil).rank,
maxDistance = CONFIG.maxDistance,
query = State.query or "",
hideOwn = not CONFIG.showOwn,
})
end
local ESP_OWN_COLOR = Color3.new(0.55, 0.55, 0.6)
local function makeESP(entry)
local inst = entry.inst
local hl = Instance.new("Highlight")
hl.Name = "EggFinderHL"
hl.Adornee = inst
hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
hl.FillTransparency = 0.65
hl.OutlineTransparency = 0
hl.FillColor = color(entry.rgb)
hl.OutlineColor = color(entry.rgb)
hl.Parent = inst
local bb = Instance.new("BillboardGui")
bb.Name = "EggFinderLabel"
bb.Size = UDim2.fromOffset(190, 44)
bb.StudsOffset = Vector3.new(0, 3, 0)
bb.AlwaysOnTop = true
bb.MaxDistance = CONFIG.maxDistance
bb.LightInfluence = 0
bb.Adornee = inst
bb.Parent = inst
local label = Instance.new("TextLabel")
label.BackgroundTransparency = 1
label.Size = UDim2.fromScale(1, 1)
label.Font = Enum.Font.GothamBold
label.TextScaled = false
label.TextSize = 13
label.TextWrapped = true
label.TextColor3 = color(entry.rgb)
label.TextStrokeTransparency = 0.4
label.Text = string.format("%s\n[%s] %sm%s", entry.name, entry.rarity,
Logic.fmtDistance(entry.distance), entry.isOwn and " · mine" or "")
label.Parent = bb
State.esp[inst] = { hl = hl, label = label, bb = bb }
end
local function destroyESP(inst)
local rec = State.esp[inst]
if rec then
pcall(function()
rec.hl:Destroy()
rec.bb:Destroy()
end)
State.esp[inst] = nil
end
end
local function updateESPLabels(list)
for inst, rec in pairs(State.esp) do
local entry = State.entries[inst]
if entry and rec.label then
rec.bb.MaxDistance = CONFIG.maxDistance
rec.label.Text = string.format("%s\n[%s] %sm%s", entry.name, entry.rarity,
Logic.fmtDistance(entry.distance), entry.isOwn and " · mine" or "")
end
end
for inst, rec in pairs(State.esp) do
local entry = State.entries[inst]
if entry and entry.isOwn and rec.hl then
rec.hl.FillColor = ESP_OWN_COLOR
rec.hl.OutlineColor = ESP_OWN_COLOR
end
end
local i = 0
for _, entry in ipairs(list) do
i += 1
if i > CONFIG.espMax then destroyESP(entry.inst) end
end
end
local function syncESP(list)
if not CONFIG.esp then
for inst in pairs(State.esp) do destroyESP(inst) end
return
end
local keep = {}
for _, entry in ipairs(list) do
if not State.esp[entry.inst] then makeESP(entry) end
keep[entry.inst] = true
end
for inst in pairs(State.esp) do
if not keep[inst] then destroyESP(inst) end
end
updateESPLabels(list)
end
local lastTpAt = 0
local function teleportTo(pos)
local hrp = rootPart()
if not hrp or not pos then return false end
local gap = os.clock() - lastTpAt
if gap < CONFIG.tpCooldown then
task.wait(CONFIG.tpCooldown - gap)
end
lastTpAt = os.clock()
local dest = CFrame.new(pos + CONFIG.tpOffset)
* CFrame.Angles(0, (math.random() - 0.5) * 0.6, 0)
local start = hrp.CFrame
local hops = CONFIG.tpSteps + math.random(0, 2)
for i = 1, hops do
local alpha = i / hops
local jit = Vector3.new(
(math.random() - 0.5) * CONFIG.tpJitter,
(math.random() - 0.5) * CONFIG.tpJitter * 0.4,
(math.random() - 0.5) * CONFIG.tpJitter)
hrp.CFrame = start:Lerp(dest, alpha) + jit
hrp.AssemblyLinearVelocity = Vector3.zero
hrp.AssemblyAngularVelocity = Vector3.zero
task.wait(CONFIG.tpHopDelay)
end
hrp.CFrame = dest
hrp.AssemblyLinearVelocity = Vector3.zero
hrp.AssemblyAngularVelocity = Vector3.zero
return true
end
local function firePrompt(entry)
local prompt = promptOf(entry.inst)
if not prompt then return false end
local ok = pcall(function()
if typeof(fireproximityprompt) == "function" then
fireproximityprompt(prompt)
else
prompt:InputHoldBegin()
task.wait(math.min(prompt.HoldDuration, 0.2))
prompt:InputHoldEnd()
end
end)
return ok
end
local function goTo(entry, steal)
if not entry or not entry.inst.Parent then return end
local pos = pivotOf(entry.inst)
if not teleportTo(pos) then
notify("Character belum siap.")
return
end
if steal then
task.wait(CONFIG.stealDelay)
firePrompt(entry)
task.wait(0.12)
firePrompt(entry)
end
end
local function goNearest()
local list = State.current
if not list[1] then notify("Tidak ada egg dalam filter."); return end
goTo(list[1], false)
end
local function goBest()
local target = Logic.best(State.current, {})
if not target then notify("Tidak ada egg dalam filter."); return end
goTo(target, true)
end
local autoStealRunning = false
local function autoStealLoop()
if autoStealRunning then return end
autoStealRunning = true
local lastTargetName = nil
task.spawn(function()
while State.running and CONFIG.autoSteal do
local target = Logic.best(State.current, {
maxDistance = CONFIG.autoStealRadius,
hideOwn = true,
})
if target and not State.busy then
local name = target.inst and target.inst.Name
if name == lastTargetName then
lastTargetName = nil
task.wait(CONFIG.autoStealInterval + math.random() * CONFIG.stealJitter)
else
lastTargetName = name
State.busy = true
goTo(target, true)
task.wait(0.35 + math.random() * CONFIG.stealJitter)
State.busy = false
end
end
task.wait(CONFIG.autoStealInterval + math.random() * CONFIG.stealJitter)
end
autoStealRunning = false
end)
end
local function humanoid()
local char = LP.Character
return char and char:FindFirstChildOfClass("Humanoid")
end
local function applySpeed()
local hum = humanoid()
if hum then
pcall(function() hum.WalkSpeed = CONFIG.walkSpeed end)
end
end
local function applyJump()
local hum = humanoid()
if hum then
pcall(function()
if hum.UseJumpPower then
hum.JumpPower = CONFIG.jumpPower
else
hum.JumpHeight = CONFIG.jumpPower / 5
end
end)
end
end
local function applyCharacterTweaks()
applySpeed()
applyJump()
end
table.insert(connections, RunService.Stepped:Connect(function()
if not CONFIG.noclip or not LP.Character then return end
for _, part in ipairs(LP.Character:GetDescendants()) do
if part:IsA("BasePart") and part.CanCollide then
part.CanCollide = false
end
end
end))
table.insert(connections, UserInput.JumpRequest:Connect(function()
if not CONFIG.infiniteJump then return end
local hum = humanoid()
if hum then
pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end)
end
end))
table.insert(connections, LP.Idled:Connect(function()
if not CONFIG.antiAfk then return end
pcall(function()
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)
end))
table.insert(connections, LP.CharacterAdded:Connect(function()
task.wait(0.4)
applyCharacterTweaks()
end))
local fpsSaved = nil
local function setFpsBoost(on)
if on then
fpsSaved = {
shadows = Lighting.GlobalShadows,
fogEnd = Lighting.FogEnd,
reflect = Lighting.Reflectance,
}
pcall(function()
Lighting.GlobalShadows = false
Lighting.FogEnd = 1e6
Lighting.Reflectance = 0
Lighting.EnvironmentDiffuseScale = 0.5
Lighting.EnvironmentSpecularScale = 0.5
end)
elseif fpsSaved then
pcall(function()
Lighting.GlobalShadows = fpsSaved.shadows
Lighting.FogEnd = fpsSaved.fogEnd
Lighting.Reflectance = fpsSaved.reflect
end)
fpsSaved = nil
end
end
local function rejoin()
TeleportSvc:Teleport(game.PlaceId, LP)
end
local function new(class, props, parent)
local inst = Instance.new(class)
for key, value in pairs(props) do
if key ~= "Parent" then inst[key] = value end
end
if parent then inst.Parent = parent end
return inst
end
local UI = {}
local dumpStructure
local ACCENT = Color3.fromRGB(255, 196, 92)
local PANEL_BG = Color3.fromRGB(18, 18, 22)
local BTN_BG = Color3.fromRGB(32, 33, 40)
local BTN_ON = Color3.fromRGB(58, 92, 46)
local function buildUI()
local gui = new("ScreenGui", {
Name = "CabeHubUI",
ResetOnSpawn = false,
IgnoreGuiInset = true,
DisplayOrder = 50,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, LP:WaitForChild("PlayerGui"))
UI.gui = gui
local panel = new("Frame", {
Size = UDim2.fromOffset(348, 452),
Position = UDim2.fromOffset(24, 76),
BackgroundColor3 = PANEL_BG,
BackgroundTransparency = 0.05,
BorderSizePixel = 0,
Active = true,
}, gui)
UI.panel = panel
new("UICorner", { CornerRadius = UDim.new(0, 10) }, panel)
new("UIStroke", { Color = ACCENT, Transparency = 0.55, Thickness = 1 }, panel)
local header = new("Frame", {
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = ACCENT,
BackgroundTransparency = 0.75,
BorderSizePixel = 0,
}, panel)
new("UICorner", { CornerRadius = UDim.new(0, 10) }, header)
new("TextLabel", {
Size = UDim2.new(1, -40, 1, 0),
Position = UDim2.fromOffset(12, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
TextSize = 13,
TextXAlignment = Enum.TextXAlignment.Left,
TextColor3 = ACCENT,
Text = "CABEHUB · Steal An Egg",
}, header)
local close = new("TextButton", {
Size = UDim2.fromOffset(26, 26),
Position = UDim2.new(1, -32, 0, 4),
BackgroundColor3 = BTN_BG,
Font = Enum.Font.GothamBold,
TextSize = 14,
TextColor3 = Color3.fromRGB(255, 120, 120),
Text = "✕",
BorderSizePixel = 0,
}, header)
new("UICorner", { CornerRadius = UDim.new(0, 6) }, close)
close.MouseButton1Click:Connect(function() gui.Enabled = false end)
UI.stats = new("TextLabel", {
Size = UDim2.new(1, -24, 0, 20),
Position = UDim2.fromOffset(12, 40),
BackgroundTransparency = 1,
Font = Enum.Font.Code,
TextSize = 11,
TextXAlignment = Enum.TextXAlignment.Left,
TextColor3 = Color3.fromRGB(160, 165, 175),
Text = "scanning…",
}, panel)
local function button(text, x, y, w, h, onClick)
local btn = new("TextButton", {
Size = UDim2.fromOffset(w, h),
Position = UDim2.fromOffset(x, y),
BackgroundColor3 = BTN_BG,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = Color3.fromRGB(228, 230, 238),
Text = text,
BorderSizePixel = 0,
AutoButtonColor = true,
}, panel)
new("UICorner", { CornerRadius = UDim.new(0, 6) }, btn)
btn.MouseButton1Click:Connect(onClick)
return btn
end
local function styleToggle(btn, on)
btn.BackgroundColor3 = on and BTN_ON or BTN_BG
btn.TextColor3 = on and Color3.fromRGB(214, 255, 200) or Color3.fromRGB(228, 230, 238)
end
UI.espBtn = button("ESP", 12, 66, 66, 24, function() end)
UI.rarityBtn = button("Rare+", 84, 66, 84, 24, function() end)
UI.distBtn = button("3000m", 174, 66, 76, 24, function() end)
UI.ownBtn = button("Mine", 256, 66, 80, 24, function() end)
UI.espBtn.MouseButton1Click:Connect(function()
CONFIG.esp = not CONFIG.esp
styleToggle(UI.espBtn, CONFIG.esp)
saveConfig()
end)
UI.rarityBtn.MouseButton1Click:Connect(function()
local idx = 1
for i, t in ipairs(Logic.TIERS) do
if t.name == CONFIG.minRarity then idx = i end
end
idx = idx % #Logic.TIERS + 1
CONFIG.minRarity = Logic.TIERS[idx].name
UI.rarityBtn.Text = CONFIG.minRarity .. "+"
saveConfig()
end)
local DIST_STEPS = { 60, 150, 400, 1000, 3000, 100000 }
UI.distBtn.MouseButton1Click:Connect(function()
local idx = 1
for i, v in ipairs(DIST_STEPS) do
if v == CONFIG.maxDistance then idx = i end
end
idx = idx % #DIST_STEPS + 1
CONFIG.maxDistance = DIST_STEPS[idx]
UI.distBtn.Text = CONFIG.maxDistance >= 100000 and "∞" or (CONFIG.maxDistance .. "m")
saveConfig()
end)
UI.ownBtn.MouseButton1Click:Connect(function()
CONFIG.showOwn = not CONFIG.showOwn
styleToggle(UI.ownBtn, CONFIG.showOwn)
saveConfig()
end)
UI.tpNear = button("TP Terdekat", 12, 98, 106, 26, goNearest)
UI.tpBest = button("TP Terbaik", 124, 98, 106, 26, goBest)
UI.autoBtn = button("Auto-Steal", 236, 98, 100, 26, function()
CONFIG.autoSteal = not CONFIG.autoSteal
styleToggle(UI.autoBtn, CONFIG.autoSteal)
if CONFIG.autoSteal then autoStealLoop() end
saveConfig()
end)
UI.search = new("TextBox", {
Size = UDim2.new(1, -24, 0, 24),
Position = UDim2.fromOffset(12, 132),
BackgroundColor3 = BTN_BG,
Font = Enum.Font.Gotham,
TextSize = 11,
PlaceholderText = "cari nama egg…",
PlaceholderColor3 = Color3.fromRGB(120, 124, 134),
TextColor3 = Color3.fromRGB(235, 235, 240),
Text = "",
ClearTextOnFocus = false,
BorderSizePixel = 0,
}, panel)
new("UICorner", { CornerRadius = UDim.new(0, 6) }, UI.search)
UI.search:GetPropertyChangedSignal("Text"):Connect(function()
State.query = Logic.normalize(UI.search.Text)
end)
local function newScroll()
local frame = new("ScrollingFrame", {
Size = UDim2.new(1, -24, 1, -232),
Position = UDim2.fromOffset(12, 190),
BackgroundColor3 = Color3.fromRGB(12, 12, 15),
BorderSizePixel = 0,
ScrollBarThickness = 4,
ScrollBarImageColor3 = ACCENT,
CanvasSize = UDim2.new(),
AutomaticCanvasSize = Enum.AutomaticSize.Y,
Visible = false,
}, panel)
new("UICorner", { CornerRadius = UDim.new(0, 8) }, frame)
new("UIListLayout", {
Padding = UDim.new(0, 3),
SortOrder = Enum.SortOrder.LayoutOrder,
}, frame)
return frame
end
UI.list = newScroll()
UI.list.Visible = true
UI.pList = newScroll()
UI.mList = newScroll()
local function baseRow(parent, order)
local row = new("Frame", {
Size = UDim2.new(1, -4, 0, 32),
BackgroundColor3 = Color3.fromRGB(24, 24, 30),
BackgroundTransparency = 0.15,
BorderSizePixel = 0,
LayoutOrder = order,
}, parent)
new("UICorner", { CornerRadius = UDim.new(0, 6) }, row)
return row
end
local function toggleRow(parent, order, label, get, set)
local row = baseRow(parent, order)
new("TextLabel", {
Size = UDim2.new(1, -96, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamMedium,
TextSize = 12,
TextXAlignment = Enum.TextXAlignment.Left,
TextColor3 = Color3.fromRGB(228, 230, 238),
Text = label,
}, row)
local btn = new("TextButton", {
Size = UDim2.fromOffset(64, 24),
Position = UDim2.new(1, -72, 0, 4),
BackgroundColor3 = BTN_BG,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = Color3.fromRGB(228, 230, 238),
Text = get() and "ON" or "OFF",
BorderSizePixel = 0,
}, row)
new("UICorner", { CornerRadius = UDim.new(0, 6) }, btn)
btn.MouseButton1Click:Connect(function()
set(not get())
btn.Text = get() and "ON" or "OFF"
btn.BackgroundColor3 = get() and BTN_ON or BTN_BG
btn.TextColor3 = get() and Color3.fromRGB(214, 255, 200) or Color3.fromRGB(228, 230, 238)
end)
btn.BackgroundColor3 = get() and BTN_ON or BTN_BG
btn.TextColor3 = get() and Color3.fromRGB(214, 255, 200) or Color3.fromRGB(228, 230, 238)
end
local function adjustRow(parent, order, label, get, set, step, minV, maxV)
local row = baseRow(parent, order)
new("TextLabel", {
Size = UDim2.new(1, -150, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamMedium,
TextSize = 12,
TextXAlignment = Enum.TextXAlignment.Left,
TextColor3 = Color3.fromRGB(228, 230, 238),
Text = label,
}, row)
local value = new("TextLabel", {
Size = UDim2.fromOffset(52, 24),
Position = UDim2.new(1, -134, 0, 4),
BackgroundColor3 = Color3.fromRGB(16, 16, 20),
Font = Enum.Font.Code,
TextSize = 12,
TextColor3 = ACCENT,
Text = tostring(get()),
BorderSizePixel = 0,
}, row)
new("UICorner", { CornerRadius = UDim.new(0, 6) }, value)
local function bump(delta)
local v = math.clamp(get() + delta, minV, maxV)
set(v)
value.Text = tostring(v)
end
local minus = new("TextButton", {
Size = UDim2.fromOffset(30, 24),
Position = UDim2.new(1, -66, 0, 4),
BackgroundColor3 = BTN_BG,
Font = Enum.Font.GothamBold,
TextSize = 14,
TextColor3 = Color3.fromRGB(255, 150, 150),
Text = "-",
BorderSizePixel = 0,
}, row)
new("UICorner", { CornerRadius = UDim.new(0, 6) }, minus)
minus.MouseButton1Click:Connect(function() bump(-step) end)
local plus = new("TextButton", {
Size = UDim2.fromOffset(30, 24),
Position = UDim2.new(1, -32, 0, 4),
BackgroundColor3 = BTN_BG,
Font = Enum.Font.GothamBold,
TextSize = 14,
TextColor3 = Color3.fromRGB(160, 255, 160),
Text = "+",
BorderSizePixel = 0,
}, row)
new("UICorner", { CornerRadius = UDim.new(0, 6) }, plus)
plus.MouseButton1Click:Connect(function() bump(step) end)
end
local function actionRow(parent, order, label, cb)
local row = baseRow(parent, order)
local btn = new("TextButton", {
Size = UDim2.new(1, -20, 0, 24),
Position = UDim2.fromOffset(10, 4),
BackgroundColor3 = BTN_BG,
Font = Enum.Font.GothamBold,
TextSize = 12,
TextColor3 = Color3.fromRGB(228, 230, 238),
Text = label,
BorderSizePixel = 0,
}, row)
new("UICorner", { CornerRadius = UDim.new(0, 6) }, btn)
btn.MouseButton1Click:Connect(cb)
end
adjustRow(UI.pList, 1, "WalkSpeed", function() return CONFIG.walkSpeed end,
function(v) CONFIG.walkSpeed = v applySpeed() saveConfig() end, 4, 16, 150)
adjustRow(UI.pList, 2, "JumpPower", function() return CONFIG.jumpPower end,
function(v) CONFIG.jumpPower = v applyJump() saveConfig() end, 10, 50, 300)
toggleRow(UI.pList, 3, "Noclip", function() return CONFIG.noclip end,
function(v) CONFIG.noclip = v saveConfig() end)
toggleRow(UI.pList, 4, "Infinite Jump", function() return CONFIG.infiniteJump end,
function(v) CONFIG.infiniteJump = v saveConfig() end)
toggleRow(UI.mList, 1, "Anti-AFK", function() return CONFIG.antiAfk end,
function(v) CONFIG.antiAfk = v saveConfig() end)
toggleRow(UI.mList, 2, "FPS Boost", function() return CONFIG.fpsBoost end,
function(v) CONFIG.fpsBoost = v setFpsBoost(v) saveConfig() end)
actionRow(UI.mList, 3, "Rejoin Server", rejoin)
actionRow(UI.mList, 4, "Reset Filter Egg", function()
CONFIG.minRarity = "Rare"
CONFIG.maxDistance = 3000
UI.rarityBtn.Text = CONFIG.minRarity .. "+"
UI.distBtn.Text = "3000m"
State.entries = {}
State.count = 0
State.listSignature = ""
fullScan()
end)
local TABS = {
{ btn = nil, frame = UI.list, name = "EGG" },
{ btn = nil, frame = UI.pList, name = "PLAYER" },
{ btn = nil, frame = UI.mList, name = "MISC" },
}
local tabX = { 12, 122, 232 }
for i, tab in ipairs(TABS) do
tab.btn = new("TextButton", {
Size = UDim2.fromOffset(104, 22),
Position = UDim2.fromOffset(tabX[i], 160),
BackgroundColor3 = BTN_BG,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = Color3.fromRGB(228, 230, 238),
Text = tab.name,
BorderSizePixel = 0,
}, panel)
new("UICorner", { CornerRadius = UDim.new(0, 6) }, tab.btn)
end
local function selectTab(idx)
for i, tab in ipairs(TABS) do
tab.frame.Visible = (i == idx)
tab.btn.BackgroundColor3 = (i == idx) and BTN_ON or BTN_BG
tab.btn.TextColor3 = (i == idx) and Color3.fromRGB(214, 255, 200) or Color3.fromRGB(228, 230, 238)
end
end
for i, tab in ipairs(TABS) do
tab.btn.MouseButton1Click:Connect(function() selectTab(i) end)
end
selectTab(1)
local footer = new("Frame", {
Size = UDim2.new(1, -24, 0, 24),
Position = UDim2.new(0, 12, 1, -32),
BackgroundTransparency = 1,
}, panel)
local function footerBtn(text, x, onClick)
local btn = new("TextButton", {
Size = UDim2.fromOffset(96, 24),
Position = UDim2.fromOffset(x, 0),
BackgroundColor3 = BTN_BG,
Font = Enum.Font.GothamBold,
TextSize = 11,
TextColor3 = Color3.fromRGB(228, 230, 238),
Text = text,
BorderSizePixel = 0,
}, footer)
new("UICorner", { CornerRadius = UDim.new(0, 6) }, btn)
btn.MouseButton1Click:Connect(onClick)
end
footerBtn("Rescan", 0, function()
State.entries = {}
State.count = 0
State.listSignature = ""
fullScan()
end)
footerBtn("Dump", 104, dumpStructure)
footerBtn("Hapus ESP", 208, function()
for inst in pairs(State.esp) do destroyESP(inst) end
end)
local dragging, dragStart, startPos = false, nil, nil
header.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1
or input.UserInputType == Enum.UserInputType.Touch then
dragging = true
dragStart = input.Position
startPos = panel.Position
end
end)
header.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1
or input.UserInputType == Enum.UserInputType.Touch then
dragging = false
end
end)
table.insert(connections, UserInput.InputChanged:Connect(function(input)
if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
local delta = input.Position - dragStart
panel.Position = UDim2.fromOffset(
startPos.X.Offset + delta.X,
startPos.Y.Offset + delta.Y
)
end
end))
styleToggle(UI.espBtn, CONFIG.esp)
styleToggle(UI.ownBtn, CONFIG.showOwn)
styleToggle(UI.autoBtn, CONFIG.autoSteal)
UI.rarityBtn.Text = CONFIG.minRarity .. "+"
UI.distBtn.Text = CONFIG.maxDistance >= 100000 and "∞" or (CONFIG.maxDistance .. "m")
State.query = ""
end
local function clearList()
for _, child in ipairs(UI.list:GetChildren()) do
if child:IsA("Frame") or child.Name == "More" then child:Destroy() end
end
end
local function addRow(entry, order)
local row = new("Frame", {
Size = UDim2.new(1, -4, 0, 30),
BackgroundColor3 = Color3.fromRGB(24, 24, 30),
BackgroundTransparency = entry.isOwn and 0.55 or 0.15,
BorderSizePixel = 0,
LayoutOrder = order,
}, UI.list)
new("UICorner", { CornerRadius = UDim.new(0, 6) }, row)
local bar = new("Frame", {
Size = UDim2.new(0, 3, 1, -8),
Position = UDim2.fromOffset(2, 4),
BackgroundColor3 = color(entry.rgb),
BorderSizePixel = 0,
}, row)
new("UICorner", { CornerRadius = UDim.new(0, 3) }, bar)
new("TextLabel", {
Size = UDim2.new(1, -110, 1, 0),
Position = UDim2.fromOffset(10, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamMedium,
TextSize = 11,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
TextColor3 = color(entry.rgb),
Text = string.format("%s · %s · %sm%s", entry.name, entry.rarity,
Logic.fmtDistance(entry.distance), entry.owner and (" · " .. entry.owner) or ""),
}, row)
local tp = new("TextButton", {
Size = UDim2.fromOffset(38, 22),
Position = UDim2.new(1, -86, 0, 4),
BackgroundColor3 = BTN_BG,
Font = Enum.Font.GothamBold,
TextSize = 10,
TextColor3 = Color3.fromRGB(210, 220, 255),
Text = "TP",
BorderSizePixel = 0,
}, row)
new("UICorner", { CornerRadius = UDim.new(0, 5) }, tp)
tp.MouseButton1Click:Connect(function() goTo(entry, false) end)
local st = new("TextButton", {
Size = UDim2.fromOffset(38, 22),
Position = UDim2.new(1, -44, 0, 4),
BackgroundColor3 = BTN_BG,
Font = Enum.Font.GothamBold,
TextSize = 10,
TextColor3 = ACCENT,
Text = "CURI",
BorderSizePixel = 0,
}, row)
new("UICorner", { CornerRadius = UDim.new(0, 5) }, st)
st.MouseButton1Click:Connect(function() goTo(entry, true) end)
end
local function refreshUI()
if not UI.gui then return end
local list = State.current
local sig = Logic.signature(list)
UI.stats.Text = string.format("egg: %d · terfilter: %d · scan %.1fms · %s",
(function()
local n = 0
for _ in pairs(State.entries) do n += 1 end
return n
end)(), #list, State.lastScanMs,
CONFIG.autoSteal and "AUTO ON" or "idle")
if sig ~= State.listSignature then
State.listSignature = sig
clearList()
for i = 1, math.min(#list, 60) do
addRow(list[i], i)
end
if #list > 60 then
local more = new("TextLabel", {
Size = UDim2.new(1, 0, 0, 18),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
TextSize = 10,
TextColor3 = Color3.fromRGB(140, 140, 150),
Text = string.format("+%d egg lain disembunyikan", #list - 60),
LayoutOrder = 999,
}, UI.list)
more.Name = "More"
end
end
end
function dumpStructure()
local lines = { "=== EGG FINDER DUMP · " .. os.date("%Y-%m-%d %H:%M:%S") .. " ===" }
local path = ""
local count = 0
local function note(inst, entry, extra)
count += 1
local node, segs = inst, {}
for _ = 1, 5 do
node = node.Parent
if not node or node == game then break end
table.insert(segs, 1, node.Name)
end
table.insert(lines, string.format(
"%d) %s%s\n   class=%s size=%s full=%s ancestor=%s prompt=%s%s",
count,
table.concat(segs, "/"),
(#segs > 0 and "/" or "") .. inst.Name,
inst.ClassName,
tostring(#inst:GetDescendants()) .. " descendants",
tostring(entry and entry.rarity or "-"),
tostring(inst:GetAttribute("Rarity") or inst:GetAttribute("RarityName") or "-"),
tostring(promptOf(inst) ~= nil),
extra or ""
))
end
for inst, entry in pairs(State.entries) do
note(inst, entry)
if count >= 120 then break end
end
if count < 60 then
table.insert(lines, "--- folder/container kandidat ---")
for _, inst in ipairs(workspace:GetDescendants()) do
if (inst:IsA("Folder") or inst:IsA("Configuration"))
and Logic.normalize(inst.Name):find("egg", 1, true) then
table.insert(lines, "folder: " .. inst:GetFullName())
end
if #lines > 400 then break end
end
end
local text = table.concat(lines, "\n")
if typeof(writefile) == "function" then
path = "CabeHub_dump.txt"
pcall(writefile, path, text)
end
for _, chunk in ipairs((function()
local out = {}
for i = 1, #text, 900 do
table.insert(out, text:sub(i, i + 899))
end
return out
end)()) do
print(chunk)
end
notify(#lines .. " baris dump. " .. (path ~= "" and ("File: " .. path) or "Cek console (F9)."), 6)
end
local function bindEvents()
table.insert(connections, workspace.DescendantAdded:Connect(function(inst)
if not Logic.CLASS_WHITELIST[inst.ClassName] then return end
if Logic.isEggName(inst.Name) or Logic.rarityOfName(inst.Name) then
task.defer(indexInstance, inst)
end
end))
table.insert(connections, workspace.DescendantRemoving:Connect(function(inst)
if State.entries[inst] then
destroyESP(inst)
dropEntry(inst)
end
end))
end
table.insert(connections, UserInput.InputBegan:Connect(function(input, gp)
if gp then return end
if input.KeyCode == CONFIG.toggleKey then
if UI.gui then
UI.gui.Enabled = not UI.gui.Enabled
end
end
end))
local function mainLoop()
task.spawn(function()
task.wait(0.5)
fullScan()
State.lastFullScan = os.clock()
while State.running do
prune()
if os.clock() - State.lastFullScan > CONFIG.rescanEvery then
State.lastFullScan = os.clock()
fullScan()
end
refreshDistances()
State.current = computeList()
syncESP(State.current)
refreshUI()
task.wait(State.scanInterval or CONFIG.scanInterval)
end
end)
end
ENV.__CABE_HUB_CLEANUP = function()
State.running = false
CONFIG.autoSteal = false
setFpsBoost(false)
for _, conn in ipairs(connections) do pcall(function() conn:Disconnect() end) end
for inst in pairs(State.esp) do destroyESP(inst) end
if UI.gui then pcall(function() UI.gui:Destroy() end) end
ENV.__CABE_HUB_CLEANUP = nil
end
ENV.__EGG_FINDER_CLEANUP = ENV.__CABE_HUB_CLEANUP
buildUI()
bindEvents()
mainLoop()
applyCharacterTweaks()
if CONFIG.fpsBoost then setFpsBoost(true) end
if game.PlaceId ~= CONFIG.placeId then
notify(string.format("PlaceId %d bukan Steal An Egg (%d) — script tetap jalan.",
game.PlaceId, CONFIG.placeId), 6)
else
notify("CabeHub siap. RightControl = sembunyikan UI.", 4)
end
print("[CabeHub] loaded · placeId=" .. tostring(game.PlaceId) ..
" · rarity table=" .. tostring((function()
local n = 0
for _ in pairs(Logic.EGG_TABLE) do n += 1 end
return n
end)()) .. " entri")
