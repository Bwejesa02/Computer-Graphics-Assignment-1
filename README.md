**AI usage exclusive to spelling correction and formatting**

The main objective was to create a scene that showcases different lighting and shading techniques, while also adding interactivity. 

Project Summary

The scene contains:

Player : The main character, controllable with WASD keys, that interacts with the scene by collecting items.
Collectibles (Spheres): Objects the player collects to achieve a win condition.
Boundaries: Walls around the play area to keep the player within bounds.
UI Text: A simple display showing the remaining collectibles, and a You Win! message when all are collected.


Here’s a breakdown of the main shaders I implemented.

Lambert (Diffuse) Shader

The Lambert shader provides basic diffuse lighting. This shader models light scattering evenly across the surface, without any reflective highlights. It’s particularly effective for objects that don’t need shine, creating a soft, even-lit look that brings out the object’s form without extra distractions.

Implementation Details:

The Lambert shader calculates the dot product between the light direction and the surface normal. The result is a natural look, as it spreads light evenly over the surface.
In this project, I specifically tuned this shader to emphasize the ambient light setting, giving objects a solid base lighting for comparison with other effects.

Scene Impact: Using diffuse lighting as a base is useful for providing natural lighting that feels soft and unobtrusive. This shader’s simplicity makes it a good choice for foundational lighting in the scene, especially for surfaces like the ground.

Specular Shader

The Specular shader creates shiny highlights on objects, simulating reflective surfaces. It’s designed to model light bouncing off a surface in a focused way, as you’d see on polished or metallic surfaces.

Implementation Details:

This shader calculates the reflection angle between the light source and the camera. When the angle is close, it produces a bright highlight.
I adjusted the glossiness and intensity of the specular reflection to fit the lighting in this scene, balancing it to keep the highlights noticeable but not overwhelming.

Scene Impact: Adding specular highlights helps distinguish materials visually and makes objects appear more dynamic. The highlights interact with the scene’s light source, which enhances the realism of the scene by mimicking shiny surfaces under direct light.

Rim Lighting Shader

The Rim Lighting shader highlights the edges of objects, giving them a subtle outline or “glow.” This shader is commonly used to make objects stand out, as it adds an effect that accentuates their silhouette.

Implementation Details:

This effect is calculated by taking the dot product between the surface normal and the view direction. Lower values (when the surface faces away from the camera) are emphasized, creating a glow around the edges.
I tuned the intensity of the rim lighting to keep it subtle, so it adds depth without overpowering the scene.

Scene Impact: Rim lighting helps objects stand out from their surroundings and provides a sense of depth. In darker parts of the scene, the rim lighting effect makes objects easier to distinguish and adds a unique stylistic touch.


LightingModeToggle Script

The LightingModeToggle script controls different lighting modes, allowing me to showcase each shader and lighting effect. By pressing specific keys, I can toggle between different lighting setups to compare how they affect the scene:

    1 - No Lighting: Ambient light only.
    2 - Ambient Lighting Only: Applies only the Lambert (Diffuse) lighting.
    3 - Specular Lighting Only: Adds shiny highlights without the ambient component.
    4 - Ambient + Specular: Combines soft ambient lighting with specular highlights.

Color Grading

Color grading was added to adjust the entire scene’s color tone. This effect creates a specific mood or atmosphere by shifting colors slightly.
Color Grading Shader

The color grading setup uses a Look-Up Table (LUT) to adjust colors across the scene. I created two versions of the LUT: Neutral (default colors) and Warm (adds a yellow tone).

Implementation Details:

The shader applies a LUT to the camera view, remapping colors based on the selected LUT. I used a Neutral LUT as a baseline and a Warm LUT for an alternative color style.
Instead of switching LUTs automatically, I can manually change between them in the editor for the demonstration.

Scene Impact: The color grading effect shifts the overall feel of the scene, with the cool LUT giving a chill appearance and the Warm LUT adding a cozy, yellowish tone. This effect helps convey different moods without changing the actual color of objects individually.