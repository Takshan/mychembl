#!/bin/bash

wget https://bootstrap.pypa.io/get-pip.py
sudo -H python get-pip.py

sudo -H pip install pyopenssl 
sudo -H pip install ndg-httpsclient 
sudo -H pip install pyasn1
sudo -H pip install lxml
sudo -H pip install supervisor --pre
sudo -H pip install Pillow
sudo -H pip install numpy
sudo -H pip install scipy
sudo -H pip install matplotlib
sudo -H pip install networkx
sudo -H pip install "ipython[notebook]"
sudo -H pip install biopython
sudo -H pip install -U scikit-learn==0.14.1
sudo -H pip install -U chembl_migration_model
sudo -H pip install -U chembl_webresource_client
echo "numpy==1.8.2" | cat > /tmp/pandas.requirement.txt
sudo -H pip install -U pandas -r /tmp/pandas.requirement.txt
sudo -H pip install -U mpld3
sudo -H pip install -U service_identity
sudo -H pip install https://garage.maemo.org/frs/download.php/8363/python-brisa_0.10.3maemo0.tar.gz
sudo -H pip install -U paste
sudo -H pip install -U netifaces
sudo -H pip install virtualenv
sudo -H pip install virtualenvwrapper
python -c "import mpld3; mpld3.utils.write_ipynb_local_js()"

