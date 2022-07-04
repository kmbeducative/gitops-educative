
cd /usercode
export GH_TOKEN={{GITHUB_PAT}}
git config --global credential.helper store
git config --global user.email "student@educative.com"
git config --global user.name "Educative Student"
echo "https://{{GITHUB_USERNAME}}:{{GITHUB_PAT}}@github.com" >> .gitcredentials
git init
git branch -m main
git add .
git commit -m "Lesson started"
gh repo delete usercode
gh repo create usercode --public -s $(pwd) --push