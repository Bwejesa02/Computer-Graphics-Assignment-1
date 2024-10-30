// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Custom/RimLighting"
{
    Properties
    {
        _MainTex("Base Texture", 2D) = "white" {}
        _Color("Color Tint", Color) = (1, 1, 1, 1)
        _RimColor("Rim Color", Color) = (1, 1, 1, 1) // Color of the rim effect
        _RimPower("Rim Power", Range(0.1, 8.0)) = 3.0 // Controls sharpness of the rim
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
                float3 viewDir : TEXCOORD2;      // View direction for rim effect
            };

            sampler2D _MainTex;
            float4 _Color;
            float4 _RimColor;
            float _RimPower;

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);                     // Convert to clip space
                o.worldNormal = normalize(mul(v.normal, (float3x3)unity_WorldToObject)); // Transform normal to world space
                o.viewDir = normalize(_WorldSpaceCameraPos - mul(unity_ObjectToWorld, v.vertex).xyz); // View direction
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // Sample the base texture and apply the color tint
                fixed4 texColor = tex2D(_MainTex, i.uv) * _Color;

                // Calculate rim effect based on view direction and surface normal
                float rimFactor = 1.0 - saturate(dot(i.worldNormal, i.viewDir));
                rimFactor = pow(rimFactor, _RimPower); // Control sharpness

                // Combine base color with rim effect
                fixed4 rimColor = _RimColor * rimFactor;
                return texColor + rimColor; // Add rim color to the base color
            }
            ENDCG
        }
    }
}
