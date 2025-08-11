# Download BFG Repo-Cleaner
Invoke-WebRequest -Uri "https://repo1.maven.org/maven2/com/madgag/bfg/1.14.0/bfg-1.14.0.jar" -OutFile "bfg.jar"

# Run BFG to delete .terraform from history
java -jar .\bfg.jar --delete-folders .terraform --no-blob-protection

# Clean and update repository
git reflog expire --expire=now --all
git gc --prune=now --aggressive

# Force push cleaned history to GitHub
git push --force

Write-Host "Cleanup complete. Check your GitHub repo for success."