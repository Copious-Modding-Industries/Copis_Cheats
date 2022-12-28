local player = GetUpdatedEntityID()
teleport_presets = {
    {
        icon = "mods/Copis_Cheats/files/ui_gfx/teleports/spawn.png",
        name = "Spawn",
        tooltip = "Teleport to the start of the game.",
        lmb_fn = function()
            local destination = {
                x = tonumber(MagicNumbersGetValue("DESIGN_PLAYER_START_POS_X")),
                y = tonumber(MagicNumbersGetValue("DESIGN_PLAYER_START_POS_Y"))
            }
            EntitySetTransform(player, destination.x, destination.y)
        end,
        rmb_fn = function() end,
    },
    {
        icon = "mods/Copis_Cheats/files/ui_gfx/teleports/mines.png",
        name = "Mines",
        tooltip = "Teleport to the the Mines",
        lmb_fn = function()
            local x, y = EntityGetTransform(player)
            local pw = GetParallelWorldPosition(x, y)
            local dest = {
                x=227,
                y=-100
            }
            dest.x = dest.x  + pw * 35840
            EntitySetTransform(player, dest.x, dest.y)
        end,
        rmb_fn = function() end,
    },
    {
        icon = "mods/Copis_Cheats/files/ui_gfx/teleports/excavationsite.png",
        name = "Coal Pits",
        tooltip = "Teleport to the Coal Pits",
        lmb_fn = function()
            local x, y = EntityGetTransform(player)
            local pw = GetParallelWorldPosition(x, y)
            local dest = {
                x=190,
                y=1500
            }
            dest.x = dest.x  + pw * 35840
            EntitySetTransform(player, dest.x, dest.y)
        end,
        rmb_fn = function() end,
    },
    {
        icon = "mods/Copis_Cheats/files/ui_gfx/teleports/snowcave.png",
        name = "Snowy Depths Holy Mountain",
        tooltip = "Teleport to the holy mountain at the end of the Snowy Depths",
        lmb_fn = function()
            local x, y = EntityGetTransform(player)
            local pw = GetParallelWorldPosition(x, y)
            local dest = {
                x=190,
                y=3000
            }
            dest.x = dest.x  + pw * 35840
            EntitySetTransform(player, dest.x, dest.y)
        end,
        rmb_fn = function() end,
    },
    {
        icon = "mods/Copis_Cheats/files/ui_gfx/teleports/hiisi.png",
        name = "Hiisi Base Holy Mountain",
        tooltip = "Teleport to the holy mountain at the end of the Hiisi Base",
        lmb_fn = function()
            local x, y = EntityGetTransform(player)
            local pw = GetParallelWorldPosition(x, y)
            local dest = {
                x=190,
                y=5000
            }
            dest.x = dest.x  + pw * 35840
            EntitySetTransform(player, dest.x, dest.y)
        end,
        rmb_fn = function() end,
    },
    {
        icon = "mods/Copis_Cheats/files/ui_gfx/teleports/jungle.png",
        name = "Underground Jungle Holy Mountain",
        tooltip = "Teleport to the holy mountain at the end of the Underground Jungle",
        lmb_fn = function()
            local x, y = EntityGetTransform(player)
            local pw = GetParallelWorldPosition(x, y)
            local dest = {
                x=190,
                y=6500
            }
            dest.x = dest.x  + pw * 35840
            EntitySetTransform(player, dest.x, dest.y)
        end,
        rmb_fn = function() end,
    },
    {
        icon = "mods/Copis_Cheats/files/ui_gfx/teleports/vault.png",
        name = "The Vault Holy Mountain",
        tooltip = "Teleport to the holy mountain at the end of The Vault",
        lmb_fn = function()
            local x, y = EntityGetTransform(player)
            local pw = GetParallelWorldPosition(x, y)
            local dest = {
                x=190,
                y=8500
            }
            dest.x = dest.x  + pw * 35840
            EntitySetTransform(player, dest.x, dest.y)
        end,
        rmb_fn = function() end,
    },
    {
        icon = "mods/Copis_Cheats/files/ui_gfx/teleports/tota.png",
        name = "Temple of the Art Holy Mountain",
        tooltip = "Teleport to the holy mountain at the end of the Temple of the Art",
        lmb_fn = function()
            local x, y = EntityGetTransform(player)
            local pw = GetParallelWorldPosition(x, y)
            local dest = {
                x=190,
                y=10700
            }
            dest.x = dest.x  + pw * 35840
            EntitySetTransform(player, dest.x, dest.y)
        end,
        rmb_fn = function() end,
    },
    {
        icon = "mods/Copis_Cheats/files/ui_gfx/teleports/boss_centipede.png",
        name = "Kolmisilmä Arena",
        tooltip = "Teleport to the final boss arena",
        lmb_fn = function()
            local dest = {
                x=3500,
                y=13060
            }
            EntitySetTransform(player, dest.x, dest.y)

        end,
        rmb_fn = function() end,
    },
    {
        icon = "mods/Copis_Cheats/files/ui_gfx/teleports/sky.png",
        name = "The Work (Sky)",
        tooltip = "Teleport to the Sky",
        lmb_fn = function()
            local x, y = EntityGetTransform(player)
            local pw = GetParallelWorldPosition(x, y)
            local dest = {
                x=3500,
                y=13060
            }
            dest.x = dest.x  + pw * 35840
            EntitySetTransform(player, dest.x, dest.y)

        end,
        rmb_fn = function() end,
    },
    {
        icon = "mods/Copis_Cheats/files/ui_gfx/teleports/hell.png",
        name = "The Work (Hell)",
        tooltip = "Teleport to Hell",
        lmb_fn = function()
            local dest = {}
            local x, y = EntityGetTransform(player)
            local pw = GetParallelWorldPosition(x, y)

        end,
        rmb_fn = function() end,
    },
    {
        icon = "mods/Copis_Cheats/files/ui_gfx/teleports/end.png",
        name = "The Work (End)",
        tooltip = "Teleport to the End",
        lmb_fn = function()
            local dest = {}
            local x, y = EntityGetTransform(player)
            local pw = GetParallelWorldPosition(x, y)
            EntitySetTransform(player, 6241 + pw * 35840, 15130)
        end,
        rmb_fn = function() end,
    },
    {
        icon = "mods/Copis_Cheats/files/ui_gfx/teleports/pw.png",
        name = "Warp Parallel Dimensions",
        tooltip = function()
            local dest = {}
            local x, y = EntityGetTransform(player)
            local pw = GetParallelWorldPosition(x, y)
            local world = "main"
            if pw < 0 then
                world = "west"
            elseif pw > 0 then
                world = "east"
            end
            return ("Current parallel world: %s %s\n[LMB] to travel 1 west,\n[RMB] to travel 1 east"):format(tostring(math.abs(pw)), world) end,
        lmb_fn = function()
            local x, y = EntityGetTransform(player)
            local ng = tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT"))
            GamePrint(tostring(ng))
            EntitySetTransform(player, x - 35840, y)
        end,
        rmb_fn = function()
            local x, y = EntityGetTransform(player)
            local ng = tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT"))
            GamePrint(tostring(ng))
            EntitySetTransform(player, x + 35840, y)
        end,
    },
    {
        icon = "mods/Copis_Cheats/files/ui_gfx/teleports/gold1.png",
        name = "Gold 1",
        tooltip = "Teleport to the northeast Gold biome",
        lmb_fn = function()
            local dest = {}
            local x, y = EntityGetTransform(player)
            local pw = GetParallelWorldPosition(x, y)
            --EntitySetTransform(player, 6241 + pw * 35840, 15130)
        end,
        rmb_fn = function() end,
    },
    {
        icon = "mods/Copis_Cheats/files/ui_gfx/teleports/gold2.png",
        name = "Gold 2",
        tooltip = "Teleport to the northeast Gold biome",
        lmb_fn = function()
            local dest = {}
            local x, y = EntityGetTransform(player)
            local pw = GetParallelWorldPosition(x, y)
            --EntitySetTransform(player, 6241 + pw * 35840, 15130)
        end,
        rmb_fn = function() end,
    },
    {
        icon = "mods/Copis_Cheats/files/ui_gfx/teleports/temple1.png",
        name = "Holy Mountain 1",
        tooltip = "Teleport to the holy mountain",
        lmb_fn = function()
            local x, y = EntityGetTransform(player)
            local w, h = BiomeMapGetSize()
            local pw_offset = GetParallelWorldPosition(x, y) * (512 * w)
            local dest = {
                x=190,
                y=1500
            }
            dest.x = dest.x + pw_offset
            EntitySetTransform(player, dest.x, dest.y)
        end,
        rmb_fn = function() end,
    },
    {
        icon = "mods/Copis_Cheats/files/ui_gfx/teleports/temple2.png",
        name = "Holy Mountain 1",
        tooltip = "Teleport to the holy mountain",
        lmb_fn = function()
            local x, y = EntityGetTransform(player)
            local w, h = BiomeMapGetSize()
            local pw_offset = GetParallelWorldPosition(x, y) * (512 * w)
            local dest = {
                x=190,
                y=1500
            }
            dest.x = dest.x + pw_offset
            EntitySetTransform(player, dest.x, dest.y)
        end,
        rmb_fn = function() end,
    },
    {
        icon = "mods/Copis_Cheats/files/ui_gfx/teleports/temple3.png",
        name = "Holy Mountain 1",
        tooltip = "Teleport to the holy mountain",
        lmb_fn = function()
            local x, y = EntityGetTransform(player)
            local w, h = BiomeMapGetSize()
            local pw_offset = GetParallelWorldPosition(x, y) * (512 * w)
            local dest = {
                x=190,
                y=1500
            }
            dest.x = dest.x + pw_offset
            EntitySetTransform(player, dest.x, dest.y)
        end,
        rmb_fn = function() end,
    },
    {
        icon = "mods/Copis_Cheats/files/ui_gfx/teleports/temple3.png",
        name = "Holy Mountain 1",
        tooltip = "Teleport to the holy mountain",
        lmb_fn = function()
            local x, y = EntityGetTransform(player)
            local w, h = BiomeMapGetSize()
            local pw_offset = GetParallelWorldPosition(x, y) * (512 * w)
            local dest = {
                x=190,
                y=1500
            }
            dest.x = dest.x + pw_offset
            EntitySetTransform(player, dest.x, dest.y)
        end,
        rmb_fn = function() end,
    },
    {
        icon = "mods/Copis_Cheats/files/ui_gfx/teleports/temple4.png",
        name = "Holy Mountain 1",
        tooltip = "Teleport to the holy mountain",
        lmb_fn = function()
            local x, y = EntityGetTransform(player)
            local w, h = BiomeMapGetSize()
            local pw_offset = GetParallelWorldPosition(x, y) * (512 * w)
            local dest = {
                x=190,
                y=1500
            }
            dest.x = dest.x + pw_offset
            EntitySetTransform(player, dest.x, dest.y)
        end,
        rmb_fn = function() end,
    },
    {
        icon = "mods/Copis_Cheats/files/ui_gfx/teleports/temple5.png",
        name = "Holy Mountain 1",
        tooltip = "Teleport to the holy mountain",
        lmb_fn = function()
            local x, y = EntityGetTransform(player)
            local w, h = BiomeMapGetSize()
            local pw_offset = GetParallelWorldPosition(x, y) * (512 * w)
            local dest = {
                x=190,
                y=1500
            }
            dest.x = dest.x + pw_offset
            EntitySetTransform(player, dest.x, dest.y)
        end,
        rmb_fn = function() end,
    },
    {
        icon = "mods/Copis_Cheats/files/ui_gfx/teleports/temple6.png",
        name = "Holy Mountain 1",
        tooltip = "Teleport to the holy mountain",
        lmb_fn = function()
            local x, y = EntityGetTransform(player)
            local w, h = BiomeMapGetSize()
            local pw_offset = GetParallelWorldPosition(x, y) * (512 * w)
            local dest = {
                x=190,
                y=1500
            }
            dest.x = dest.x + pw_offset
            EntitySetTransform(player, dest.x, dest.y)
        end,
        rmb_fn = function() end,
    },
    {
        icon = "mods/Copis_Cheats/files/ui_gfx/teleports/temple7.png",
        name = "Holy Mountain 1",
        tooltip = "Teleport to the holy mountain",
        lmb_fn = function()
            local x, y = EntityGetTransform(player)
            local w, h = BiomeMapGetSize()
            local pw_offset = GetParallelWorldPosition(x, y) * (512 * w)
            local dest = {
                x=190,
                y=1500
            }
            dest.x = dest.x + pw_offset
            EntitySetTransform(player, dest.x, dest.y)
        end,
        rmb_fn = function() end,
    },
}