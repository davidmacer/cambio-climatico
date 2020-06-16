# Efectos de los impactos del cambio climático en las islas de México

```
BRANCH='nombre/rama'
REMOTE='islasgeci'
REPO='cambio-climatico'

rm --force --recursive ${REPO}
git clone https://github.com/${REMOTE}/${REPO}
cd ${REPO}
git checkout ${BRANCH}
docker build --no-cache --tag ${REMOTE}/${REPO}:latest .
docker run --rm --volume ${PWD}:/workdir ${REMOTE}/${REPO}:latest make
```
