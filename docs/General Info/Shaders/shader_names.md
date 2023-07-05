# Shader Names
You may have noticed that shaders have funky names. Thanks to a presentation done by RGG Studio we can decipher some of them.

Let us take this shader name for example: ``s_o1dztt_m2dzt_h2dz[skin]`` (Note: this is not a real shader in any game)

Here is a breakdown of the name:

 - s_
	 - Indicates that it is a skinned shader (used for characters)
- o
	- Opaque shader.
- 1
	- Texture coordinate 1 (The default UV map)
	- d
		- Uses a diffuse texture.
	- z
		- Uses a multi texture.
    - tt
	    - Uses two normal maps. The other is typically used for _ts (wrinkle) textures.
- _m
	- Mix (with the pattern texture mask channel of the _mt)
- 2
	- Texture coordinate 2 (UV1)
		- d
			- Uses a _rd texture.
		- z
			- Uses a _rm texture.
	    - t
		    - Uses a _rt texture.
- _h2dz
	- Unsure what the h means, but if you see this on a shader, it means it uses an imperfection texture. (Makes sense, since imperfection changes the diffuse and glossiness)
- [skin]
	- Indicates it is a skin shader (has a _tr texture if it's DE, uses subsurface.dds if it's OE)

# Shader letter/tag meanings
Not every single one is documented here since some have unknown purposes. Obvious ones are undocumented unless there is something interesting about them.

|Letter|Definition  |
|--|--|
||**Type of shader**
|s_|Skinned materials (characters)|
|r_/rs_|Rigid materials (assets)|
|sd_|Dragon Engine shaders|
|ss_|Asset shaders?|
||**Related to transparency**
|o|Opaque|
|a|Unknown, but has transparency|
|b|Alpha blend|
|c|Alpha sample to coverage (dithered alpha)|
|d|Unknown, but has transparency|
|p|Unknown, but has transparency|
||**Related to textures**	
|d|Diffuse texture|
|m|Multi texture|
|u|Multi texture (assets)|
|s|Specular texture (OE)|
|t|Normal map|
||**Tags**|
|(vr)|Vertex color, red channel.|	
|[vcol]|Uses vertex colors for various purposes.|	
|[sss]|Uses subsurface scattering.|
|[dedit]|Uses *dedit*.|
|[mouth]|Mouth shader. In DE, it uses subsurface scattering (the _tr is set by the shader to about .45)|
|[rough]|Invert glossiness.|
|[ref]|Reflection shader. Discards _di in Old Engine. Cubemap is added to diffuse texture in DE.|
|[aref]|Reflection shader. Cubemap is added to diffuse texture.|
|[gem]|Reflection shader. Cubemap is multiplied to diffuse texture.|

