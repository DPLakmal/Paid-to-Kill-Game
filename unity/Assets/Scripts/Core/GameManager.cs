using System.Collections;
using UnityEngine;
using ShadowContract.Player;
using ShadowContract.AI;

namespace ShadowContract.Core
{
    /// <summary>
    /// Master gameplay manager in Unity coordinating entities, game clock, and bridge telemetry.
    /// </summary>
    public class GameManager : MonoBehaviour
    {
        public static GameManager Instance { get; private set; }

        [Header("Mission Telemetry")]
        public string ActiveMissionId = "mission_1_snow_relay";
        public float ElapsedTime = 0f;
        public int AlertsTriggered = 0;
        public int GuardsNeutralized = 0;
        public int DamageReceived = 0;
        public string GlobalAlarmState = "quiet";

        private string currentContextAction = "none";
        private bool isMissionRunning = false;
        private Coroutine hudBroadcastRoutine;

        private void Awake()
        {
            if (Instance != null && Instance != this)
            {
                Destroy(gameObject);
                return;
            }
            Instance = this;
        }

        private void Start()
        {
            hudBroadcastRoutine = StartCoroutine(BroadcastHudRoutine());
        }

        public void StartMission(StartMissionData data)
        {
            ActiveMissionId = data.missionId;
            ElapsedTime = 0f;
            AlertsTriggered = 0;
            GuardsNeutralized = 0;
            DamageReceived = 0;
            GlobalAlarmState = "quiet";
            isMissionRunning = true;
            Time.timeScale = 1.0f;

            if (PlayerController.Instance != null)
            {
                PlayerController.Instance.ApplyUpgrades(data);
            }

            Debug.Log($"[GameManager] Started Mission: {ActiveMissionId}");
        }

        public void SetPaused(bool isPaused)
        {
            Time.timeScale = isPaused ? 0.0f : 1.0f;
        }

        public void RestartCurrentMission()
        {
            UnityEngine.SceneManagement.SceneManager.LoadScene(
                UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex
            );
        }

        private void Update()
        {
            if (isMissionRunning)
            {
                ElapsedTime += Time.deltaTime;
            }
        }

        public void UpdateContextAction(string action)
        {
            currentContextAction = action;
        }

        public void OnPlayerConcealmentChanged(bool isConcealed)
        {
            if (isConcealed)
            {
                currentContextAction = "exitCabinet";
            }
        }

        public void OnGlobalAlarmRaised(string state)
        {
            if (GlobalAlarmState != "alert")
            {
                AlertsTriggered++;
                GlobalAlarmState = "alert";
            }
        }

        public void OnPlayerDamaged(float amount)
        {
            DamageReceived += Mathf.RoundToInt(amount);
        }

        public void OnGuardNeutralized()
        {
            GuardsNeutralized++;
        }

        public void OnPlayerDefeated()
        {
            isMissionRunning = false;
            string payload = $"{{\"success\":false,\"missionId\":\"{ActiveMissionId}\",\"durationSeconds\":{ElapsedTime:F1},\"alertsTriggered\":{AlertsTriggered},\"guardsNeutralized\":{GuardsNeutralized},\"damageReceived\":{DamageReceived},\"currencyEarned\":0,\"rating\":\"failed\",\"failureReason\":\"Eliminated by security force\"}}";
            UnityMessageDispatcher.SendToFlutter("ON_MISSION_RESULT", payload);
        }

        public void OnPlayerReachedExtraction()
        {
            if (!isMissionRunning) return;
            isMissionRunning = false;

            string rating = AlertsTriggered == 0 ? "ghost" : (AlertsTriggered <= 2 ? "operative" : "compromised");
            int bountyReward = 350;

            string payload = $"{{\"success\":true,\"missionId\":\"{ActiveMissionId}\",\"durationSeconds\":{ElapsedTime:F1},\"alertsTriggered\":{AlertsTriggered},\"guardsNeutralized\":{GuardsNeutralized},\"damageReceived\":{DamageReceived},\"currencyEarned\":{bountyReward},\"rating\":\"{rating}\",\"failureReason\":\"\"}}";
            UnityMessageDispatcher.SendToFlutter("ON_MISSION_RESULT", payload);
        }

        /// <summary>
        /// Sends regular 10Hz telemetry updates to Flutter HUD overlay.
        /// </summary>
        private IEnumerator BroadcastHudRoutine()
        {
            while (true)
            {
                yield return new WaitForSeconds(0.1f);

                PlayerController player = PlayerController.Instance;
                float hp = player != null ? player.CurrentHealth : 100f;
                float maxHp = player != null ? player.MaxHealth : 100f;
                bool isHidden = player != null && player.IsHidden;

                // Max detection meter among active guards
                float maxDetection = 0f;
                GuardPerception[] guards = FindObjectsOfType<GuardPerception>();
                foreach (var g in guards)
                {
                    if (g.DetectionMeter > maxDetection) maxDetection = g.DetectionMeter;
                }

                string hudJson = $"{{\"currentHealth\":{hp},\"maxHealth\":{maxHp},\"detectionMeter\":{maxDetection:F2},\"alarmState\":\"{GlobalAlarmState}\",\"contextAction\":\"{currentContextAction}\",\"isPlayerHidden\":{(isHidden ? "true" : "false")}}}";
                UnityMessageDispatcher.SendToFlutter("ON_HUD_UPDATE", hudJson);
            }
        }
    }
}
