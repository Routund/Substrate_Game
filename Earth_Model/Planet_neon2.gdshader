shader_type spatial;
uniform float thickness = 0.0;
uniform float outline_thresh = 0.0001;
uniform vec3 exclusive_colour = vec3(1.0,0.5,1.0);
uniform float shading_thresh = 0.004;
uniform sampler2D TEXTURE;

float mag(vec3 vec){
	return sqrt(vec.x*vec.x + vec.y*vec.y+vec.z*vec.z);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 sample = texture(TEXTURE,UV);
	vec3 colour = sample.rgb;
	if (mag(colour) < 0.5){
		float up = mag(colour- texture(TEXTURE,vec2(UV.x,UV.y+outline_thresh/10.0)).rgb);
		float left = mag(colour- texture(TEXTURE,vec2(UV.x-outline_thresh/10.0,UV.y)).rgb);
		float right = mag(colour - texture(TEXTURE,vec2(UV.x+outline_thresh/10.0,UV.y)).rgb);
		float down = mag(colour - texture(TEXTURE,vec2(UV.x,UV.y-outline_thresh/10.0)).rgb);

		if(up > thickness || down > thickness || left > thickness || right > thickness){
			ALBEDO = vec3(1.0,0.55,0.1);

		}
		else if(mag(colour - vec3(0.1333, 0.1333, 0.1333)) > 0.1 && sample.a > 0.0){
			if (mag(colour- texture(TEXTURE,vec2(UV.x,UV.y+outline_thresh/10.0*10.0)).rgb) > shading_thresh || mag(colour - texture(TEXTURE,vec2(UV.x,UV.y-outline_thresh/10.0*10.0)).rgb) > shading_thresh || mag(colour- texture(TEXTURE,vec2(UV.x-outline_thresh/10.0*10.0,UV.y)).rgb) > shading_thresh || mag(colour- texture(TEXTURE,vec2(UV.x+outline_thresh/10.0*10.0,UV.y)).rgb) > shading_thresh){
				ALBEDO = vec3(010,0.55,0.1);
				ALPHA = 0.6;
			}
			else{
				ALBEDO = vec3(0);
				ALPHA = 1.0;
			}
		}
		else{
			ALBEDO = vec3(0);
			ALPHA = 0.0;
		}

		if (mag(colour-exclusive_colour) < 0.05){
			ALBEDO = vec3(1.0,0.75,0.5);
		}
	}
	 //Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}