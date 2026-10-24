using UnityEngine;
using ShadowContract.Interactables;
using ShadowContract.Core;

namespace ShadowContract.Player
{
    /// <summary>
    /// Manages assassin concealment inside cabinets, lockers, and shadows.
    /// </summary>
    public class PlayerConcealment : MonoBehaviour
    {
        public bool IsHidden { get; private set; } = false;
        public CabinetController CurrentCabinet { get; private set; }

        private SpriteRenderer spriteRenderer;
        private Collider2D playerCollider;
        private Rigidbody2D rb;

        private void Awake()
        {
            spriteRenderer = GetComponent<SpriteRenderer>();
            playerCollider = GetComponent<Collider2D>();
            rb = GetComponent<Rigidbody2D>();
        }

        public void SetConcealed(bool hidden, CabinetController cabinet, Vector2? exitPosition = null)
        {
            IsHidden = hidden;
            CurrentCabinet = hidden ? cabinet : null;

            if (spriteRenderer != null)
                spriteRenderer.enabled = !hidden;

            if (playerCollider != null)
                playerCollider.enabled = !hidden;

            if (rb != null)
            {
                rb.velocity = Vector2.zero;
                rb.simulated = !hidden;
            }

            if (!hidden && exitPosition.HasValue)
            {
                transform.position = exitPosition.Value;
            }

            // Report state change to GameManager
            GameManager.Instance?.OnPlayerConcealmentChanged(IsHidden);
        }
    }
}
