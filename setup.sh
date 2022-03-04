
set -e

cd $(dirname "$0")

[ -z "$MSYSTEM" ] && pip3 install -e . || export PYTHONPATH="$(pwd)"

if [ -z "$CI" ]; then
  export PATH="$PATH:$(pwd)/bin"
  exit 0
fi

echo "$(pwd)/bin" >> $GITHUB_PATH

unset _arch
case $1 in
  arm32v7) _arch="arm";;
  arm64v8) _arch="aarch64";;
  ppc64le|s390x|riscv64) _arch="$1";;
esac
if [ -n "$_arch" ]; then
  docker run --rm --privileged aptman/qus -s -- -p $_arch
fi