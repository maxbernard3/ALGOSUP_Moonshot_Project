using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EarthFace
{
    Mesh mesh;
    int resolution;
    Vector3 localUp;
    Vector3 axisA;
    Vector3 axisB;

    public EarthFace(Mesh mesh, int resolution, Vector3 localUp)
    {
        this.mesh = mesh;
        this.resolution = resolution;
        this.localUp = localUp;

        axisA = new Vector3(localUp.y, localUp.z, localUp.x);
        axisB = Vector3.Cross(localUp, axisA);
    }

    public void ConstructMesh()
    {
        Vector3[] vertices = new Vector3[resolution * resolution];
        int[] triangles = new int[(resolution - 1) * (resolution - 1) * 6];
        int triIndex = 0;

        for (int y = 0; y < resolution; y++)
        {
            for (int x = 0; x < resolution; x++)
            {
                int vertexIndex = x + y * resolution;
                Vector2 t = new Vector2(x, y) / (resolution - 1f);
                Vector3 point = localUp + axisA * (2 * t.x - 1) + axisB * (2 * t.y - 1);

                Vector3 pointOnSphere = PointToPointOnSphere(point);

                vertices[vertexIndex] = pointOnSphere;

                if (x != resolution - 1 && y != resolution - 1)
                {
                    //1st triangle
                    triangles[triIndex + 0] = vertexIndex;
                    triangles[triIndex + 1] = vertexIndex + resolution + 1;
                    triangles[triIndex + 2] = vertexIndex + resolution;

                    //2nd triangle
                    triangles[triIndex + 3] = vertexIndex;
                    triangles[triIndex + 4] = vertexIndex + 1;
                    triangles[triIndex + 5] = vertexIndex + resolution + 1;

                    triIndex += 6;
                }
            }
        }
        mesh.Clear();
        mesh.vertices = vertices;
        mesh.triangles = triangles;
        mesh.RecalculateNormals();
    }

    private Vector3 PointToPointOnSphere(Vector3 p)
    {
        float x2 = p.x * p.x;
        float y2 = p.y * p.y;
        float z2 = p.z * p.z;
        float x = p.x * Mathf.Sqrt(1 - (y2 + z2) / 2 + (y2 * z2) / 3);
        float y = p.y * Mathf.Sqrt(1 - (z2 + x2) / 2 + (z2 * x2) / 3);
        float z = p.z * Mathf.Sqrt(1 - (y2 + x2) / 2 + (y2 * x2) / 3);

        return new Vector3(x, y, z);
    }
}
