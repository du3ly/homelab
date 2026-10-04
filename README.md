# Home Infrastructure

## Resources

### Running Ansible

```
uv venv --no-project --python $(cat .python-version)
source .venv/bin/activate
uv pip install -r requirements.txt
ansible-galaxy install -r collections/requirements.yaml
```
