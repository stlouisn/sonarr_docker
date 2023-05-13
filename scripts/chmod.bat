@echo off
echo;
echo;

git update-index --chmod=+x ..\rootfs\usr\local\bin\docker_entrypoint.sh
REM git update-index --chmod=+x ..\rootfs\usr\local\bin\docker_healthcheck.sh
git ls-files --stage
git commit -m "chmod +x"
pause
