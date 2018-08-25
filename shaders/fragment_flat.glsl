
out vec4 outputColor;

uniform vec3 input_color;

flat in vec3 intensity;

void main()
{
    outputColor = vec4(intensity*input_color, 0);
}
