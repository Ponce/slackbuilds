if [ -x /sbin/setcap ]; then
  bin=(
  jackdbus jack_monitor_client jack_latent_client alsa_in
  jack_midi_dump jack_showtime jack_rec jack_zombie jack_midiseq
  jack_thru jack_connect jack_net_slave jack_bufsize jack_wait
  alsa_out jack_freewheel jack_server_control jack_net_master
  jack_evmon jack_metro jack_simple_client jack_lsp jack_cpu
  jack_control jack_netsource jack_test jack_session_notify
  jack_alias jack_iodelay jackd jack_simple_session_client
  jack_midisine jack_unload jack_load jack_samplerate
  jack_midi_latency_test jack_cpu_load jack_multiple_metro)

  for i in ${bin[@]}; do
    /sbin/setcap cap_ipc_lock,cap_sys_nice=ep usr/bin/$i
  done
fi
