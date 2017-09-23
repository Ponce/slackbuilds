set path=( $path /opt/dakota/bin:/opt/dakota/test )
if ( $?LD_LIBRARY_PATH ) then
  setenv LD_LIBRARY_PATH "$LD_LIBRARY_PATH:/opt/dakota/lib:/opt/dakota/bin"
else
  setenv LD_LIBRARY_PATH "/opt/dakota/lib:/opt/dakota/bin"
endif
