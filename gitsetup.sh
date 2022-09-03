
cd /usercode/system
mv conf .gitignore

export GH_TOKEN={{GITHUB_PAT}}
export GITHUB_TOKEN={{GITHUB_PAT}}
export GITHUB_USER={{GITHUB_USERNAME}}

git config --global credential.helper store
git config --global user.email "student@educative.com"
git config --global user.name "Educative Student"
echo "https://{{GITHUB_USERNAME}}:{{GITHUB_PAT}}@github.com" >> ~/.git-credentials

git init
git add .gitignore
git commit -m "Lesson started"
git add .
git commit -m "Remaining lesson files"
git branch -m main

gh repo delete system --confirm
gh repo create system --public -s $(pwd) --push

cd /usercode

flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=flux-infra \
  --branch=main \
  --path=./educative-cluster \
  --personal

git clone https://github.com/$GITHUB_USER/flux-infra

cd /usercode/flux-infra

flux create source git podinfo \
  --url=https://github.com/{{GITHUB_USERNAME}}/system \
  --branch=main \
  --interval=30s \
  --export > ./educative-cluster/podinfo-source.yaml

git add -A && git commit -m "Add podinfo GitRepository"
git push

flux create kustomization podinfo \
  --target-namespace=default \
  --source=podinfo \
  --path="./infrastructure" \
  --prune=true \
  --interval=1m \
  --export > ./educative-cluster/podinfo-kustomization.yaml

git add -A && git commit -m "Add podinfo GitRepository"
git push