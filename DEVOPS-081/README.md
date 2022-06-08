# DEVOPS-081 direnv exercise

## List of files:
### 1. DEVOPS-081/environment1/.envrc
File by direnv that exports custom variables and makes them available to the shell in current directory DEVOPS-081/environment1/.

### 2. DEVOPS-091/environment2/.envrc
File by direnv that exports custom variables and makes them available to the shell in current directory DEVOPS-091/environment2/.

### 3. README.md
this file.

---

## Installation

```bash
sudo apt install direnv
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
exit
```


## Configuration

```bash
mkdir -p devops-081/environment1/ && cd $_
echo export AWS_ACCESS_KEY_ID=env1key > .envrc
echo export AWS_SECRET_ACCESS_KEY=env1secret >> .envrc
direnv allow
```

```bash
mkdir -p DEVOPS-091/environment2/ && cd $_
echo export AWS_ACCESS_KEY_ID=env2key > .envrc
echo export AWS_SECRET_ACCESS_KEY=env2secret >> .envrc
direnv allow
```


## Validation
```console
cd DEVOPS-081/environment1/
direnv: loading ~/WindowsShare/pashkov_dmitriy/DEVOPS-081/environment1/.envrc
direnv: export +AWS_ACCESS_KEY_ID +AWS_SECRET_ACCESS_KEY
dmitriy@ubuntu:~/WindowsShare/pashkov_dmitriy/DEVOPS-081/environment1$ echo $AWS_ACCESS_KEY_ID && echo $AWS_SECRET_ACCESS_KEY
env1key
env1secret
```

```console
cd ../../DEVOPS-091/environment2/
direnv: loading ~/WindowsShare/pashkov_dmitriy/DEVOPS-091/environment2/.envrc
direnv: export +AWS_ACCESS_KEY_ID +AWS_SECRET_ACCESS_KEY
dmitriy@ubuntu:~/WindowsShare/pashkov_dmitriy/DEVOPS-091/environment2$ echo $AWS_ACCESS_KEY_ID && echo $AWS_SECRET_ACCESS_KEY
env2key
env2secret
```