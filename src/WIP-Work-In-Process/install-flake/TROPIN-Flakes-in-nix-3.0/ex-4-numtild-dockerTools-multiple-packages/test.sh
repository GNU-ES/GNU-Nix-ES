
# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


hello --version
echo 'Test figlet' | figlet


hello | figlet
