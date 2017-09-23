export PATH=$PATH:/opt/dakota/bin:/opt/dakota/test
if [ -z "$LD_LIBRARY_PATH" ]; then
  export LD_LIBRARY_PATH="/opt/dakota/lib:/opt/dakota/bin"
else
  export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/dakota/lib:/opt/dakota/bin"
fi
