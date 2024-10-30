using UnityEngine;

[RequireComponent(typeof(Camera))]
public class CameraColorGrading : MonoBehaviour
{
    public Material colorGradingMaterial;

    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        if (colorGradingMaterial != null)
        {
            Graphics.Blit(src, dest, colorGradingMaterial);
        }
        else
        {
            Graphics.Blit(src, dest);
        }
    }
}
