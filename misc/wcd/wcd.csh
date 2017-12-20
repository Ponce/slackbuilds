if ( ${?WCDHOME} ) then
  alias wcd "/usr/bin/wcd \!* ; source $WCDHOME/bin/wcd.go"
else
  alias wcd "/usr/bin/wcd \!* ; source $HOME/bin/wcd.go"
endif

