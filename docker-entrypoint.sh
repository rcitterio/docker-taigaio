#!/bin/bash

python manage.py migrate --noinput
if [ ! -f "$DATA_DIR/initiated" ]; then
    python manage.py loaddata initial_user
    python manage.py loaddata initial_project_templates
    python manage.py loaddata initial_role
    python manage.py compilemessages
    python manage.py collectstatic --noinput
fi

# if celery enabled
circusctl reloadconfig
circusctl restart taiga
circusctl start taiga-celery