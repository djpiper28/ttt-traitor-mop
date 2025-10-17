local name = "ttt-traitor-mop"
print("[" + name +  "] mop has been loaded...")

local model = "models/tf2/props/mop_and_bucket"

--[[Author informations]]--
SWEP.Author = "djpiper28"
SWEP.Contact = "https://steamcommunity.com/#scrollTop=0"


if CLIENT then
  SWEP.PrintName = name
  SWEP.Slot = 5
  SWEP.Icon = "VGUI/ttt/icon_mop"
end

-- SWEP STUFF
-- always derive from weapon_tttbase
SWEP.Base = "weapon_tttbase"
SWEP.HoldType = "slam"
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 1
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.UseHands = true
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 54
SWEP.ViewModel = "models/weapons/v_slam.mdl"
SWEP.WorldModel = "models/weapons/w_c4.mdl"

-- TTT CONFIGURATION
SWEP.Kind = WEAPON_ROLE
SWEP.AutoSpawnable = false
SWEP.CanBuy = { ROLE_TRAITOR }
SWEP.InLoadoutFor = { nil }
SWEP.LimitedStock = true
SWEP.AllowDrop = false
SWEP.IsSilent = false
SWEP.NoSights = true

if CLIENT then
  -- Equipment menu information is only needed on the client
  SWEP.EquipMenuData = {
    name = "Mop",
    type = "item_weapon",
    desc = "Have you had an accident (small homocide)?\nAre you floors covered in filth (blood, guts, and assorted viscera)?\nThis item will clean all of that muck up!"
  }
end

function SWEP:Reload()
  return false
end

function SWEP:Initialize()
  self:SetHoldType(self.HoldType)

  -- TODO: Precache wahtever crap this mod ends up using

  -- util.PrecacheSound("weapons/bomb_vest/countdown.wav")

  -- util.PrecacheModel("models/humans/charple01.mdl")
end

function SWEP:PrimaryAttack()
  if SERVER then
    -- TODO: cleanup some gore
  end
end
