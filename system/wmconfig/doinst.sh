config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/wmconfig/Applications.new                                             
config etc/wmconfig/Astronomy.new                                                
config etc/wmconfig/Desktop.new                                                  
config etc/wmconfig/Development.new                                              
config etc/wmconfig/Editors.new
config etc/wmconfig/Edutainment.new                                              
config etc/wmconfig/Funcs.new                                                    
config etc/wmconfig/Games.new                                                    
config etc/wmconfig/Graphics.new                                                 
config etc/wmconfig/Graphics_Viewers.new                                         
config etc/wmconfig/Multimedia.new                                               
config etc/wmconfig/Network.new                                                  
config etc/wmconfig/Office.new                                                   
config etc/wmconfig/Office_Viewers.new                                           
config etc/wmconfig/Shells.new                                                   
config etc/wmconfig/System.new                                                   
config etc/wmconfig/Utilities.new
