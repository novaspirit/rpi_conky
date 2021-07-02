require 'cairo'

normal="0xff0000"
warn="0xff7200"
crit="0xFF4A5C"

settings_table = {
    {
        name='acpitemp',
        arg='',
        max=80,
        bg_colour=0x001A00,
        bg_alpha=1,
        fg_colour=0xffffff,
        fg_alpha=0,
        x=360, y=120,
        radius=97,
        thickness=6,
        start_angle=0,
        end_angle=240
    },
    {
        name='acpitemp',
        arg='',
        max=80,
        bg_colour=0x001A00,
        bg_alpha=1,
        fg_colour=0xffffff,
        fg_alpha=0.4,
        x=360, y=120,
        radius=97,
        thickness=4,
        start_angle=0,
        end_angle=240
    },
    {
        name='cpu',
        arg='cpu0',
        max=100,
        bg_colour=0x003000,
        bg_alpha=1,
        fg_colour=0xffffff,
        fg_alpha=0,
        x=360, y=120,
        radius=86,
        thickness=16,
        start_angle=0,
        end_angle=240
    },
    {
        name='cpu',
        arg='cpu0',
        max=100,
        bg_colour=0x003000,
        bg_alpha=0,
        fg_colour=0xffffff,
        fg_alpha=0.4,
        x=360, y=120,
        radius=86,
        thickness=13,
        start_angle=0,
        end_angle=240
    },
    {
        name='cpu',
        arg='cpu1',
        max=100,
        bg_colour=0x005900,
        bg_alpha=1,
        fg_colour=0xffffff,
        fg_alpha=0,
        x=360, y=120,
        radius=71,
        thickness=15,
        start_angle=0,
        end_angle=240
    },
    {
        name='cpu',
        arg='cpu1',
        max=100,
        bg_colour=0x005900,
        bg_alpha=0,
        fg_colour=0xffffff,
        fg_alpha=0.4,
        x=360, y=120,
        radius=71,
        thickness=12,
        start_angle=0,
        end_angle=240
    },
    {
        name='cpu',
        arg='cpu2',
        max=100,
        bg_colour=0x008000,
        bg_alpha=1,
        fg_colour=0xffffff,
        fg_alpha=0,
        x=360, y=120,
        radius=57,
        thickness=14,
        start_angle=0,
        end_angle=240
    },
    {
        name='cpu',
        arg='cpu2',
        max=100,
        bg_colour=0x008000,
        bg_alpha=0,
        fg_colour=0xffffff,
        fg_alpha=0.4,
        x=360, y=120,
        radius=57,
        thickness=11,
        start_angle=0,
        end_angle=240
    },
    {
        name='cpu',
        arg='cpu3',
        max=100,
        bg_colour=0x01B300,
        bg_alpha=1,
        fg_colour=0xffffff,
        fg_alpha=0,
        x=360, y=120,
        radius=44,
        thickness=13,
        start_angle=0,
        end_angle=240
    },
    {
        name='cpu',
        arg='cpu3',
        max=100,
        bg_colour=0x01B300,
        bg_alpha=0,
        fg_colour=0xffffff,
        fg_alpha=0.4,
        x=360, y=120,
        radius=44,
        thickness=10,
        start_angle=0,
        end_angle=240
    },
    {
        name='fs_used_perc',
        arg='/home',
        max=100,
        bg_colour=0x660000,
        bg_alpha=1,
        fg_colour=0xffffff,
        fg_alpha=0,
        x=250, y=225,
        radius=34,
        thickness=14,
        start_angle=0,
        end_angle=240
    },
    {
        name='fs_used_perc',
        arg='/home',
        max=100,
        bg_colour=0x660000,
        bg_alpha=0,
        fg_colour=0xffffff,
        fg_alpha=0.4,
        x=250, y=225,
        radius=34,
        thickness=10,
        start_angle=0,
        end_angle=240
    },
    {
        name='fs_used_perc',
        arg='/boot/',
        max=100,
        bg_colour=0xb30000,
        bg_alpha=1,
        fg_colour=0xffffff,
        fg_alpha=0,
        x=250, y=225,
        radius=21,
        thickness=12,
        start_angle=0,
        end_angle=240
    },
    {
        name='fs_used_perc',
        arg='/boot/',
        max=100,
        bg_colour=0xb30000,
        bg_alpha=0,
        fg_colour=0xffffff,
        fg_alpha=0.4,
        x=250, y=225,
        radius=21,
        thickness=10,
        start_angle=0,
        end_angle=240
    },
    {
        name='memperc',
        arg='',
        max=100,
        bg_colour=0x000199,
        bg_alpha=1,
        fg_colour=0xffffff,
        fg_alpha=0,
        x=340, y=300,
        radius=60,
        thickness=19,
        start_angle=180,
        end_angle=420
    },
    {
        name='memperc',
        arg='',
        max=100,
        bg_colour=0x0000ff,
        bg_alpha=0,
        fg_colour=0xffffff,
        fg_alpha=0.4,
        x=340, y=300,
        radius=60,
        thickness=14,
        start_angle=180,
        end_angle=420
    },
    {
        name='swapperc',
        arg='',
        max=100,
        bg_colour=0x1030ff,
        bg_alpha=1,
        fg_colour=0xffffff,
        fg_alpha=0,
        x=340, y=300,
        radius=45,
        thickness=12,
        start_angle=180,
        end_angle=420
    },
    {
        name='swapperc',
        arg='',
        max=100,
        bg_colour=0x1030ff,
        bg_alpha=1,
        fg_colour=0xffffff,
        fg_alpha=0.4,
        x=340, y=300,
        radius=45,
        thickness=10,
        start_angle=180,
        end_angle=420
    }
}

