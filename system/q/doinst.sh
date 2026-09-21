grep -q backarrowKey etc/X11/app-defaults/XTerm ||
{
cat >>etc/X11/app-defaults/XTerm <<////
# Next line causes Backspace key to send DEL. Appended for q editor
*backarrowKey:        false
////
}
