
out vec4 outputColor;

uniform vec3 input_color;

uniform mat4 view_matrix;

// Light properties
uniform vec3 lightPos;
uniform float lightIntensity;
uniform float ambientIntensity;

// Material properties
uniform float ambientCoeff;
uniform float diffuseCoeff;
uniform float specularCoeff;
uniform float phongExp;

in vec4 viewPosition;
in vec3 m;

void main()
{
    // Compute the s, v and r vectors
    vec3 s = normalize(view_matrix*vec4(lightPos,1) - viewPosition).xyz;
    vec3 v = normalize(-viewPosition.xyz);
    vec3 r = normalize(reflect(-s,m));

    float ambient = ambientIntensity*ambientCoeff;
    float diffuse = max(lightIntensity*diffuseCoeff*dot(m,s), 0.0);
    float specular;

    // Only show specular reflections for the front face
    if (dot(m,s) > 0)
        specular = max(lightIntensity*specularCoeff*pow(dot(r,v),phongExp), 0.0);
    else
        specular = 0;

    float intensity = ambient + diffuse + specular;

    outputColor = vec4(intensity*input_color, 0);
}