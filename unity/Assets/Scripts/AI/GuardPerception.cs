using UnityEngine;
using ShadowContract.Player;
using ShadowContract.Core;

namespace ShadowContract.AI
{
    /// <summary>
    /// Guard sensory system conforming strictly to GDD Section 6.
    /// Manages vision cone, raycast line-of-sight obstruction, and progressive detection building.
    /// </summary>
    public class GuardPerception : MonoBehaviour
    {
        [Header("Vision Parameters")]
        [SerializeField] private float viewDistance = 6.0f;
        [SerializeField] private float viewAngle = 70.0f; // Total field of view in degrees
        [SerializeField] private LayerMask visionObstructionLayer; // Walls, closed doors, cabinets

        [Header("Detection Timing")]
        [SerializeField] private float detectionBuildRate = 1.2f; // Seconds to full alert at edge
        [SerializeField] private float detectionDecayRate = 0.8f; // Seconds to decay
        [SerializeField] private float alertThreshold = 1.0f;

        public float DetectionMeter { get; private set; } = 0.0f;
        public bool CanSeePlayer { get; private set; } = false;

        private Vector2 facingDirection = Vector2.right;

        public void SetFacingDirection(Vector2 direction)
        {
            if (direction.sqrMagnitude > 0.01f)
            {
                facingDirection = direction.normalized;
            }
        }

        public bool CheckLineOfSight(Vector2 targetPosition)
        {
            Vector2 origin = transform.position;
            Vector2 toTarget = targetPosition - origin;
            float distance = toTarget.magnitude;

            // 1. Distance check
            if (distance > viewDistance)
                return false;

            // 2. Field of view angle check
            float angle = Vector2.Angle(facingDirection, toTarget);
            if (angle > viewAngle * 0.5f)
                return false;

            // 3. Obstruction check (GDD Rule: Never let guards see through solid walls)
            RaycastHit2D hit = Physics2D.Raycast(origin, toTarget.normalized, distance, visionObstructionLayer);
            if (hit.collider != null)
            {
                // Line of sight blocked by wall or closed cabinet
                return false;
            }

            return true;
        }

        private void Update()
        {
            PlayerController player = PlayerController.Instance;
            if (player == null || player.IsHidden)
            {
                // Player concealed or non-existent
                CanSeePlayer = false;
                DetectionMeter = Mathf.Max(0f, DetectionMeter - detectionDecayRate * Time.deltaTime);
                return;
            }

            CanSeePlayer = CheckLineOfSight(player.transform.position);

            if (CanSeePlayer)
            {
                float dist = Vector2.Distance(transform.position, player.transform.position);
                float distanceMultiplier = Mathf.Clamp01(1.5f - (dist / viewDistance));
                DetectionMeter = Mathf.Min(alertThreshold, DetectionMeter + (detectionBuildRate * distanceMultiplier) * Time.deltaTime);
            }
            else
            {
                DetectionMeter = Mathf.Max(0f, DetectionMeter - detectionDecayRate * Time.deltaTime);
            }
        }

        private void OnDrawGizmosSelected()
        {
            Gizmos.color = CanSeePlayer ? Color.red : Color.yellow;
            Gizmos.DrawWireSphere(transform.position, viewDistance);

            Vector3 leftRay = Quaternion.Euler(0, 0, viewAngle * 0.5f) * facingDirection * viewDistance;
            Vector3 rightRay = Quaternion.Euler(0, 0, -viewAngle * 0.5f) * facingDirection * viewDistance;

            Gizmos.DrawRay(transform.position, leftRay);
            Gizmos.DrawRay(transform.position, rightRay);
        }
    }
}
