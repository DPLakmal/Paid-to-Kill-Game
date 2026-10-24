using System;
using UnityEngine;
using ShadowContract.Player;

namespace ShadowContract.Core
{
    [Serializable]
    public class InboundBridgeEnvelope
    {
        public string type;
        public string data; // Raw nested data or JSON string
    }

    [Serializable]
    public class StartMissionData
    {
        public string missionId;
        public float movementSpeedMultiplier = 1.0f;
        public float noiseRadiusMultiplier = 1.0f;
        public float maxHealth = 100.0f;
        public float takedownReachMultiplier = 1.0f;
        public float cabinetSpeedMultiplier = 1.0f;
        public bool enableDebugOverlays = false;
    }

    [Serializable]
    public class PauseData
    {
        public bool isPaused;
    }

    [Serializable]
    public class ContextActionData
    {
        public string action;
    }

    /// <summary>
    /// Persistent GameObject component receiving MethodChannel invocations from Flutter.
    /// Named 'FlutterBridgeReceiver' to match the MethodChannel target.
    /// </summary>
    public class FlutterBridgeReceiver : MonoBehaviour
    {
        public static FlutterBridgeReceiver Instance { get; private set; }

        private void Awake()
        {
            if (Instance != null && Instance != this)
            {
                Destroy(gameObject);
                return;
            }
            Instance = this;
            DontDestroyOnLoad(gameObject);
        }

        private void Start()
        {
            // Signal Flutter host that Unity engine runtime is ready
            UnityMessageDispatcher.SendToFlutter("ON_GAME_READY", "{\"status\":\"ready\"}");
        }

        /// <summary>
        /// Entry point invoked via UnitySendMessage("FlutterBridgeReceiver", "OnReceiveMessageFromFlutter", payload)
        /// </summary>
        public void OnReceiveMessageFromFlutter(string messageJson)
        {
            Debug.Log($"[Flutter -> Unity] Received: {messageJson}");

            try
            {
                InboundBridgeEnvelope envelope = JsonUtility.FromJson<InboundBridgeEnvelope>(messageJson);
                switch (envelope.type)
                {
                    case "START_MISSION":
                        StartMissionData startData = JsonUtility.FromJson<StartMissionData>(messageJson.Substring(messageJson.IndexOf("\"data\":") + 7).TrimEnd('}'));
                        GameManager.Instance?.StartMission(startData);
                        break;

                    case "SET_PAUSED":
                        PauseData pauseData = JsonUtility.FromJson<PauseData>(messageJson.Substring(messageJson.IndexOf("\"data\":") + 7).TrimEnd('}'));
                        GameManager.Instance?.SetPaused(pauseData.isPaused);
                        break;

                    case "RESTART_MISSION":
                        GameManager.Instance?.RestartCurrentMission();
                        break;

                    case "TRIGGER_ACTION":
                        ContextActionData actionData = JsonUtility.FromJson<ContextActionData>(messageJson.Substring(messageJson.IndexOf("\"data\":") + 7).TrimEnd('}'));
                        PlayerController.Instance?.TriggerContextAction(actionData.action);
                        break;

                    default:
                        Debug.LogWarning($"[FlutterBridgeReceiver] Unhandled command type: {envelope.type}");
                        break;
                }
            }
            catch (Exception ex)
            {
                Debug.LogError($"[FlutterBridgeReceiver] Failed to process message '{messageJson}': {ex.Message}");
            }
        }
    }
}
