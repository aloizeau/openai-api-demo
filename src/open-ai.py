import os
import logging
import requests
import azure.functions as func
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient

def get_secret_from_key_vault(key_vault_uri, secret_name):
    credential = DefaultAzureCredential()
    client = SecretClient(vault_url=key_vault_uri, credential=credential)
    secret = client.get_secret(secret_name)
    return secret.value

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')
def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    prompt = req.params.get('prompt')
    if not prompt:
        try:
            req_body = req.get_json()
        except ValueError:
            return func.HttpResponse("Please pass a prompt in the request body", status_code=400)
        prompt = req_body.get('prompt')

    if not prompt:
        return func.HttpResponse("Please pass a prompt in the query string or in the request body", status_code=400)

    # Azure OpenAI settings
    endpoint = os.environ["AZURE_OPENAI_ENDPOINT"]
    deployment_name = os.environ["AZURE_OPENAI_DEPLOYMENT"]
    api_version = os.environ["AZURE_OPENAI_API_VERSION"]
    key_vault_uri = os.environ["KEY_VAULT_URI"]
    secret_key = os.environ["OPEN_AI_SECRET_KEY"]
    api_key = get_secret_from_key_vault(key_vault_uri, secret_key)
    url = f"{endpoint}/openai/deployments/{deployment_name}/completions?api-version={api_version}"
    headers = {
        "api-key": api_key,
        "Content-Type": "application/json"
    }
    data = {
        "prompt": prompt,
        "max_tokens": 100
    }

    response = requests.post(url, headers=headers, json=data)
    if response.status_code != 200:
        return func.HttpResponse(f"OpenAI API error: {response.text}", status_code=500)

    result = response.json()
    return func.HttpResponse(result["choices"][0]["text"], mimetype="text/plain")