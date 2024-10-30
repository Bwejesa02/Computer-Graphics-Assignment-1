Shader "Custom/ColorGrading"
{
    Properties
    {
        _MainTex("Base Texture", 2D) = "white" {}
        _LUT("Lookup Table", 2D) = "white" {} // LUT for color grading
        _LUTIntensity("LUT Intensity", Range(0, 1)) = 1.0 // Controls the strength of the LUT effect
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            sampler2D _MainTex;
            sampler2D _LUT;
            float _LUTIntensity;

            struct appdata
            {
                float4 vertex : POSITION;    // Object space vertex position
                float2 uv : TEXCOORD0;       // Texture UV coordinates
            };

            struct v2f
            {
                float4 pos : SV_POSITION;    // Clip-space position
                float2 uv : TEXCOORD0;       // UV coordinates for texturing
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex); // Convert to clip space
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // Sample the base texture
                fixed4 color = tex2D(_MainTex, i.uv);

                // Apply LUT for color grading
                float2 lutUV = float2(color.r, 0.5); // Use the red channel for LUT lookup
                fixed4 lutColor = tex2D(_LUT, lutUV);

                // Interpolate between original and LUT color based on intensity
                color.rgb = lerp(color.rgb, lutColor.rgb, _LUTIntensity);
                return color;
            }
            ENDCG
        }
    }
}
