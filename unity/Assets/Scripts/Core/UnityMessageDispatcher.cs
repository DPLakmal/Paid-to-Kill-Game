using System;
using UnityEngine;

namespace ShadowContract.Core
{
    /// <summary>
    /// Bridges outbound C# telemetry and events to the hosting Flutter Android activity.
    /// </summary>
    public static class UnityMessageDispatcher
    {
        public static void SendToFlutter(string type, string jsonPayload)
        {
            string message = $"{{\"type\":\"{type}\",\"data\":{jsonPayload}}}";

#if UNITY_ANDROID && !UNITY_EDITOR
            try
            {
                using (AndroidJavaClass unityPlayer = new AndroidJavaClass("com.unity3d.player.UnityPlayer"))
                {
                    using (AndroidJavaObject currentActivity = unityPlayer.GetStatic<AndroidJavaObject>("currentActivity"))
                    {
                        currentActivity.Call("onUnityMessage", message);
                    }
                }
            }
            catch (Exception ex)
            {
                Debug.LogError($"[UnityMessageDispatcher] Failed to send message to Flutter: {ex.Message}");
            }
#else
            // In Unity Editor or standalone test, log for telemetry inspection
            Debug.Log($"[Bridge -> Flutter] {message}");
#endif
        }
    }
}
