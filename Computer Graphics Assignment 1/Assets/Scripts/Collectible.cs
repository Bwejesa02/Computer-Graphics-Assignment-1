using UnityEngine;

public class Collectible : MonoBehaviour
{
    void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            // Notify the GameManager before destroying the object
            FindObjectOfType<GameManager>().CollectItem();
            Destroy(gameObject);  // Collect the item
        }
    }
}