function rgb_to_r_g_b(colour, alpha)
	return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_ring(display, t, pt)
	local w,h=conky_window.width,conky_window.height
	
	local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
	local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

	local angle_0=sa*(2*math.pi/360)-math.pi/2
	local angle_f=ea*(2*math.pi/360)-math.pi/2
	local t_arc=t*(angle_f-angle_0)

	-- Draw background ring

	cairo_arc(display,xc,yc,ring_r,angle_0,angle_f)
	cairo_set_source_rgba(display,rgb_to_r_g_b(bgc,bga))
	cairo_set_line_width(display,ring_w)
	cairo_stroke(display)
	
	-- Draw indicator ring

	cairo_arc(display,xc,yc,ring_r,angle_0,angle_0+t_arc)
	cairo_set_source_rgba(display,rgb_to_r_g_b(fgc,fga))
	cairo_stroke(display)		
end

function conky_ring_stats(display)
	local function setup_rings(display,pt)
		local str=''
		local value=0
		
		str=string.format('${%s %s}',pt['name'],pt['arg'])
		str=conky_parse(str)
		
		value=tonumber(str)
		if value == nil then value = 0 end
		pct=value/pt['max']
		
		draw_ring(display, pct, pt)
	end

    for i in pairs(settings_table) do
    	setup_rings(display, settings_table[i])
    end
end

function temp_watch()
    warn_value=55
    crit_value=65

    temperature=tonumber(conky_parse("${acpitemp}"))
end

function disk_watch()
    warn_disk=93
    crit_disk=98

    disk=tonumber(conky_parse("${fs_used_perc /home}"))

    disk=tonumber(conky_parse("${fs_used_perc /boot/}"))

end

function conky_main()
    if conky_window == nil then 
        return
    end

    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    local display = cairo_create(cs)
    
    local updates = conky_parse('${updates}')
    update_num = tonumber(updates)

    temp_watch()
    disk_watch()
    
    if update_num > 5 then
    	conky_ring_stats(display)
    end
    
    cairo_surface_destroy(cs)
    cairo_destroy(display)
end
