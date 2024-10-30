// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Custom/Specular"
{
    Properties
    {
        _MainTex("Base Texture", 2D) = "white" {}
        _Color("Color Tint", Color) = (1, 1, 1, 1)
        _Shininess("Shininess", Range(1, 100)) = 30  // Controls the sharpness of the specular highlight
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            struct appdata
            {
                float4 vertex : POSITION;    // Object space vertex position
                float3 normal : NORMAL;      // Object space normal
                float2 uv : TEXCOORD0;       // Texture UV coordinates
            };

            struct v2f
            {
                float4 pos : SV_POSITION;    // Clip-space position
                float2 uv : TEXCOORD0;       // UV coordinates for texturing
                float3 worldNormal : TEXCOORD1;  // World-space normal for lighting
                float3 worldPos : TEXCOORD2;     // World-space position for specular calculations
            };

            sampler2D _MainTex;
            float4 _Color;
            float _Shininess;

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);                     // Convert to clip space
                o.worldNormal = normalize(mul(v.normal, (float3x3)unity_WorldToObject)); // Transform normal to world space
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;              // Transform to world space position
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // Sample the base texture and apply the color tint
                fixed4 texColor = tex2D(_MainTex, i.uv) * _Color;

                // Define light direction and color
                float3 lightDir = normalize(float3(0.5, 1, 0.5));  // Example light direction
                fixed3 lightColor = fixed3(1, 1, 1);               // White light for simplicity

                // Lambertian diffuse lighting calculation
                float NdotL = saturate(dot(i.worldNormal, lightDir));
                fixed3 diffuse = texColor.rgb * NdotL * lightColor;

                // Blinn-Phong specular calculation
                float3 viewDir = normalize(_WorldSpaceCameraPos - i.worldPos);
                float3 halfDir = normalize(lightDir + viewDir);
                float NdotH = max(dot(i.worldNormal, halfDir), 0.0);
                fixed3 specular = lightColor * pow(NdotH, _Shininess);

                // Combine diffuse and specular components
                fixed3 finalColor = diffuse + specular;
                return fixed4(finalColor, texColor.a);
            }
            ENDCG
        }
    }
}
