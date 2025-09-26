@echo off
cd /d "G:\java"
git add .
git commit -m "笔记更新 %date%"
git push
pause