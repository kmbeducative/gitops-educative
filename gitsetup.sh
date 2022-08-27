
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

gh repo delete flux-infra --confirm

flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=flux-infra \
  --branch=main \
  --path=./educative-cluster \
  --personal

git clone https://github.com/$GITHUB_USER/flux-infra

cd /usercode/flux-infra

flux create source git example-source \
  --url=https://github.com/$GITHUB_USER/system \
  --branch=main \
  --interval=30s \
  --namespace=flux-system \
  --export > ./educative-cluster/python-sample-source.yaml

git add .
git commit -m "Adding the GitRepository"
git push