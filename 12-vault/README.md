# Hashicorp Vault

### Starting the server
```bash
vault server -dev -dev-root-token-id="education"
```
Output: 
```bash
WARNING! dev mode is enabled! In this mode, Vault runs entirely in-memory
and starts unsealed with a single unseal key. The root token is already
authenticated to the CLI, so you can immediately begin using Vault.

You may need to set the following environment variables:

PowerShell:
    $env:VAULT_ADDR="http://127.0.0.1:8200"
cmd.exe:
    set VAULT_ADDR=http://127.0.0.1:8200

The unseal key and root token are displayed below in case you want to
seal/unseal the Vault or re-authenticate.

Unseal Key: ********************
Root Token: education

Development mode should NOT be used in production installations!
```

### Getting the saved keys
```bash
vault kv get secret/aws
```