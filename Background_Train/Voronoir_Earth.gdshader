shader_type canvas_item;

varying float speed;
const vec3 darker = vec3(70,23,3) / 255.0;
const vec3 lighter = vec3(159,62,18) / 255.0;

vec2 random(vec2 uv) {
	return vec2(fract(sin(dot(uv.xy,
		vec2(12.9898,78.233))) * 43758.5453123));
}

float worley(vec2 uv, float columns, float rows) {

	vec2 index_uv = floor(vec2(uv.x * columns, uv.y * rows));
	vec2 fract_uv = fract(vec2(uv.x * columns, uv.y * rows));

	float minimum_dist = 1.0;

	for (int y= -1; y <= 1; y++) {
		for (int x= -1; x <= 1; x++) {
			vec2 neighbor = vec2(float(x),float(y));
			vec2 point = random(index_uv + neighbor);

			vec2 diff = neighbor + point - fract_uv;
			float dist = length(diff);
			minimum_dist = min(minimum_dist, dist);
		}
	}

	return minimum_dist;
}

void fragment() {
	speed = 1.0;
	float worley = worley(vec2(UV.x+TIME*speed,UV.y), 3.0, 5.0);
	if (worley < 0.01){
		COLOR = vec4(darker * worley,1.0);
	}
	else{
		COLOR = vec4(lighter * worley * 2.0, 1.0);
	}
}
