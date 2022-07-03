git config --global credential.helper store
echo "https://{{GITHUB_USERNAME}}:{{GITHUB_PAT}}@github.com" >> .gitcredentials
git clone {{GITHUB_REPO}}
