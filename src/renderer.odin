package tinycr

clear :: proc(color_buffer: image_view, color: vector4f) {
	pixels_n := color_buffer.width * color_buffer.height
	for i: u32 = 0; i < pixels_n; i += 1 {
        color_buffer.pixels[i] = to_color4ub(color);
	}
}
