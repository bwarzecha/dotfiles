repo=$1
timestamp="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
echo "Syncing $repo.."
cd $repo
git pull -r
git add -A
git commit -m 	"Autosync $timestamp"
git push
