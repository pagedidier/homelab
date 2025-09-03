# Charts

In this folder we find all the Helm chart structure for self developed applications.

## Structure
```yaml
.
├── <app_name>
│   ├── Chart.yaml
│   ├── templates
│   │   └── <service>
│   │       ├── <service>-deployment.yml
│   │       ├── <service>-ingress.yml
│   │       └── <service>-service.yml
│   └── values.yaml
```

[More infos on helm charts](https://helm.sh/docs/intro/quickstart/)
