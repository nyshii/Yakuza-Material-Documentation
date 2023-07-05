# _TN (Normal map textures)
Normal maps contain height information that change the normals of a mesh. In other words, they fake details on meshes so that your poor computer doesn't have to render every single one of Kiryu's skinpores for example.

Yellow normal maps are common in Dragon Engine games, and green normal maps are common in Old Engine. 

For assets, they usually end with the prefix "_n".

## Technical Info
Green normal maps store the X+ axis in the alpha channel, and store the Y+ axis in the green channel. Yellow normal maps store the X+ axis in the red channel, and store the Y+ axis in the green channel. Ishin Kiwami's green channel is in the Y- axis. The Z+ axis (blue channel of a typical normal map) is calculated in the shader with this shader code:

    //Remap normal map to -1 to 1
    
    normalMap.x = 1 - (2 * tn.x);
    
    normalMap.y = 1 - (2 * tn.y);
    
    // Dot product of the vector (normalMap.x,normalMap.y) and itself, multiplied by -1 and then added by 1. Then, pick the largest number between the result of that and 0 (so that the result never becomes a negative number), and square root it.
    
    tmp.z = 1 + -(dot(normalMap.xy, normalMap.xy));
    
    normalMap.z = sqrt(max(0, tmp.z));
    
The engine can differentiate between green and yellow normal maps by reading the header of the .DDS file. If the .DDS file's header is "DxT5xGxR", it reads it as a green normal map.
