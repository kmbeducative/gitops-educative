
cd /usercode
mv conf .gitignore
export GITHUB_TOKEN={{GITHUB_PAT}}
export GITHUB_USER={{GITHUB_USERNAME}}
export GH_TOKEN={{GITHUB_PAT}}

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

gh repo delete usercode --confirm
gh repo create usercode --public -s $(pwd) --push

flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=flux-infra \
  --branch=main \
  --path=./clusters/educative-cluster \
  --personal

  git clone https://github.com/$GITHUB_USER/flux-infra