using System.Collections.Generic;
using UnityEngine;
using ShadowContract.AI;
using ShadowContract.Player;

namespace ShadowContract.Combat
{
    /// <summary>
    /// Player firearm with automatic target acquisition conforming to GDD Section 8.
    /// </summary>
    public class AutoAimWeapon : MonoBehaviour
    {
        [Header("Weapon Specs")]
        [SerializeField] private float range = 7.0f;
        [SerializeField] private float aimConeAngle = 60.0f;
        [SerializeField] private float damage = 50.0f;
        [SerializeField] private float fireCooldown = 0.5f;
        [SerializeField] private float noiseRadius = 9.0f;
        [SerializeField] private LayerMask hostileLayer;
        [SerializeField] private LayerMask obstacleLayer;

        private float lastFireTime = 0f;

        public bool TryFire(PlayerController player)
        {
            if (Time.time - lastFireTime < fireCooldown) return false;
            lastFireTime = Time.time;

            // Target selection rule: Nearest visible hostile within range & aim cone
            GuardFSM target = FindBestTarget(player.transform.position, player.FacingDirection);

            if (target != null)
            {
                // Inflict damage
                target.TakeTakedown();
            }

            // Emit gunfire noise alert
            EmitGunfireNoise(player.transform.position);
            return true;
        }

        private GuardFSM FindBestTarget(Vector2 origin, Vector2 facing)
        {
            Collider2D[] hostiles = Physics2D.OverlapCircleAll(origin, range, hostileLayer);
            GuardFSM best = null;
            float closestDist = float.MaxValue;

            foreach (var col in hostiles)
            {
                GuardFSM guard = col.GetComponent<GuardFSM>();
                if (guard == null || guard.CurrentState == GuardState.Defeated) continue;

                Vector2 toGuard = (Vector2)guard.transform.position - origin;
                float angle = Vector2.Angle(facing, toGuard);
                if (angle > aimConeAngle * 0.5f) continue;

                // Wall obstruction check
                RaycastHit2D hit = Physics2D.Raycast(origin, toGuard.normalized, toGuard.magnitude, obstacleLayer);
                if (hit.collider != null) continue; // Blocked by wall

                float dist = toGuard.sqrMagnitude;
                if (dist < closestDist)
                {
                    closestDist = dist;
                    best = guard;
                }
            }

            return best;
        }

        private void EmitGunfireNoise(Vector2 origin)
        {
            Collider2D[] listeners = Physics2D.OverlapCircleAll(origin, noiseRadius, hostileLayer);
            foreach (var col in listeners)
            {
                GuardFSM guard = col.GetComponent<GuardFSM>();
                if (guard != null)
                {
                    guard.HearNoise(origin);
                }
            }
        }
    }
}
