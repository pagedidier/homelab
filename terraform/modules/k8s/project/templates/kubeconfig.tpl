apiVersion: v1
kind: Config
clusters:
- name: ${cluster}
  cluster:
    insecure-skip-tls-verify: true
    server: ${server}
contexts:
- name: default-context
  context:
    cluster: ${cluster}
    namespace: ${namespace}
    user: default-user
current-context: default-context
users:
- name: default-user
  user:
    token: ${token}
