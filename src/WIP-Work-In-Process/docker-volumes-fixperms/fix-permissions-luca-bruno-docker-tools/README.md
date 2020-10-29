#


[ ] find a way to be [DRY](TODO: add a link here) in the user of:
    [ ] /code used in WorkingDir, Volumes
    [ ] app_user and app_group 
    [ ] the entrypoint file name
    

What are the differences in doing it in the entrypoint or in the runAsRoot?
groupadd --gid 5000 app_group
useradd --no-log-init --uid 5000 --gid app_group app_user
