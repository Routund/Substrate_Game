shader_type canvas_item;
uniform float thickness = 0.0;
uniform float outline_thresh = 0.0001;
uniform vec3 exclusive_colour = vec3(1.0,0.5,1.0);
uniform float shading_thresh = 0.004;
uniform sampler2D globe_text;

float mag(vec3 vec){
	return sqrt(vec.x*vec.x + vec.y*vec.y+vec.z*vec.z);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 sample = texture(TEXTURE,UV);
	vec3 colour = sample.rgb;

	if (sample.a != 0.0 && colour != (vec3(1.0,1.0,1.0))){

	}
	else {
		sample = texture(globe_text,UV);
		colour = sample.rgb;
		COLOR = sample;
		float up = mag(colour- texture(globe_text,vec2(UV.x,UV.y+outline_thresh/10.0)).rgb);
		float left = mag(colour- texture(globe_text,vec2(UV.x-outline_thresh/10.0,UV.y)).rgb);
		float right = mag(colour - texture(globe_text,vec2(UV.x+outline_thresh/10.0,UV.y)).rgb);
		float down = mag(colour - texture(globe_text,vec2(UV.x,UV.y-outline_thresh/10.0)).rgb);

		if(up > thickness || down > thickness || left > thickness || right > thickness){
			COLOR = vec4(1.0,0.55,0.1,1.0);
		}
		else if(mag(colour - vec3(0.1333, 0.1333, 0.1333)) > 0.1 && sample.a > 0.0){
			if (mag(colour- texture(globe_text,vec2(UV.x,UV.y+outline_thresh/10.0*10.0)).rgb) > shading_thresh || mag(colour - texture(globe_text,vec2(UV.x,UV.y-outline_thresh/10.0*10.0)).rgb) > shading_thresh || mag(colour- texture(globe_text,vec2(UV.x-outline_thresh/10.0*10.0,UV.y)).rgb) > shading_thresh || mag(colour- texture(globe_text,vec2(UV.x+outline_thresh/10.0*10.0,UV.y)).rgb) > shading_thresh){
				COLOR = vec4(1.0,0.55,0.1,0.6);
			}
			else{
				COLOR = vec4(0);
			}
		}
		else{
			COLOR = vec4(0);
		}

		if (mag(colour-exclusive_colour) < 0.05){
			COLOR = vec4(1.0,0.75,0.5,1.0);
		}

	}
	 //Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}