package tinycr

import sdl2 "vendor:sdl2"

main :: proc() {
	sdl2.Init(sdl2.INIT_VIDEO)

	width := i32(800)
	height := i32(600)

	window: ^sdl2.Window = sdl2.CreateWindow(
		"Tiny rasterizer",
		sdl2.WINDOWPOS_UNDEFINED,
		sdl2.WINDOWPOS_UNDEFINED,
		width,
		height,
		sdl2.WINDOW_RESIZABLE | sdl2.WINDOW_SHOWN,
	)

	mouse_x := i32(0)
	mouse_y := i32(0)

	running := true

	draw_surface: ^sdl2.Surface = nil

	for running {
		event: sdl2.Event
		for sdl2.PollEvent(&event) {
			#partial switch (event.type) {
			case .WINDOWEVENT:
				#partial switch (event.window.event) {
				case .RESIZED:
					if (draw_surface != nil) {
						sdl2.FreeSurface(draw_surface)
						draw_surface = nil
					}

					width = event.window.data1
					height = event.window.data2
				}
			case .QUIT:
				running = false
			case .MOUSEMOTION:
				mouse_x = event.motion.x
				mouse_y = event.motion.y
			}
		}
		
		if (draw_surface == nil) {
			draw_surface = sdl2.CreateRGBSurfaceWithFormat(
				0,
				width,
				height,
				32,
				sdl2.DEFINE_PIXELFORMAT(
					sdl2.PIXELTYPE_PACKED32,
					sdl2.PACKEDORDER_RGBA,
					sdl2.PACKEDLAYOUT_8888,
					32,
					4,
				),
			)
			sdl2.SetSurfaceBlendMode(draw_surface, sdl2.BlendMode.NONE)
		}

		p : [^]u32 = ([^]u32)(draw_surface.pixels)
		for i :i32= 0; i < width*height; i += 1 {
			p[i] = 0xdfdfffFF;
		}

		rect: sdl2.Rect = {x = 0, y = 0, w = width, h = height}
		sdl2.BlitSurface(draw_surface, &rect, sdl2.GetWindowSurface(window), &rect)
		sdl2.UpdateWindowSurface(window)
	}
}
