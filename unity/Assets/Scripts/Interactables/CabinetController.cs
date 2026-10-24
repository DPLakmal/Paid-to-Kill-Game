using System.Collections;
using UnityEngine;
using ShadowContract.Player;

namespace ShadowContract.Interactables
{
    public enum CabinetState
    {
        Closed,
        Opening,
        Occupied,
        Closing
    }

    /// <summary>
    /// Interactive concealment cabinet conforming strictly to GDD Section 7.
    /// Conceals the player from guard vision and line of sight when occupied and closed.
    /// </summary>
    public class CabinetController : MonoBehaviour
    {
        [Header("Cabinet Configuration")]
        [SerializeField] private float interactionRadius = 1.2f;
        [SerializeField] private Transform entryPoint;
        [SerializeField] private Transform exitPoint;
        [SerializeField] private LayerMask obstacleLayer;

        [Header("State")]
        public CabinetState State { get; private set; } = CabinetState.Closed;
        public bool IsOccupied => State == CabinetState.Occupied || State == CabinetState.Opening || State == CabinetState.Closing;

        private SpriteRenderer spriteRenderer;

        private void Awake()
        {
            spriteRenderer = GetComponent<SpriteRenderer>();
            if (entryPoint == null) entryPoint = transform;
            if (exitPoint == null) exitPoint = transform;
        }

        /// <summary>
        /// Validates if the player can hide inside this cabinet.
        /// </summary>
        public bool CanPlayerEnter(Vector2 playerPosition)
        {
            if (IsOccupied) return false;
            float distance = Vector2.Distance(playerPosition, (Vector2)entryPoint.position);
            return distance <= interactionRadius;
        }

        /// <summary>
        /// Attempts to conceal the player inside the cabinet.
        /// </summary>
        public IEnumerator EnterCabinet(PlayerConcealment player, float speedMultiplier)
        {
            if (IsOccupied) yield break;

            State = CabinetState.Opening;
            yield return new WaitForSeconds(0.2f * speedMultiplier);

            // Conceal player: hide sprite and disable world collision
            player.SetConcealed(true, this);
            State = CabinetState.Occupied;

            yield return new WaitForSeconds(0.15f * speedMultiplier);
            State = CabinetState.Occupied;
        }

        /// <summary>
        /// Validates if the exit point is unobstructed by walls or guards (GDD Section 7.1).
        /// </summary>
        public bool IsExitClear()
        {
            Vector2 checkPos = exitPoint != null ? (Vector2)exitPoint.position : (Vector2)transform.position + Vector2.down;
            Collider2D hit = Physics2D.OverlapCircle(checkPos, 0.35f, obstacleLayer);
            return hit == null;
        }

        /// <summary>
        /// Safely exits the cabinet back into the world.
        /// </summary>
        public IEnumerator ExitCabinet(PlayerConcealment player, float speedMultiplier)
        {
            if (State != CabinetState.Occupied) yield break;

            if (!IsExitClear())
            {
                Debug.LogWarning("[CabinetController] Exit destination blocked! Player remains safely concealed.");
                yield break;
            }

            State = CabinetState.Opening;
            yield return new WaitForSeconds(0.2f * speedMultiplier);

            Vector2 spawnPos = exitPoint != null ? (Vector2)exitPoint.position : (Vector2)transform.position + Vector2.down;
            player.SetConcealed(false, null, spawnPos);

            yield return new WaitForSeconds(0.15f * speedMultiplier);
            State = CabinetState.Closed;
        }

        private void OnDrawGizmosSelected()
        {
            Gizmos.color = Color.cyan;
            Gizmos.DrawWireSphere(entryPoint != null ? entryPoint.position : transform.position, interactionRadius);

            Gizmos.color = Color.green;
            if (exitPoint != null)
            {
                Gizmos.DrawWireSphere(exitPoint.position, 0.35f);
            }
        }
    }
}
