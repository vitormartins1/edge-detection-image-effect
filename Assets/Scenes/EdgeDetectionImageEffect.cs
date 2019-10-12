using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Camera))]
[ExecuteInEditMode, ImageEffectAllowedInSceneView]
public class EdgeDetectionImageEffect : MonoBehaviour
{
    public Shader shader;
    Material material;

    void OnRenderImage(RenderTexture source, RenderTexture destination) {
        if (material == null)
        {
            material = new Material(shader);
        }
        Graphics.Blit(source, destination, material);
    }
}