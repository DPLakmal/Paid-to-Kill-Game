using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using ShadowContract.Player;
using ShadowContract.Core;

namespace ShadowContract.AI
{
    public enum GuardState
    {
        Patrol,
        Investigate,
        AlertChase,
        Attack,
        Search,
        Return,
        Defeated
    }

    /// <summary>
    /// Guard Finite-State Machine conforming strictly to GDD Section 9.
    /// Manages state transitions, waypoint patrolling, search sweeps, and attacks.
    /// </summary>
    [RequireComponent(typeof(GuardPerception), typeof(Rigidbody2D))]
    public class GuardFSM : MonoBehaviour
    {
        [Header("Patrol Waypoints")]
        [SerializeField] private List<Transform> patrolWaypoints = new List<Transform>();
        [SerializeField] private float patrolSpeed = 2.2f;
        [SerializeField] private float chaseSpeed = 3.8f;
        [SerializeField] private float waypointWaitTime = 2.0f;

        [Header("Combat")]
        [SerializeField] private float attackRange = 4.0f;
        [SerializeField] private float attackCooldown = 1.2f;
        [SerializeField] private float attackDamage = 25.0f;

        public GuardState CurrentState { get; private set; } = GuardState.Patrol;

        private GuardPerception perception;
        private Rigidbody2D rb;
        private int currentWaypointIndex = 0;
        private float stateTimer = 0f;
        private Vector2 lastKnownPosition;
        private float lastAttackTime = 0f;

        private void Awake()
        {
            perception = GetComponent<GuardPerception>();
            rb = GetComponent<Rigidbody2D>();
        }

        private void Start()
        {
            if (patrolWaypoints.Count > 0)
            {
                transform.position = patrolWaypoints[0].position;
            }
        }

        private void Update()
        {
            if (CurrentState == GuardState.Defeated) return;

            // Handle perception-triggered transitions
            if (perception.DetectionMeter >= 1.0f)
            {
                if (CurrentState != GuardState.AlertChase && CurrentState != GuardState.Attack)
                {
                    TransitionToState(GuardState.AlertChase);
                    GameManager.Instance?.OnGlobalAlarmRaised("alert");
                }
            }
            else if (perception.DetectionMeter > 0.35f && CurrentState == GuardState.Patrol)
            {
                TransitionToState(GuardState.Investigate);
            }

            // Execute state tick
            switch (CurrentState)
            {
                case GuardState.Patrol:
                    TickPatrol();
                    break;
                case GuardState.Investigate:
                    TickInvestigate();
                    break;
                case GuardState.AlertChase:
                    TickChase();
                    break;
                case GuardState.Attack:
                    TickAttack();
                    break;
                case GuardState.Search:
                    TickSearch();
                    break;
                case GuardState.Return:
                    TickReturn();
                    break;
            }
        }

        private void TransitionToState(GuardState newState)
        {
            CurrentState = newState;
            stateTimer = 0f;

            if (PlayerController.Instance != null)
            {
                lastKnownPosition = PlayerController.Instance.transform.position;
            }
        }

        private void TickPatrol()
        {
            if (patrolWaypoints.Count == 0) return;

            Transform targetWaypoint = patrolWaypoints[currentWaypointIndex];
            Vector2 toWaypoint = (Vector2)targetWaypoint.position - rb.position;

            if (toWaypoint.magnitude < 0.2f)
            {
                rb.velocity = Vector2.zero;
                stateTimer += Time.deltaTime;
                if (stateTimer >= waypointWaitTime)
                {
                    stateTimer = 0f;
                    currentWaypointIndex = (currentWaypointIndex + 1) % patrolWaypoints.Count;
                }
            }
            else
            {
                Vector2 moveDir = toWaypoint.normalized;
                rb.velocity = moveDir * patrolSpeed;
                perception.SetFacingDirection(moveDir);
            }
        }

        private void TickInvestigate()
        {
            Vector2 toTarget = lastKnownPosition - rb.position;
            if (toTarget.magnitude > 0.3f)
            {
                Vector2 moveDir = toTarget.normalized;
                rb.velocity = moveDir * patrolSpeed;
                perception.SetFacingDirection(moveDir);
            }
            else
            {
                rb.velocity = Vector2.zero;
                stateTimer += Time.deltaTime;
                // Survey surroundings
                if (stateTimer > 3.0f)
                {
                    TransitionToState(GuardState.Return);
                }
            }
        }

        private void TickChase()
        {
            PlayerController player = PlayerController.Instance;
            if (player == null || player.IsHidden)
            {
                TransitionToState(GuardState.Search);
                return;
            }

            lastKnownPosition = player.transform.position;
            Vector2 toPlayer = (Vector2)player.transform.position - rb.position;
            float dist = toPlayer.magnitude;

            perception.SetFacingDirection(toPlayer);

            if (dist <= attackRange && perception.CanSeePlayer)
            {
                TransitionToState(GuardState.Attack);
            }
            else
            {
                rb.velocity = toPlayer.normalized * chaseSpeed;
            }
        }

        private void TickAttack()
        {
            rb.velocity = Vector2.zero;
            PlayerController player = PlayerController.Instance;

            if (player == null || player.IsHidden || !perception.CanSeePlayer)
            {
                TransitionToState(GuardState.Search);
                return;
            }

            Vector2 toPlayer = (Vector2)player.transform.position - rb.position;
            perception.SetFacingDirection(toPlayer);

            if (toPlayer.magnitude > attackRange + 1.0f)
            {
                TransitionToState(GuardState.AlertChase);
                return;
            }

            if (Time.time - lastAttackTime >= attackCooldown)
            {
                lastAttackTime = Time.time;
                player.TakeDamage(attackDamage);
            }
        }

        private void TickSearch()
        {
            rb.velocity = Vector2.zero;
            stateTimer += Time.deltaTime;

            if (stateTimer > 4.0f)
            {
                TransitionToState(GuardState.Return);
            }
        }

        private void TickReturn()
        {
            if (patrolWaypoints.Count == 0)
            {
                TransitionToState(GuardState.Patrol);
                return;
            }

            Transform target = patrolWaypoints[currentWaypointIndex];
            Vector2 toTarget = (Vector2)target.position - rb.position;

            if (toTarget.magnitude < 0.25f)
            {
                TransitionToState(GuardState.Patrol);
            }
            else
            {
                Vector2 moveDir = toTarget.normalized;
                rb.velocity = moveDir * patrolSpeed;
                perception.SetFacingDirection(moveDir);
            }
        }

        public void TakeTakedown()
        {
            CurrentState = GuardState.Defeated;
            rb.velocity = Vector2.zero;
            enabled = false;
            perception.enabled = false;
            GetComponent<Collider2D>().enabled = false;
            GameManager.Instance?.OnGuardNeutralized();
        }

        /// <summary>
        /// Called when gunshot or explosion noise occurs nearby.
        /// </summary>
        public void HearNoise(Vector2 noiseOrigin)
        {
            if (CurrentState == GuardState.Defeated) return;
            lastKnownPosition = noiseOrigin;
            TransitionToState(GuardState.Investigate);
        }
    }
}
