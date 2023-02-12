git config --global user.name 'Shynur'
git config --global user.email 'one.last.kiss@outlook.com'
git add .
git commit -m "ordinary commit"
git config --global --unset http.proxy
git config --global --unset https.proxy
git push -u origin main
