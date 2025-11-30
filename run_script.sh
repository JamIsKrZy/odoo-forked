

if [ -z "$(docker ps -q -f name=^postgres$)" ]; then
    echo "Postgres docker contianer is not running!"
    echo "Running docker compose...!"
    docker compose up -d
fi

until nc -z 127.0.0.1 5432; do
    echo "PostgreSQL is still starting..."
    sleep 1
done


if nc -z 127.0.0.1 8069 2>/dev/null; then
    echo "Odoo is running."
else
    echo "Odoo is NOT running."
    echo "Running odoo..."
    ./odoo-bin \
       -d rd-demo \
       --addons-path="addons/,../odoo-tut-learn"\
       --db_host=127.0.0.1\
       --db_port=5432\
       --db_user=admin\
       --db_password=admin
fi
