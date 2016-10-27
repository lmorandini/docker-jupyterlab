install.packages(c('repr', 'IRdisplay', 'crayon', 'pbdZMQ', 'devtools'), repos='https://cran.ms.unimelb.edu.au') 
devtools::install_github('IRkernel/IRkernel')  
IRkernel::installspec(name = 'ir33', displayname = 'R 3.3')

