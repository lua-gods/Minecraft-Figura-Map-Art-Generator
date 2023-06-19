@echo
rd ".\.vscode\" /q /s
::del ".\.luarc.json"
del ".\avatar.code-workspace" /q /s
git clone https://github.com/GrandpaScout/FiguraRewriteVSDocs/
move ".\FiguraRewriteVSDocs\src\avatar.code-workspace" ".\"
::Move fresh luarc if one dosent exist yet
if not exist ".\.luarc.json" (move ".\FiguraRewriteVSDocs\src\.luarc.json" ".\")
move ".\FiguraRewriteVSDocs\src\.vscode" ".\"
rd ".\FiguraRewriteVSDocs\" /q /s