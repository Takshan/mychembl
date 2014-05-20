#!/bin/bash

# This script installs and configures local copy of ChEMBL webservices on
# myChEMBL VM.
# Author: Michal Nowotka, mnowotka@ebi.ac.uk
# Created date: 20.05.2014

# First, install libraries that have to be installed system wide with 
# root priviledges:
#   1. libffi for all python cffi-related stuff (in our case this will help)
#      installing Pillow and cairocffi locally in virtualenv
#   2. xml tools:
#      a) libxml in standard and dev flavours
#      b) the same for libxslt      

sudo apt-get install libffi-dev
sudo apt-get install libxml2 libxml2-dev
sudo apt-get install libxslt1.1 libxslt1-dev

# Install and source virtualenvwrapper because it makes our job lot easier:
sudo pip install virtualenvwrapper
source virtualenvwrapper.sh

# Use the wrapper to create new virtualenv called chembl_webservices
mkvirtualenv chembl_webservices

# Configure our new virtualenv, first install postactivate hooks, which will
# configure our custom PIP index
printf '#!/bin/bash\nexport PIP_CONFIG_FILE={VIRTUAL_ENV}/.pip/pip.conf\n' > ${VIRTUAL_ENV}/bin/postactivate
deactivate
workon chembl_webservices
install -D /dev/null "$PIP_CONFIG_FILE"

# The URL below is not accessible outside EBI network (at least for now).
# But that doesn't really matter since we are configuring our VM once and from
# EBI campus. We need our PIP index only during installation process so this
# is fine.
printf '[global]\nindex-url = http://howe.ebi.ac.uk:8080/repo/index\nextra-index-url = https://pypi.python.org/simple/' > $PIP_CONFIG_FILE

deactivate
workon chembl_webservices

# OK, we are ready to use pip to install chembl_webservices
pip install chembl_webservices

# webservices are DB agnostic so they are not shipped with any specific DB
# driver. We have to install the driver separately, in case of myChEMBL this
# will be postgres:

pip install psycopg2

# OK, now we are ready to configure our webservices django app.
# First, lets create new django project:
mkdir chembl_webservices
cd chembl_webservices/
django-admin.py startproject deployment

# Now we have to download configuration files:
curl %s/%s/%ssettings.py > deployment/deployment/settings.py
curl %s/%s/%surls.py > deployment/deployment/urls.py
curl %s/%s/%swsgi.py > deployment/deployment/wsgi.py
curl %s/%s/%schembl_webservices.inc > deployment/deployment/chembl_webservices.inc

#TODO: download dotfiles


