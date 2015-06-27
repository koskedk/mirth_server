# mirth_server
Provisioning mirth to run on linux, hosted on mysql database. We use vagrant to spin up the machine, ans shell scripting to provision the machine

# TODO
Provision mysql to do the following:
  - Create a database called mirthdb
  - Create a new user called mirthuser
  - Grant the mirthuser all privileges to the mirthdb
  - Allow mirthuser access to mirthdb from any remote ip address
    - comment out the bind_address section in my.cnf
    - run the following query:
      GRANT ALL PRIVILEGES ON mirthdb.* TO 'mirthuser'@'%' IDENTIFIED BY 'password';

Provision mirth to use the mysql mirthdb
  - Modify the mirth.properties file appropriately
