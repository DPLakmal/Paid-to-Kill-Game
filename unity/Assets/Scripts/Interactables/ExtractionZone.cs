using UnityEngine;
using ShadowContract.Player;
using ShadowContract.Core;

namespace ShadowContract.Interactables
{
    /// <summary>
    /// Extraction gate zone that triggers mission success when entered by player (GDD Section 11).
    /// </summary>
    public class ExtractionZone : MonoBehaviour
    {
        private void OnTriggerEnter2D(Collider2D collision)
        {
            PlayerController player = collision.GetComponent<PlayerController>();
            if (player != null)
            {
                GameManager.Instance?.OnPlayerReachedExtraction();
            }
        }
    }
}
