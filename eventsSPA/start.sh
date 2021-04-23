# Code below is taken from Professor Nat Tuck's scratch repository
export MIX_ENV=prod
export PORT=4014
export DATABASE_URL=ecto://"events-spa":"aouf9832o98s"@localhost:5432/events_dev


SECRET=$(readlink -f ~/.config/events)

if [ ! -e "$SECRET/pass" ]; then
	echo "File does not exist"
	exit 1

fi

SECRET_KEY_BASE=$(cat "$SECRET/pass")
export SECRET_KEY_BASE

_build/prod/rel/events/bin/events start
