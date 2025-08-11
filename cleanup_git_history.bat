@echo off
REM Download BFG Repo-Cleaner
curl -L -o bfg.jar https://repo1.maven.org/maven2/com/madgag/bfg/1.14.0/bfg-1.14.0.jar

REM Run BFG to delete .terraform folder and Terraform state files from history
java -jar bfg.jar --delete-folders .terraform --no-blob-protection
java -jar bfg.jar --delete-files "*.tfstate"
java -jar bfg.jar --delete-files "*.tfstate.*"
java -jar bfg.jar --delete-files "terraform.tfstate*"

REM Clean and update repository
git reflog expire --expire=now --all
git gc --prune=now --aggressive

REM Force push cleaned history to GitHub
git push --force

echo Cleanup complete. Check your GitHub repo for success.
pause
