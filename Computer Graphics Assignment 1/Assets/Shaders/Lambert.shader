// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Custom/Lambert"
{
    Properties
    {
        _MainTex("Base Texture", 2D) = "white" {}
        _Color("Color Tint", Color) = (1, 1, 1, 1)
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
            };

            sampler2D _MainTex;
            float4 _Color;

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);                 // Convert to clip space
                o.worldNormal = normalize(mul(v.normal, (float3x3)unity_WorldToObject)); // Transform normal to world space
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // Sample the base texture and apply the color tint
                fixed4 texColor = tex2D(_MainTex, i.uv) * _Color;

                // Manually define a directional light color and direction
                float3 lightDir = normalize(float3(0.5, 1, 0.5));   // Example light direction
                fixed3 lightColor = fixed3(1, 1, 1);                // White light for simplicity

                // Calculate Lambertian diffuse lighting
                float NdotL = saturate(dot(i.worldNormal, lightDir));
                
                // Multiply texture color by diffuse factor and light color
                fixed3 finalColor = texColor.rgb * NdotL * lightColor;
                return fixed4(finalColor, texColor.a);
            }
            ENDCG
        }
    }
}
