using UnityEngine;
using System.Collections;

public class CameraOrbit : MonoBehaviour
{
	[SerializeField]
	private float _rotateMultiplier = 16f;

	private void Update()
	{
		Vector3 newEuler = transform.localEulerAngles;
		newEuler.y += Time.deltaTime * _rotateMultiplier;
		transform.localEulerAngles = newEuler;	
	}
}