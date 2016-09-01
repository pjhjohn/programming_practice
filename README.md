# Setup Apache2 + Rails (Ubuntu 14.04)

### 1. [Add a Sudo User](https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-passenger-and-apache-on-ubuntu-14-04#step-1-—-add-a-sudo-user)
### 2. Install Ruby & Rails using [rbenv](http://rbenv.org/)
>
 Install [Ruby 2.3.1](https://gorails.com/setup/ubuntu/14.04#ruby)
 Install [Rails 4.2.6](https://gorails.com/setup/ubuntu/14.04#rails)

### 3. Install [Apache2](https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-passenger-and-apache-on-ubuntu-14-04#step-4-—-install-apache)

### 4. Install [Passenger](https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-passenger-and-apache-on-ubuntu-14-04#step-5-—-install-passenger)

### 5. Deploy

**
References :
[`Deployment`](https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-passenger-and-apache-on-ubuntu-14-04#step-6-—-deploy)
[`rbenv setting`](https://codepen.io/asommer70/post/installing-ruby-rails-and-passenger-on-ubuntu-an-admin-s-guide)
**

Download SourceCode into `/home/rails`
```
sudo git clone https://github.com/pjhjohn/mrl-pp2015 /home/rails
```

Create VirtualHost File for apache
```
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/rails.conf
```

Set configuration information in `rails.conf`
```
sudo vim /etc/apache2/sites-available/rails.conf
```
```xml
<VirtualHost *:80>
    # ServerInfo
    # ServerName example.com         # optional
    # ServerAlias www.example.com    # optional
    ServerAdmin webmaster@localhost

    # DocumentRoot : public directory of Rails Project
    DocumentRoot /home/rails/public

    # Environment : development or production
    RailsEnv development

    # Directory : Same as DocumentRoot
    <Directory "/home/rails/public">
        Options FollowSymLinks
        Require all granted
    </Directory>

    # Logger
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

Edit `/etc/apache2/mods-available/passenger.conf` since we use `rbenv`
```
<IfModule mod_passenger.c>
    PassengerRoot /usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini
    PassengerDefaultRuby /home/$YOUR_HOME_DIRECTORY/.rbenv/shims/ruby
 </IfModule>
```

Disable default site & enable new site & restart apache2 service
```
sudo a2dissite 000-default
sudo a2ensite rails
sudo service apache2 restart
```

### 6. [Mount Rails Application to sub-uri](https://www.phusionpassenger.com/library/deploy/apache/deploy/ruby/#deploying-an-app-to-a-sub-uri-or-subdirectory)

##### URI Mapping unstable
> Manually added URI prefix `/pp2015` to `redirect_to`, `href`, `action`, etc

---
# Miscellaneous

### Troubleshootings

##### Permissions
> chmod 644 to 755 for

### App Updates
**
Reference : [`rbenv setting`](https://codepen.io/asommer70/post/installing-ruby-rails-and-passenger-on-ubuntu-an-admin-s-guide)
**

From here on out any updates to you app can be handled with a few commands:
```
cd /home/rails
git pull
RAILS_ENV=production bin/rake assets:precompile
sudo service apache2 restart
```
If you make changes to the database you may have to also run the migrations:
```
cd /home/rails
git pull
RAILS_ENV=production bin/rake db:migrate
RAILS_ENV=production bin/rake assets:precompile
sudo service apache2 restart
```

### [Update Regularly](https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-passenger-and-apache-on-ubuntu-14-04#step-7-—-update-regularly)
