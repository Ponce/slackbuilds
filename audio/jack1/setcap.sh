# set realtime capabilities on all these binaries
if [ -x /sbin/setcap ]; then
  for i in alsa_in alsa_out jack_alias jack_bufsize jack_connect \
           jack_evmon jack_freewheel jack_impulse_grabber \
           jack_iodelay jack_latent_client jack_load jack_load_test \
           jack_lsp jack_metro jack_midi_dump jack_midiseq jack_midisine \
           jack_monitor_client jack_netsource jack_property jack_rec \
           jack_samplerate jack_server_control \
           jack_showtime jack_simple_client \
           jack_transport jack_transport_client jack_unload jack_wait jackd
  do
    /sbin/setcap cap_ipc_lock,cap_sys_nice=ep usr/bin/$i
  done
fi
