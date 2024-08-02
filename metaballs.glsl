@vs vs
in vec3 position;

out vec4 pos;


void main() {
    	gl_Position = vec4(position.x/1.0, position.y/1.0, position.z, 1.0);
	pos.x = position.x*16;
	pos.y = position.y*9;
}
@end

@fs fs

uniform fs_params {
	vec4 ci[5];
};

in vec4 pos;

out vec4 frag_color;

void main() {
	float color = 0;
	for (int i = 0; i < ci.length(); i++) {
		float dist_x = pos.x - ci[i].x*16;
		float dist_y = pos.y - ci[i].y*9;
		color += 1 / ((dist_x*dist_x) + (dist_y*dist_y));
	}
	
	if (color > 0.9) {
		color = (color-0.9)*2;
		if (color > 1) {
			color = 1;
		}
	} else {
		color = 0;
	}
	
	float sine = sin(pos.x*2) + sin(pos.y*2) + 0.4;
	vec4 shade = vec4(sine*0.22, sine*0.66, sine, 1.0);
	frag_color = shade*color;
}
@end

@program metaballs vs fs
