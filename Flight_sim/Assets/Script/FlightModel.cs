using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlightModel : MonoBehaviour
{
    public float launch = 100;

    [Header("Pitch")]
    public KeyCode pitchUp = KeyCode.S;
    public KeyCode pitchDown = KeyCode.Z;

    [Header("Roll")]
    public KeyCode rollRight = KeyCode.D;
    public KeyCode rollLeft = KeyCode.Q;

    [Header("Yaw")]
    public KeyCode yawRight = KeyCode.E;
    public KeyCode yawLeft = KeyCode.A;

    [Header("Throttle")]
    public KeyCode throttleUp = KeyCode.P;
    public KeyCode throttleDown = KeyCode.M;

    public static Rigidbody Rigidbody;
    public float maxThrust = 1000;
    float throttleSpeed = 0.5f;
    float gLimit = 9;
    float gLimitPitch = 9;


    [Header("Lift")]
    public float liftPower;
    public AnimationCurve liftAOACurve;
    public float inducedDrag;
    public AnimationCurve inducedDragCurve;
    public float rudderPower;
    public AnimationCurve rudderAOACurve;
    public AnimationCurve rudderInducedDragCurve;


    [Header("Drag")]
    public AnimationCurve dragForward;
    public AnimationCurve dragBack;
    public AnimationCurve dragLeft;
    public AnimationCurve dragRight;
    public AnimationCurve dragTop;
    public AnimationCurve dragBottom;
    public Vector3 angularDrag;

    [Header("Control Surface")]
    public float pitchTorque = 4000;
    public float rollTorque = 4000;
    public float yawTorque = 4000;

    private Vector3 Velocity = new Vector3(0, 0, 0);
    private Vector3 lastVelocity = new Vector3(0, 0, 0);
    public static Vector3 LocalVelocity = new Vector3(0, 0, 0);
    private Vector3 LocalAngularVelocity = new Vector3(0, 0, 0);
    private Vector3 LocalGForce = new Vector3(0, 0, 0);
    private float[] Atmosphere = {0, 0, 0};
    private float[] RelativeAtmosphere = {0, 0, 0};
    private float AngleOfAttack = 0;
    private float AngleOfAttackYaw = 0;
    private float Throttle = 0;
    private float Pitch = 0;
    private float Roll = 0;
    private float Yaw = 0;
    private float Altitude = 0;

    private InternationalStandardAtmosphere ISA = new InternationalStandardAtmosphere();

    // Start is called before the first frame update
    void Start()
    {
        Vector3 innitialSpeed = Vector3.forward * launch;
        Rigidbody.velocity = innitialSpeed;
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        float dt = Time.fixedDeltaTime;

        Throttle = UpdateStickyControl(throttleUp, throttleDown, Throttle);
        Pitch = UpdateControl(pitchUp, pitchDown);
        Roll = UpdateControl(rollRight, rollLeft);
        Yaw = UpdateControl(yawRight, yawLeft);

        CalculateState();
        CalculateAngleOfAttack();
        CalculateGForce(dt);
        CalculateAtmosphere();
        UpdatePitch();
        UpdateRoll();
        UpdateYaw();
        UpdateThrust();
        UpdateDrag();
        UpdateLift();
    }

    void CalculateState()
    {
        Quaternion invRotation = Quaternion.Inverse(Rigidbody.rotation);
        Velocity = Rigidbody.velocity;
        LocalVelocity = invRotation * Velocity;
        LocalAngularVelocity = invRotation * Rigidbody.angularVelocity;
        Altitude = Rigidbody.position.y;
    }

    void CalculateAngleOfAttack()
    {
        if (LocalVelocity.sqrMagnitude < 0.01f)
        {
            AngleOfAttack = 0;
            AngleOfAttackYaw = 0;
            return;
        }

        AngleOfAttack = Mathf.Atan2(-LocalVelocity.y, LocalVelocity.z);
        AngleOfAttackYaw = Mathf.Atan2(LocalVelocity.x, LocalVelocity.y);
    }

    void UpdatePitch()
    {
        if(Pitch != 0)
        {
            Vector3 p = Vector3.left * pitchTorque * LocalVelocity.z * Pitch;
            Rigidbody.AddRelativeTorque(p);
        }
    }

    void UpdateRoll()
    {
        if (Roll != 0)
        {
            Vector3 p = Vector3.back * rollTorque * LocalVelocity.z * Roll;
            Rigidbody.AddRelativeTorque(p);
        }
    }

    void UpdateYaw()
    {
        if (Yaw != 0)
        {
            Vector3 p = Vector3.up * yawTorque * LocalVelocity.z * Yaw;
            Rigidbody.AddRelativeTorque(p);
        }
    }

    void CalculateGForce(float dt)
    {
        Quaternion invRotation = Quaternion.Inverse(Rigidbody.rotation);
        Vector3 acceleration = (Velocity - lastVelocity) / dt;
        LocalGForce = invRotation * acceleration;
        lastVelocity = Velocity;
    }

    void UpdateThrust()
    {
        Rigidbody.AddRelativeForce(Throttle * maxThrust /* * RelativeAtmosphere[1]*/ * Vector3.forward);
    }

    void UpdateDrag()
    {
        Vector3 coefficient = Utilities.Scale6(
            LocalVelocity.normalized,
            dragRight.Evaluate(Mathf.Abs(LocalVelocity.x)), dragLeft.Evaluate(Mathf.Abs(LocalVelocity.x)),
            dragTop.Evaluate(Mathf.Abs(LocalVelocity.y)), dragBottom.Evaluate(Mathf.Abs(LocalVelocity.y)),
            dragForward.Evaluate(Mathf.Abs(LocalVelocity.z)), dragBack.Evaluate(Mathf.Abs(LocalVelocity.z))
            );

        Vector3 drag = coefficient.magnitude * LocalVelocity.sqrMagnitude * LocalVelocity.normalized * RelativeAtmosphere[1];

        Rigidbody.AddRelativeForce(drag);
    }

    void UpdateLift()
    {
        if (LocalVelocity.sqrMagnitude < 0.01f)
            return;

        Vector3 liftForce = CalculateLift(AngleOfAttack, Vector3.right, liftPower, liftAOACurve);

        Vector3 yawForce = CalculateLift(AngleOfAttackYaw, Vector3.up, rudderPower, rudderAOACurve);

        Rigidbody.AddRelativeForce(liftForce);
        Rigidbody.AddRelativeForce(yawForce);
    }

    Vector3 CalculateLift(float angleOfAttack, Vector3 rightAxis, float liftPower, AnimationCurve aoaCurve)
    {
        Vector3 liftVelocity = Vector3.ProjectOnPlane(LocalVelocity, rightAxis);
        float v2 = liftVelocity.sqrMagnitude;

        float liftCoefficient = aoaCurve.Evaluate(angleOfAttack * Mathf.Rad2Deg);
        float liftForce = v2 * liftCoefficient * liftPower;

        Vector3 liftDirection = Vector3.Cross(liftVelocity.normalized, rightAxis);
        Vector3 lift = liftDirection * liftForce;

        float dragForce = liftCoefficient * liftCoefficient * this.inducedDrag * RelativeAtmosphere[1];
        Vector3 dragDirection = -liftVelocity.normalized;
        Vector3 inducedDrag = dragDirection * v2 * dragForce;

        return lift + inducedDrag;
    }

    void CalculateAtmosphere()
    {
        Atmosphere = ISA.CalculateISA((int)Altitude);
        RelativeAtmosphere[0] = Atmosphere[0] / ISA.Pd;
        RelativeAtmosphere[1] = 1;//Atmosphere[1] / ISA.Dd;
        RelativeAtmosphere[2] = Atmosphere[2] / ISA.Td;
    }

    float UpdateControl(KeyCode up, KeyCode down)
    {
        if (Input.GetKey(up))
        {
            return 1;
        }
        else if (Input.GetKey(down))
        {
            return -1;
        }
        return 0;
    }

    float UpdateStickyControl(KeyCode up, KeyCode down, float effect)
    {
        if (Input.GetKey(up))
        {
            effect += throttleSpeed * Time.deltaTime;
        }
        else if (Input.GetKey(down))
        {
            effect -= throttleSpeed * Time.deltaTime;
        }
        return Mathf.Clamp(effect, 0, 1);
    }
}
