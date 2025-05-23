shader_type spatial;
uniform sampler2D globe_text;
uniform float thickness = 0.0;
uniform float add = 0.0001;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec3 colour = texture(globe_text,UV).rgb;

	vec3 up = texture(globe_text,vec2(UV.x,UV.y+add)).rgb;
	vec3 left = texture(globe_text,vec2(UV.x-add,UV.y)).rgb;
	vec3 right = texture(globe_text,vec2(UV.x+add,UV.y)).rgb;
	vec3 down = texture(globe_text,vec2(UV.x,UV.y-add)).rgb;

	if(abs(colour.r - up.r) > thickness || abs(colour.r - down.r) > thickness || abs(colour.r - left.r) > thickness || abs(colour.r - right.r) > thickness){
		ALBEDO = vec3(32.0,6.6,0.9);
	}
	else{
		ALBEDO = vec3(0.0,0.0,0.0);
	}
	 //Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
