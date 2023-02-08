# Summary

Project template for lambda deployable in container image.

# CI/CD Flow

```
# for AWS
codecommit -> codebuild -> docker build && docker push -> ECR -> lambda
                             /
                    id-of-docker-hub@KMS
```

# requirements

* python: `>3.8,<=3.9`
* poetry

# quick start

**VSCode Local Debugging**

```bash
$ cd ${workspaceFolder}
$ mv .dev.env .env
$ poetry install
$ poetry shell 
# and run vscode debug
```

```bash
$ docker compose build
$ docker compose up -d
```

# local debug settings

### vscode

`launch.json`

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Debug",
            "type": "python",
            "request": "launch",
            "console": "integratedTerminal",
            "justMyCode": true,
            "program": "${workspaceFolder}/app.py",
            "args": [],
            "envFile": "${workspaceFolder}/.env.dev",
        }
    ]
}
```

`settings.json`

```json
{
    // workspace settings.json
    "python.linting.flake8Enabled": true,
    "python.linting.flake8Args": [
        "--config=.flake8",
    ],
    "python.linting.enabled": true,
    "python.testing.unittestEnabled": false,
    "python.testing.pytestEnabled": false,
    "python.testing.nosetestsEnabled": false,
    "python.formatting.provider": "autopep8",
    "python.formatting.autopep8Args": [
        "--aggressive",
        "--aggressive",
    ],
    "python.languageServer": "Pylance",
}
```
