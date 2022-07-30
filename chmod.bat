git update-index --chmod=+x .\rootfs\usr\local\bin\docker_entrypoint.sh
git ls-files --stage
git commit -m "chmod +x"
