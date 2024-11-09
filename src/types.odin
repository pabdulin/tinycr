package tinycr

color4ub :: [4]u8
vector4f :: [4]f32
vector3f :: [3]f32

to_color4ub :: proc(color: vector4f) -> color4ub {
	result: color4ub

	result.r = u8(color.r * 255)
	result.g = u8(color.g * 255)
	result.b = u8(color.b * 255)
	result.a = u8(color.a * 255)

	return result
}
