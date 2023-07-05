# _DI (Diffuse/Albedo textures)
These textures color the mesh. 

In Pre-Dragon Engine games, they are *diffuse* textures, meaning light is baked into them - as opposed to Dragon Engine, whch use *albedo* textures that have no light baked into them.

Of course, some _DI textures have information stored in their alpha channel, which is used to dictate how transparent the mesh will be (if a shader is transparent).
