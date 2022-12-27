function GuiConfigForNextWidget( gui, options, colors, z_index )
    if options ~= nil then
        for _, option in ipairs( options ) do
            GuiOptionsAddForNextWidget( Gui, option )
        end
    end
    if colors ~= nil then
        GuiColorSetForNextWidget( gui, colors[1], colors[2], colors[3], colors[4])
    end
    if z_index ~= nil then
        GuiZSetForNextWidget( gui, z_index )
    end
end