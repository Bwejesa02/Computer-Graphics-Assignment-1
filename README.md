# Computer Graphics Assignment 1

This project demonstrates core computer graphics concepts through a simple interactive scene in Unity. It includes various shaders, lighting effects, color grading, and basic gameplay mechanics. This README explains each part of the project in detail, with a particular focus on the shaders, which are central to the assignment.

## Project Overview

The goal of this project was to create a small Unity scene to showcase different lighting and shading effects, color grading, and a basic game setup. I built it with a player character that collects items in a confined space, using shaders to highlight different lighting models and effects.

## Scene and Gameplay Setup

The scene consists of:
- **Player (Cube)**: The main character that the user controls using WASD keys.
- **Collectibles (Spheres)**: Items scattered around the plane that disappear when collected.
- **Boundaries (Walls)**: Simple walls to keep the player within the play area.
- **UI Text**: Display showing the number of collectibles left and a "You Win" message when all items are gathered.

This setup creates a straightforward game where the player must collect all items to win. 

## Shaders and Lighting

### Lambert (Diffuse) Shader
The Lambert shader provides a basic diffuse lighting effect, which I used to simulate natural, even lighting across surfaces. This shader calculates light intensity based on the angle between the light direction and the surface normal, giving it a smooth, non-reflective look. 

- **Why Lambert?** Diffuse lighting is the foundation of most lighting models and was essential to start with to demonstrate a basic lighting effect. It helps give objects a soft, realistic look without sharp reflections, suitable for surfaces like walls or the ground.
- **Implementation**: The Lambert shader multiplies the light color with the surface color based on the angle of incidence, creating an even spread of light on the object's surface.

### Specular Shader
The Specular shader adds highlights to objects, simulating shinier surfaces that reflect light. I chose this shader to demonstrate reflective properties and how different materials can interact with light in unique ways.

- **Why Specular?** Specular lighting is essential for objects that need a sense of polish or gloss. Using specular highlights in the scene gives a stronger impression of light sources and helps differentiate surface materials.
- **Implementation**: The shader calculates the angle between the viewer and the reflection of the light on the surface. This reflection vector is used to determine where the light highlights appear on the object, producing sharp, focused highlights.

### Rim Lighting Shader
The Rim Lighting shader creates a glowing effect around the edges of objects, emphasizing their silhouette. This effect is calculated based on the angle between the surface normal and the view direction, so the edges facing away from the camera glow more.

- **Why Rim Lighting?** Rim lighting is useful to make objects stand out visually, especially in stylized or atmospheric scenes. I included this shader to add a unique look that draws attention to object outlines, giving them a subtle glow and enhancing visibility.
- **Implementation**: The shader calculates the dot product between the surface normal and view direction, adding color to areas where this value is lower, emphasizing the edges.

### Lighting Mode Toggle Script
To demonstrate the different lighting modes, I created a **LightingModeToggle script** that allows switching between various lighting setups. This script applies lighting effects globally, impacting all objects in the scene, and is controlled by pressing specific keys:
- **1** - No Lighting (ambient only)
- **2** - Ambient Lighting Only
- **3** - Specular Lighting Only
- **4** - Ambient + Specular

This toggle script helps compare the effects of each lighting mode directly in the scene. 

#### How It Works:
The script adjusts Unity's ambient light settings and enables or disables a directional light for specular highlights. For example, in "No Lighting" mode, it disables all lights to give a neutral view of objects. This approach lets me control the scene lighting without changing each object's individual materials.

---

## Color Grading

Color grading was added to adjust the scene's color tones. I used a **Color Grading Shader** with two LUTs (Neutral and Warm) to change the overall mood of the scene. This effect was applied to the main camera, impacting everything in the view.

- **Why Color Grading?** Color grading allows for a uniform color adjustment across the entire scene, creating a more cohesive look. In this project, the Neutral LUT gives a standard appearance, while the Warm LUT adds a yellowish tone, suggesting a warmer atmosphere.
- **Implementation**: The Color Grading shader uses a Look-Up Table (LUT) to remap colors in real-time, altering the appearance of every object in the camera's view.