git config --global user.name "Shynur"
git config --global user.email "one.last.kiss@outlook.com"

git add .
git commit -m "not 1st commit"

git config --global http.proxy http://127.0.0.1:1080
git config --global --unset http.proxy
git config --global https.proxy http://127.0.0.1:1080
git config --global --unset https.proxy

git push -u origin main
