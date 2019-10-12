// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "EdgeDetectionImageEffectShader"
{
	Properties
	{
	   _MainTex("Source", 2D) = "white" {}
	   _Color("Tint", Color) = (1,1,1,1)
	}
		SubShader
	   {
		  Cull Off
		  ZWrite Off
		  ZTest Always

		  Pass
		  {
			 CGPROGRAM
			 #pragma vertex vertexShader
			 #pragma fragment fragmentShader

			 #include "UnityCG.cginc"

			 struct vertexInput
			 {
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
			 };

			 struct vertexOutput
			 {
				float2 texcoord : TEXCOORD0;
				float4 position : SV_POSITION;
			 };

			 vertexOutput vertexShader(vertexInput i)
			 {
				vertexOutput o;
				o.position = UnityObjectToClipPos(i.vertex);
				o.texcoord = i.texcoord;
				return o;
			 }

			 sampler2D _MainTex;
			 float4 _MainTex_ST;
			 float4 _Color;

			 float4 fragmentShader(vertexOutput i) : SV_TARGET
			 {
				float4 color = tex2D(_MainTex, i.texcoord);
				float4 offsetColor = tex2D(_MainTex, i.texcoord - 0.002);
				if (length(color - offsetColor) > 0.1)
				{
					color = 0;
				}
				return color;
			 }
			 ENDCG
		  }
	   }
		   Fallback Off
}