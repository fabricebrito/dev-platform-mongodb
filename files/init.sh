cd /workspace

code-server --install-extension ms-python.python 

code-server --install-extension ms-toolsai.jupyter

ln -s /workspace/.local/share/code-server/extensions /workspace/extensions

mkdir -p /workspace/User/

echo '{"workbench.colorTheme": "Visual Studio Dark"}' > /workspace/User/settings.json

python -m venv /workspace/.venv

source /workspace/.venv/bin/activate

/workspace/.venv/bin/python -m pip install --no-cache-dir pymongo ipykernel

/workspace/.venv/bin/python -m ipykernel install --user --name coder-env --display-name "Python (coder)"
