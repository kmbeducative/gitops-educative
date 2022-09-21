
cd /usercode/system
mv conf .gitignore
mv helpers.tpl _helpers.tpl

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