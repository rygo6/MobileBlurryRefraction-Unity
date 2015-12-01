Shader "Mobile/Blurry Refraction" 
{
	Properties 
	{
		_MainTex ("Base", 2D) = "white"
		_BlurTexture ("Base", 2D) = "white"
		_Size ("Size", Float) = 2	
		_Prism ("Prism", Float) = 2	
	}
	SubShader 
	{
		Tags { "RenderTyoe"="Opaque" }
		Pass 
		{
			GLSLPROGRAM
			varying mediump vec2 blurUVs[12];         
			varying mediump vec4 projUV;	
			varying mediump vec2 uv;

			#ifdef VERTEX   
			uniform mediump float _Size;
			uniform mediump float _Prism;  
			void main()
			{
				gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
				projUV = gl_ModelViewProjectionMatrix * gl_Vertex;
				uv = gl_MultiTexCoord0.xy;
				float size = _Size * projUV.z;
				vec2 normalOffset = vec2(gl_Normal.x * _Prism, gl_Normal.z * _Prism);
				blurUVs[0] = vec2(projUV) + vec2(-0.030 * size, -0.030 * size) + normalOffset;
				blurUVs[1] = vec2(projUV) + vec2(-0.025 * size, 0.025 * size) + normalOffset;
				blurUVs[2] = vec2(projUV) + vec2(-0.020 * size, -0.020 * size) + normalOffset;
				blurUVs[3] = vec2(projUV) + vec2(-0.015 * size, 0.015 * size) + normalOffset;
				blurUVs[4] = vec2(projUV) + vec2(-0.010 * size, -0.010 * size) + normalOffset;
				blurUVs[5] = vec2(projUV) + vec2(-0.005 * size, 0.005 * size) + normalOffset;
				blurUVs[6] = vec2(projUV) + vec2(0.005 * size, -0.005 * size) + normalOffset;
				blurUVs[7] = vec2(projUV) + vec2(0.010 * size, 0.010 * size) + normalOffset;
				blurUVs[8] = vec2(projUV) + vec2(0.015 * size, -0.015 * size) + normalOffset;
				blurUVs[9] = vec2(projUV) + vec2(0.020 * size, 0.020 * size) + normalOffset;
				blurUVs[10] = vec2(projUV) + vec2(0.025 * size, -0.025 * size) + normalOffset;
				blurUVs[11] = vec2(projUV) + vec2(0.030 * size, 0.030 * size) + normalOffset;
				projUV.x += normalOffset.x;
				projUV.y += normalOffset.y;
			}
			#endif

			#ifdef FRAGMENT
			uniform mediump sampler2D _MainTex;
			uniform mediump sampler2D _BlurTexture;   	  
			void main()
			{
				gl_FragColor = vec4(0.0);
				gl_FragColor += texture2D(_BlurTexture, (blurUVs[0] / projUV.w / 2.0) + 0.5) * 0.010;
				gl_FragColor += texture2D(_BlurTexture, (blurUVs[1] / projUV.w / 2.0) + 0.5) * 0.020;
				gl_FragColor += texture2D(_BlurTexture, (blurUVs[2] / projUV.w / 2.0) + 0.5) * 0.040;
				gl_FragColor += texture2D(_BlurTexture, (blurUVs[3] / projUV.w / 2.0) + 0.5) * 0.080;
				gl_FragColor += texture2D(_BlurTexture, (blurUVs[4] / projUV.w / 2.0) + 0.5) * 0.110;
				gl_FragColor += texture2D(_BlurTexture, (blurUVs[5] / projUV.w / 2.0) + 0.5) * 0.145;
				gl_FragColor += texture2D(_BlurTexture, (vec2(projUV) / projUV.w / 2.0) + 0.5) * 0.160;
				gl_FragColor += texture2D(_BlurTexture, (blurUVs[6] / projUV.w / 2.0) + 0.5) * 0.145;
				gl_FragColor += texture2D(_BlurTexture, (blurUVs[7] / projUV.w / 2.0) + 0.5) * 0.110;
				gl_FragColor += texture2D(_BlurTexture, (blurUVs[8] / projUV.w / 2.0) + 0.5) * 0.080;
				gl_FragColor += texture2D(_BlurTexture, (blurUVs[9] / projUV.w / 2.0) + 0.5) * 0.040;
				gl_FragColor += texture2D(_BlurTexture, (blurUVs[10] / projUV.w / 2.0) + 0.5) * 0.020;
				gl_FragColor += texture2D(_BlurTexture, (blurUVs[11] / projUV.w / 2.0) + 0.5) * 0.010;
				gl_FragColor.rgb *= texture2D(_MainTex, uv).rgb;     
			}
			#endif
			ENDGLSL
		}
	}
}