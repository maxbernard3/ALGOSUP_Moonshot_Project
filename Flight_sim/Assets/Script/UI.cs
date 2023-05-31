using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class UI : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        string speed = (FlightModel.LocalVelocity.z).ToString("0");
        var dispSpeed = transform.GetChild(0).gameObject.GetComponent<TextMeshProUGUI>();

        dispSpeed.text = speed;
    }
}
