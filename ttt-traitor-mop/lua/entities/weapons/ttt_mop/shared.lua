local name = "ttt_traitor_mop"
print("[" + name +  "] mop has been loaded...")

--[[Author informations]]--
SWEP.Author = "djpiper28"
SWEP.Contact = "https://steamcommunity.com/#scrollTop=0"


if SERVER then
  AddCSLuaFile()

  resource.AddFile("materials/VGUI/ttt/icon_mop.vmt")
end

if CLIENT then
  SWEP.PrintName = "Mop"
  SWEP.Slot = 7
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
-- NOTE: Using a prop as a viewmodel might require position adjustments.
SWEP.ViewModel = "models/tf2/props/mop_and_bucket.mdl"
SWEP.WorldModel = "models/tf2/props/mop_and_bucket.mdl"

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

function SWEP:Initialize()
  self:SetHoldType(self.HoldType)
end

function SWEP:PrimaryAttack()
  if SERVER then
    local ply = self.Owner
    if not IsValid(ply) then return end

    ply:EmitSound("Weapon_Crowbar.Single")

    local pos = ply:GetPos()
    local radius = 128

    -- A table of entity classes to remove
    local to_remove = {
      "point_devshot",
      "effect_blood",
      "prop_ragdoll",
      "gmod_bullet"
    }

    for _, ent in ipairs(ents.FindInSphere(pos, radius)) do
      if table.HasValue(to_remove, ent:GetClass()) then
        ent:Remove()
      end
    end
  end
end
