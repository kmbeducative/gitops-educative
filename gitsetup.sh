
cd /usercode
mv conf .gitignore
export GH_TOKEN={{GITHUB_PAT}}
git config --global credential.helper store
git config --global user.email "student@educative.com"
git config --global user.name "Educative Student"
echo "https://{{GITHUB_USERNAME}}:{{GITHUB_PAT}}@github.com" >> ~/.gitcredentials
git init
git branch -m main
git add .gitignore
git commit -m "Lesson started"
git add .
git commit -m "Remaining lesson files"

gh repo delete usercode --confirm
gh repo create usercode --public -s $(pwd) --push