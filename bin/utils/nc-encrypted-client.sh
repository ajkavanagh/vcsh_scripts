IP="127.0.0.1"
PORT="8877"
SHARED_SECRET="shared secret"

OPENSSL="/usr/local/opt/libressl/bin/openssl"
OPENSSL_CMD="$OPENSSL enc -a -A -aes-256-gcm"

while IFS= read -r MSG; do
	echo "$MSG" | $OPENSSL_CMD -e -k "$SHARED_SECRET"
	echo
done | \
nc "$IP" "$PORT" | \
while IFS= read -r REC; do
	echo "Server: $(echo "$REC" | $OPENSSL_CMD -d -k "$SHARED_SECRET")"
done
