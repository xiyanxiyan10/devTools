docker run -d --restart=always --name ldap-account-manager -p 8686:80 \
            --link openldap:ldap-host \
                    --env PHPLDAPADMIN_LDAP_HOSTS=ldap-host \
                            --env PHPLDAPADMIN_HTTPS=false \
                                    --detach ldapaccountmanager/lam



