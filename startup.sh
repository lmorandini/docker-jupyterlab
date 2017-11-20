#!/bin/bash
set -x
# FIXME: this does not work, and the NotebookApp.token does not
# work either, disabling the use of a token instead

#JL_CONFIG=/root/.jupyter/jupyter_notebook_config.py
#passF=`egrep "$c\.NotebookApp\.password" ${JL_CONFIG} | wc -l`

#if [ $passF -lt 2 ]
#then
  #pass=`echo ${JL_PASSWD} | sha1sum | tr -s ' ' | cut -f1 -d\ `; \
#  echo "c.NotebookApp.password = u'sha1:${pass}'" \
#  >> ${JL_CONFIG}
#  echo "c.NotebookApp.password_required = True" \
#  >> ${JL_CONFIG}
#  echo "c.NotebookApp.open_browser = False" \
#  >> ${JL_CONFIG}
#fi

jupyter lab --ip=0.0.0.0 --port=${JL_PORT} --no-browser \
  --notebook-dir=${JL_DATA} --allow-root \
  --NotebookApp.token=${JL_PASSWD}

