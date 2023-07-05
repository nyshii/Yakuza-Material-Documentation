# _MT (Multi textures)
These textures control the shading of materials, such as specular, ambient occlusion, etc. Each map is stored in the different color channels (which can be viewed in GIMP or Photoshop).

For assets, they are labeled as "_m" and have a different format.

Hair materials have their own format.
### Specular (Old Engine)
Stored in the <font color="red">red</font> channel. It controls the specular reflectivity of a material. 
### Ambient Occlusion
Stored in the <font color="green">green</font> channel. 
Not present in asset shaders.

It occludes light in parts of a mesh.
### Specular Power multiplier (Old Engine)
Stored in the <font color="blue">blue</font> channel. It multiplies the specular power in parts of a mesh. 
For assets, stored in the <font color="green">green</font> channel.

Specular power will be covered more in the Pre-Dragon Engine section.
### Glossiness (Dragon Engine)
Stored in the <font color="blue">blue</font> channel.
For assets, stored in the <font color="green">green</font> channel.

It controls how shiny a material is. (1 makes it shiny, and 0 makes it rough.)

There are a few shaders with the [rough] tag, which indicate that it uses roughness (0 makes it shiny).
### *dedit* Mask
For assets only.
Stored in the <font color="blue">blue</font> channel.

*dedit* changes the color of the material. What spots of the texture should be colored or not is controlled here.
### Pattern texture mask
For characters only.
Stored in the *alpha* channel in Dragon Engine.
Stored in the <font color="blue">blue</font> in Old Engine. (Only if the shader has a pattern texture tag, i.e. ``s_o1dzt[rd][rs][rt]``


Masks pattern textures (_rd, _rm, _rs, _rt).
## Hair materials
For shaders with the [hair] tag.
 Only for Old Engine (not Old Old Engine) and Dragon Engine.
 
  ### Anisotropy offset
   Stored in the <font color="red">red</font> channel.
Offsets where the anisotropic specular highlight is vertically. 0 offsets it up, 0.5 has no offset, 1 offsets it down.
 ### Specular (Old Engine)
 Stored in the <font color="green">green</font> channel.


### Glossiness/Specular Power multiplier
 Stored in the <font color="blue">blue</font> channel.
 ### Ambient Occlusion (Dragon Engine)
 Stored in the <font color="green">green</font> channel.
