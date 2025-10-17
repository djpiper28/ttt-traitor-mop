local name = "ttt_traitor_mop"
print("[" .. name ..  "] mop has been loaded...")

--[[Author informations]]--
SWEP.Author = "djpiper28"
SWEP.Contact = "https://steamcommunity.com/#scrollTop=0"

if SERVER then
  AddCSLuaFile()

  resource.AddFile("materials/VGUI/ttt/icon_mop.vmt")
  resource.AddFile("models/props_junk/metalbucket01a.mdl")
  resource.AddFile("models/weapons/v_slam.mdl")
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
SWEP.Primary.Delay = 1.0
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Delay = 1.0
SWEP.UseHands = true
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 54
SWEP.ViewModel = "models/weapons/v_slam.mdl"
SWEP.WorldModel = "models/props_junk/metalbucket01a.mdl"

-- TTT CONFIGURATION
SWEP.Kind = WEAPON_ROLE
SWEP.AutoSpawnable = false
SWEP.CanBuy = { ROLE_TRAITOR, ROLE_DETECTIVE }
SWEP.InLoadoutFor = { nil }
SWEP.LimitedStock = true
SWEP.AllowDrop = false
SWEP.IsSilent = false
SWEP.NoSights = true

SWEP.MeleeDamage = 25
SWEP.MeleeRange = 75

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

    self:EmitSound("Weapon_Crowbar.Miss")

    local pos = ply:GetPos()
    local radius = 128

    -- A table of entity classes to remove
    local to_remove = {
      "point_devshot",
      "effect_blood",
      "prop_ragdoll",
      "gmod_bullet",
      "bloodstream",
      "blood_impact",
      "env_blood"
    }

    for _, ent in ipairs(ents.FindInSphere(pos, radius)) do
      if table.HasValue(to_remove, ent:GetClass()) then
        ent:Remove()
      end
    end
  end
end

function SWEP:SecondaryAttack()
   self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
   self.Owner:SetAnimation( PLAYER_ATTACK1 )

   if SERVER then
      local tr = util.TraceLine({
         start = self.Owner:GetShootPos(),
         endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.MeleeRange,
         filter = self.Owner
      })

      if tr.Hit then
         local dmg = DamageInfo()
         dmg:SetDamage( self.MeleeDamage )
         dmg:SetAttacker( self.Owner )
         dmg:SetInflictor( self )
         dmg:SetDamageForce( self.Owner:GetAimVector() * 3000 )
         dmg:SetDamagePosition( tr.HitPos )
         dmg:SetDamageType( DMG_CLUB )

         if IsValid(tr.Entity) then
            tr.Entity:TakeDamageInfo( dmg )
         end

         -- Play a hit sound
         self:EmitSound("Weapon_Crowbar.Hit")
      else
         -- Play a miss sound
         self:EmitSound("Weapon_Crowbar.Miss")
      end
   end
end
