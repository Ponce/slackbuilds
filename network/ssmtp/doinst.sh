if [ ! -e /usr/sbin/sendmail ];then
	ln -s ssmtp /usr/sbin/sendmail
else
	echo '/usr/sbin/sendmail already exists!'
fi
