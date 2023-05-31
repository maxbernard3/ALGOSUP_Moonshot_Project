using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class InternationalStandardAtmosphere
{
    //Temperature gradienin Kelvin per metre
    float[] a_val = { -0.0065f, 0, 0.0010f, 0.0028f, 0, -0.0028f, -0.0020f, 0 };

    //ISA at sea level
    public float Pd = 101325;  //Pascals
    public float Dd = 1.225f;   //Kg per cubic metre    
    public float Td = 288.15f;  //Kelvin

    //Constants
    float g = 9.80665f;  //Acceleration due to gravity   
    float R = 287.0f;    //Molar gas constant for air
    float e = 2.71828f;  //Euler's constant

    //Altitudes
    float[] alt = { 11000, 20000, 32000, 47000, 51000, 71000, 84000, 90000, 0 };

    //variables
    float[] final = { 0, 0, 0 };   //Pressure final, Density final, Temperature final

    int counter = 0;

    public float[] CalculateISA(int h)
    {
        sphere(h, Pd, Td);

        return final;
    }

    private void sphere(float h, float Pi, float Ti)
    {
        float x;
        if (h > alt[counter])
        {
            x = alt[counter];
        }
        else
        {
            x = h;
        }
        float a = a_val[counter];
        float exp = -g / (R * (a));
        float Tf;
        if (counter == 0)
        {
            Tf = Ti + a * (x - alt[alt.Length - 1]);
        }
        else
        {
            Tf = Ti + a * (x - alt[counter - 1]);
        }

        float Pf = Pi * Mathf.Pow(Tf / Ti, exp);
        float Df = Pf / (R * Tf);

        if (h > alt[alt.Length - 2])
        {
            Debug.Log("Altitude out of range");
        }
        else if (h > alt[counter])
        {
            if (counter == 0 || counter == 3 || counter == 6)
            {
                counter += 1;
                pause(h, Pf, Tf);
            }
            else
            {
                counter += 1;
                sphere(h, Pf, Tf);
            }
        }
        else
        {
            final[0] = Pf;
            final[1] = Df;
            final[2] = Tf;
        }
    }

    private void pause(float h, float Pi, float Ti)
    {
        float x;
        if (h > alt[counter])
        {
            x = alt[counter];
        }
        else
        {
            x = h;
        }
        float Tf = Ti;

        float exp;
        if (counter == 0)
        {
            exp = (-(g * (x - alt[alt.Length - 1])) / (R * Tf));
        }
        else
        {
            exp = (-(g * (x - alt[counter - 1])) / (R * Tf));
        }

        float Pf = Pi * Mathf.Pow(e, exp);
        float Df = Pf / (R * Tf);
        if (h > alt[alt.Length - 2])
        {
            Debug.Log("Altitude out of range");
        }
        else if (h > alt[counter])
        {
            if (counter == 0 || counter == 3 || counter == 6)
            {
                counter += 1;
                pause(h, Pf, Tf);
            }
            else
            {
                counter += 1;
                sphere(h, Pf, Tf);
            }
        }
        else
        {
            final[0] = Pf;
            final[1] = Df;
            final[2] = Tf;
        }
    }
}