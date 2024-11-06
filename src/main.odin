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

	for running {
		event: sdl2.Event
		for sdl2.PollEvent(&event) {
			#partial switch (event.type) {
			case .WINDOWEVENT:
				#partial switch (event.window.event) {
				case .RESIZED:
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
	}
}
