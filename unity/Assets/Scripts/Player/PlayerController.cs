using UnityEngine;
using ShadowContract.Core;
using ShadowContract.Interactables;

namespace ShadowContract.Player
{
    /// <summary>
    /// Top-down assassin player controller conforming to GDD Section 5.
    /// Normalizes diagonal movement, interacts contextually with cabinets and targets.
    /// </summary>
    [RequireComponent(typeof(Rigidbody2D), typeof(PlayerConcealment))]
    public class PlayerController : MonoBehaviour
    {
        public static PlayerController Instance { get; private set; }

        [Header("Movement Attributes")]
        [SerializeField] private float baseMoveSpeed = 4.5f;
        private float moveSpeedMultiplier = 1.0f;
        private float maxHealth = 100f;
        private float currentHealth = 100f;

        [Header("Interaction Configuration")]
        [SerializeField] private float interactionScanRadius = 1.4f;
        [SerializeField] private LayerMask interactableLayer;

        private Rigidbody2D rb;
        private PlayerConcealment concealment;
        private Vector2 movementInput = Vector2.zero;
        private Vector2 facingDirection = Vector2.down;
        private CabinetController nearbyCabinet;

        public float CurrentHealth => currentHealth;
        public float MaxHealth => maxHealth;
        public Vector2 FacingDirection => facingDirection;
        public bool IsHidden => concealment.IsHidden;

        private void Awake()
        {
            Instance = this;
            rb = GetComponent<Rigidbody2D>();
            concealment = GetComponent<PlayerConcealment>();
        }

        private void Start()
        {
            currentHealth = maxHealth;
        }

        public void ApplyUpgrades(StartMissionData data)
        {
            moveSpeedMultiplier = data.movementSpeedMultiplier;
            maxHealth = data.maxHealth;
            currentHealth = maxHealth;
        }

        private void Update()
        {
            if (concealment.IsHidden)
            {
                rb.velocity = Vector2.zero;
                return;
            }

            // Keyboard / Virtual Joystick input polling
            float h = Input.GetAxisRaw("Horizontal");
            float v = Input.GetAxisRaw("Vertical");
            movementInput = new Vector2(h, v);

            // GDD Rule 5: Normalize movement so diagonals are not faster
            if (movementInput.sqrMagnitude > 1.0f)
            {
                movementInput.Normalize();
            }

            if (movementInput.sqrMagnitude > 0.05f)
            {
                facingDirection = movementInput.normalized;
            }

            ScanContextualActions();
        }

        private void FixedUpdate()
        {
            if (concealment.IsHidden)
            {
                rb.velocity = Vector2.zero;
                return;
            }

            rb.velocity = movementInput * (baseMoveSpeed * moveSpeedMultiplier);
        }

        /// <summary>
        /// Contextual action scanning (GDD Section 5 & 7).
        /// </summary>
        private void ScanContextualActions()
        {
            if (concealment.IsHidden)
            {
                GameManager.Instance?.UpdateContextAction("exitCabinet");
                return;
            }

            Collider2D hit = Physics2D.OverlapCircle(transform.position, interactionScanRadius, interactableLayer);
            if (hit != null)
            {
                CabinetController cabinet = hit.GetComponent<CabinetController>();
                if (cabinet != null && cabinet.CanPlayerEnter(transform.position))
                {
                    nearbyCabinet = cabinet;
                    GameManager.Instance?.UpdateContextAction("hide");
                    return;
                }
            }

            nearbyCabinet = null;
            GameManager.Instance?.UpdateContextAction("none");
        }

        /// <summary>
        /// Triggered from Flutter bridge context action button.
        /// </summary>
        public void TriggerContextAction(string action)
        {
            if (action == "hide" && nearbyCabinet != null && !concealment.IsHidden)
            {
                StartCoroutine(nearbyCabinet.EnterCabinet(concealment, 1.0f));
            }
            else if (action == "exitCabinet" && concealment.IsHidden && concealment.CurrentCabinet != null)
            {
                StartCoroutine(concealment.CurrentCabinet.ExitCabinet(concealment, 1.0f));
            }
        }

        public void TakeDamage(float amount)
        {
            if (concealment.IsHidden) return;

            currentHealth = Mathf.Max(0, currentHealth - amount);
            GameManager.Instance?.OnPlayerDamaged(amount);

            if (currentHealth <= 0)
            {
                GameManager.Instance?.OnPlayerDefeated();
            }
        }

        private void OnDrawGizmosSelected()
        {
            Gizmos.color = Color.yellow;
            Gizmos.DrawWireSphere(transform.position, interactionScanRadius);
        }
    }
}
