// ---- Created with 3Dmigoto TEXCOORD2.3.16 on Thu Jul 22 13:12:13 2021
// Pixel Shader
// Manually commented by notyoshi

//textures
Texture2D<float4> RT : register(t5); // RT
Texture2D<float4> RM : register(t4); // RM
Texture2D<float4> RD : register(t3); // RD
Texture2D<float4> TN : register(t2); // TN
Texture2D<float4> MT : register(t1); // MT
Texture2D<float4> DI : register(t0); // DI
//samplers
SamplerState s5_s : register(s5);
SamplerState s4_s : register(s4);
SamplerState s3_s : register(s3);
SamplerState s2_s : register(s2);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
//const buffers
cbuffer cb1 : register(b1)
{
  float4 cb1[22];
}
cbuffer cb6 : register(b6)
{
  float4 cb6[2];
}
cbuffer cb7 : register(b7)
{
  float4 cb7[9];
}
cbuffer cb13 : register(b13)
{
  float4 cb13[1];
}
cbuffer cb12 : register(b12)
{
  float4 cb12[7];
}

// 3Dmigoto declarations
#define cmp -
Texture1D<float4> IniParams : register(t120);
Texture2D<float4> StereoParams : register(t125);

void main(
  float4 TEXCOORD0 : TEXCOORD0,
  float4 TEXCOORD2 : TEXCOORD2,
  float4 TEXCOORD3 : TEXCOORD3,
  float4 TEXCOORD4 : TEXCOORD4,
  float4 SV_POSITION0 : SV_POSITION0,
  out float4 DiffuseMap : SV_Target0, 
  out float4 NormalMap : SV_Target1, 
  out float4 LightingMap : SV_Target2)
{
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;
  
  DiffuseMap.w = 0; //unused
  
  //diffuse
  r0.xyz = DI.Sample(s0_s, TEXCOORD0.xy).xyz; // load DI 
  r0.xyz = r0.xyz * r0.xyz; 
  r1.xyz = RD.Sample(s3_s, TEXCOORD0.zw).xyz; // load RD
  r1.xyz = -r1.xyz * r1.xyz + float3(1,1,1); 
  r2.xyzw = MT.Sample(s1_s, TEXCOORD0.xy).xyzw; // load MT
  r1.xyz = -r1.xyz * r2.www + float3(1,1,1); // apply mask
  r0.xyz = r1.xyz * r0.xyz; 
  r0.xyz = cb6[1].www * r0.xyz; // brightens diffuse color by a certain amount
  DiffuseMap.xyz = max(float3(0.00392156886,0.00392156886,0.00392156886), r0.xyz);
  
  // normal map
  
  //----some shit happens here lol
  r0.x = dot(TEXCOORD3.xyz, TEXCOORD3.xyz); 
  r0.x = rsqrt(r0.x); 
  r0.xyz = TEXCOORD3.xyz * r0.xxx;
  r0.w = dot(TEXCOORD4.xyz, TEXCOORD4.xyz);
  r0.w = rsqrt(r0.w); 
  r1.xyz = TEXCOORD4.xyz * r0.www;  
  r3.xyz = r1.yzx * r0.zxy;
  r3.xyz = r0.yzx * r1.zxy + -r3.xyz; 
  r3.xyz = TEXCOORD4.www * r3.xyz;
  //------------------------------
  r4.xy = TN.Sample(s2_s, TEXCOORD0.xy).xy; //load TN
  r4.zw = float2(1,1) + -r4.xy; // reverse TN coordinates, and store them in Z and W
  r4.zw = r4.zw + r4.zw; //unneeded when recreating in blender
  r5.xyzw = cb7[5].xyzw * TEXCOORD0.zwzw; 
  r5.zw = RT.Sample(s5_s, r5.zw).xy; // load RT
  r6.xyz = RM.Sample(s4_s, r5.xy).xyz; // load RM
  r5.xy = float2(-0.5,-0.5) + r5.zw; 
  r5.xy = r2.ww * r5.xy + float2(0.5,0.5); // apply mask to RT
  r5.zw = float2(1,1) + -r5.xy;	
  r5.xy = r5.xy * r4.xy; // multiply by TN red and green channels
  r4.xy = cmp(r4.xy < float2(0.5,0.5)); //return 1 if TN red or green channel is less than 0.5, else 0
  r5.xy = r5.xy + r5.xy; 
  r4.zw = -r4.zw * r5.zw + float2(1,1); 	
  r4.xy = r4.xy ? r5.xy : r4.zw; // store r5.xy if the result from r4.xy is 0, else store r4.zw
  r4.xy = r4.xy * float2(2,2) + float2(-1,-1);
  r1.xyz = r4.xxx * r1.xyz;
  r1.xyz = r4.yyy * r3.xyz + r1.xyz;
  r0.w = dot(r4.xy, r4.xy);
  r0.w = 1 + -r0.w;
  r0.w = max(0, r0.w);
  r0.w = sqrt(r0.w);
  r0.xyz = r0.www * r0.xyz + r1.xyz;
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r0.w = dot(cb12[6].xyz, r0.xyz);
  r0.w = r0.w * 8 + 8;
  r0.w = sqrt(r0.w);
  r1.x = dot(cb12[4].xyz, r0.xyz);
  r1.y = dot(cb12[5].xyz, r0.xyz);
  NormalMap.xy = r1.xy / r0.ww;
  NormalMap.w = 0;
  // AO 
  r0.x = 1 + -r6.y; // RM green channel multiplied by -1, then add 1
  r0.yz = float2(-0.5,-0.5) + r6.zx; // add -0.5 and -0.5 to RM glossiness and metallic maps 
  r0.yz = r2.ww * r0.yz + float2(0.5,0.5); // apply MT mask to red and blue channels of RM
  r0.x = -r0.x * r2.w + 1; // apply MT mask to RM AO
  NormalMap.z = r0.x * r2.y; // multiply RM green channel by MT green channel
  
  // lighting
  r0.xw = float2(1,1) + -r2.zx; // multiply MT glossiness and metallic maps by -1 and add 1
  r1.xy = float2(1,1) + -r0.yz; // same as above, but for RM
  r0.yz = r2.zx * r0.yz;
  r1.zw = cmp(r2.zx < float2(0.5,0.5)); // result is 1 if MT glossiness or metallic if one of the maps is less than 0.5, else 0 - channels are compared individually
  r0.xyzw = r0.xyzw + r0.xyzw; 
  r0.xw = -r0.xw * r1.xy + float2(1,1); 
  r0.xy = r1.zw ? r0.yz : r0.xw; 
  r0.zw = cmp(float2(0,0) != cb1[21].xy); 
  r0.xy = r0.zw ? cb1[21].xy : r0.xy; 
  LightingMap.x = min(0.996078432, r0.x); // metallic final result
  LightingMap.y = r0.y; // glossiness final result
  //----some shit happens here lol
  r0.x = 0x00400000 & asint(cb13[0].x);
  r0.y = 4 & asint(cb7[8].w);
  r0.yz = (int2)r0.yy + int2(2,18);
  r0.w = (int)r0.y & 4;
  r0.xw = cmp((int2)r0.xw != int2(0,0));
  r0.x = r0.x ? r0.w : 0;
  r0.x = r0.x ? r0.z : r0.y;
  r0.x = (uint)r0.x << 8;
  r0.x = (int)r0.x ^ 0x0000bfff;
  LightingMap.z = f16tof32(r0.x);
  //-------------------------------
  LightingMap.w = 0; // unused
  return;
}

