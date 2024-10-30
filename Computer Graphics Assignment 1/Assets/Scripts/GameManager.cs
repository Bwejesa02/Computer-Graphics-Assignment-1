using UnityEngine;
using TMPro;

public class GameManager : MonoBehaviour
{
    public TextMeshProUGUI statusText;
    private int totalCollectibles;

    void Start()
    {
        totalCollectibles = GameObject.FindGameObjectsWithTag("Collectible").Length;
        UpdateStatusText();
    }

    public void CollectItem()
    {
        totalCollectibles--;
        UpdateStatusText();
        if (totalCollectibles <= 0)
        {
            statusText.text = "You Win!";
        }
    }

    void UpdateStatusText()
    {
        statusText.text = "Collectibles Left: " + totalCollectibles;
    }
}
