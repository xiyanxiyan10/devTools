docker run -p 389:389 --name openldap --restart=always --env LDAP_ORGANISATION="sotemalltest" --env LDAP_DOMAIN="sotemalltest.com" --env LDAP_ADMIN_PASSWORD="redhat" --detach osixia/openldap
