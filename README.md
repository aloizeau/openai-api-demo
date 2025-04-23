<!--
README.md for the openai-api-demo project.
This documentation provides an overview of deploying a custom API leveraging Azure OpenAI, secured with Azure Key Vault, and automated using Terraform.
-->

# openai-api-demo

## Présentation

Ce projet propose une solution clé en main pour déployer une Azure Function exposant une API permettant d'interagir avec un service Azure OpenAI de façon sécurisée. L'ensemble de l'infrastructure est automatisé via Terraform et la sécurité des secrets est assurée par Azure Key Vault.

## Architecture de la solution

```
[Client] 
    |
    v
[Azure Function App] --(App Settings/Secrets)--> [Azure Key Vault]
    |
    v
[Azure OpenAI Service]
```

### 1. Azure Function App

- **Rôle** : Héberge l'API qui reçoit les requêtes des clients et les transmet au service Azure OpenAI.
- **Langage** : (exemple : Python, C#, Node.js)
- **Sécurité** : Accès restreint via Managed Identity pour récupérer les secrets dans Key Vault.

### 2. Azure Key Vault

- **Rôle** : Stocke de façon sécurisée les secrets nécessaires (par exemple, endpoint et clé API d'Azure OpenAI).
- **Accès** : Seule l'Azure Function (via Managed Identity) a le droit de lire les secrets.

### 3. Azure OpenAI Service

- **Rôle** : Fournit les capacités d'IA générative (ex : GPT, embeddings, etc.).
- **Sécurité** : Accessible uniquement via l'API, protégée par une clé stockée dans Key Vault.

### 4. Terraform

- **Rôle** : Automatisation du déploiement de l'ensemble des ressources Azure (Function App, Key Vault, OpenAI, etc.).
- **Avantages** : Reproductibilité, gestion de l'infrastructure as code, versionnement.

## Déploiement étape par étape

1. **Cloner le dépôt**
    ```bash
    git clone https://github.com/aloizeau/openai-api-demo.git
    cd openai-api-demo
    ```

2. **Configurer les variables Terraform**
    - Renseigner les paramètres dans `terraform.tfvars` (nom du resource group, région, etc.).

3. **Déployer l'infrastructure**
    ```bash
    terraform init
    terraform plan
    terraform apply
    ```

4. **Déployer le code de l'Azure Function**
    - Utiliser Azure DevOps, GitHub Actions ou la CLI Azure pour publier le code.

5. **Tester l'API**
    - Récupérer l'URL de la Function App et effectuer une requête HTTP (exemple avec `curl`) :
    ```bash
    curl -X POST https://<votre-function-app>.azurewebsites.net/api/<endpoint> \
      -H "Content-Type: application/json" \
      -d '{"prompt": "Bonjour, peux-tu me donner un exemple d\'utilisation ?"}'
    ```
    > Remplacez `<votre-function-app>` et `<endpoint>` par les valeurs appropriées.

## Sécurité

- **Managed Identity** : L'Azure Function utilise une identité managée pour accéder à Key Vault sans stocker de secrets dans le code.
- **Key Vault** : Les secrets (clé API OpenAI, endpoints) ne sont jamais exposés en clair.
- **Réseau** : Possibilité de restreindre l'accès à la Function App et au Key Vault via des règles réseau.

## Composants utilisés

| Composant             | Description                                         |
|-----------------------|-----------------------------------------------------|
| Azure Function App    | Héberge l'API serverless                            |
| Azure Key Vault       | Stocke les secrets de façon sécurisée               |
| Azure OpenAI Service  | Fournit les capacités d'IA générative               |
| Terraform             | Automatisation du déploiement de l'infrastructure   |
| Managed Identity      | Authentification sécurisée entre services Azure      |

## Exemple de flux de requête

1. Le client envoie une requête à l'API (Azure Function).
2. L'Azure Function récupère la clé API OpenAI depuis Key Vault.
3. L'Azure Function transmet la requête au service Azure OpenAI.
4. La réponse est renvoyée au client.

## Aller plus loin

- Ajouter des contrôles d'accès (API Management, Authentification).
- Monitorer les logs et métriques via Azure Monitor.
- Gérer le cycle de vie des secrets avec Key Vault.

---

Pour plus de détails, consultez la documentation officielle Azure sur [Azure Functions](https://docs.microsoft.com/azure/azure-functions/), [Azure Key Vault](https://docs.microsoft.com/azure/key-vault/), [Azure OpenAI](https://learn.microsoft.com/azure/cognitive-services/openai/) et [Terraform](https://learn.microsoft.com/azure/developer/terraform/).
