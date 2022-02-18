#!/bin/bash
git remote add origin_datahub https://github.com/linkedin/datahub.git
git pull origin_datahub master
git push origin
pip3 install --upgrade acryl-datahub -i http://mnexus001/repository/pypi-pypi/simple --trusted-host mnexus001
