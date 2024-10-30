using UnityEngine;

public class LightingModeToggle : MonoBehaviour
{
    // References to lights for different effects
    public Light directionalLight;  // Main light source for diffuse and specular effects

    void Start()
    {
        // Set initial mode to "No Lighting"
        ApplyNoLighting();
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Alpha1))
        {
            ApplyNoLighting();
            Debug.Log("Mode 1: No Lighting");
        }
        else if (Input.GetKeyDown(KeyCode.Alpha2))
        {
            ApplyAmbientLighting();
            Debug.Log("Mode 2: Ambient Lighting Only");
        }
        else if (Input.GetKeyDown(KeyCode.Alpha3))
        {
            ApplySpecularLighting();
            Debug.Log("Mode 3: Specular Lighting Only");
        }
        else if (Input.GetKeyDown(KeyCode.Alpha4))
        {
            ApplyAmbientSpecularLighting();
            Debug.Log("Mode 4: Ambient + Specular Lighting");
        }
    }

    private void ApplyNoLighting()
    {
        // Disable all lights and ambient settings for a "no lighting" effect
        RenderSettings.ambientMode = UnityEngine.Rendering.AmbientMode.Flat;
        RenderSettings.ambientLight = Color.black;
        if (directionalLight != null) directionalLight.enabled = false;
    }

    private void ApplyAmbientLighting()
    {
        // Enable ambient lighting, disable directional light
        RenderSettings.ambientMode = UnityEngine.Rendering.AmbientMode.Flat;
        RenderSettings.ambientLight = Color.gray;  // Set a color for ambient light
        if (directionalLight != null) directionalLight.enabled = false;
    }

    private void ApplySpecularLighting()
    {
        // Enable directional light for specular highlights, disable ambient light
        RenderSettings.ambientMode = UnityEngine.Rendering.AmbientMode.Flat;
        RenderSettings.ambientLight = Color.black;
        if (directionalLight != null) directionalLight.enabled = true;
    }

    private void ApplyAmbientSpecularLighting()
    {
        // Enable both ambient light and directional light
        RenderSettings.ambientMode = UnityEngine.Rendering.AmbientMode.Flat;
        RenderSettings.ambientLight = Color.gray;
        if (directionalLight != null) directionalLight.enabled = true;
    }
}
