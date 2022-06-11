```
ruby -I . vault2git.rb --vault-client-path "C:/Program Files (x86)/SourceGear/VaultPro Client/vault.exe" --host 192.168.1.104 --repo Saminco2016 -u jscott -p "XXXXXXXXXX" $/Z1001-096 C:/Users/jscott/Projects/Vault-to-Git/Vault-to-Git/Z1001-096
```

```
ruby -I . vault2git.rb --vault-client-path "C:/Program Files (x86)/SourceGear/VaultPro Client/vault.exe" --host 192.168.1.104 --repo Saminco2016 -u jscott -p "XXXXXXXXXX" $/Z1008-021 C:/Users/jscott/Projects/Vault-to-Git/Vault-to-Git/Z1008-021
```

```
set VAULT_CLIENT_PATH="C:/Program Files (x86)/SourceGear/VaultPro Client/vault.exe" &
set VAULT_SERVER=192.168.1.104 &
set VAULT_REPOSITORY_NAME=Saminco2016 &
set VAULT_USER=jscott &
set VAULT_PASSWORD=XXXXXXXXXX &
set VAULT_SOURCE=$/Z1001-100-Branches &
set GIT_DESTINATION=C:/Users/jscott/Downloads/Z1001-100-Branches
```

```
"C:/Program Files (x86)/SourceGear/VaultPro Client/vault.exe" setworkingfolder -host 192.168.1.104 -username jscott -password "XXXXXXXXXX" -repository Saminco2016 $/Z1001-100-Branches C:/Users/jscott/Downloads/Z1001-100-Branches
```

```
"C:/Program Files (x86)/SourceGear/VaultPro Client/vault.exe" versionhistory -host 192.168.1.104 -username jscott -password "XXXXXXXXXX" -repository Saminco2016 $/Z1001-096
```

Run on repo after migration to make dates match.
Fixing the committer dates (https://stackoverflow.com/questions/3895453/how-do-i-make-a-git-commit-in-the-past):
If it's the last commit, or a range of commits, then add `git rebase --committer-date-is-author-date <ref>` where `<ref>` is the last commit/branch/tag/... that you don't want to change. It does what it says on the tin. Caveat emptor: obviously doesn't work if it's not the last commits on your branch. –
Amedee Van Gasse
Apr 23, 2021 at 6:49
