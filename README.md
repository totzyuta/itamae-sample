# Itamae Recipes for Nice Rails Environment

## Target

CentOS 6.7

## Environment

* Ruby (rbenv)
  * 2.3.0 (default): it can be added and modified by `nodes/node.yml`.
* PostgreSQL
  * 9.2 (default): it can be changed by 'nodes/node.yml'
  * There are default `pg_hba.conf` and `postgresql.conf` in `remote_files`
  * User name and password can be specified by `notes/node.yml`
* Nginx
  * User is changed for EC2.
  * Conf file would be overwrriten by `remote_files/nginx.conf`.
  * nginx is configured for using **Unicorn**.
* Redis

## How to

1. Clone this repo.

```
$ git clone https://github.com/totzyuta/rails-itamae-recipes.git
```

2. Run Itamae.

__e.g.__

```
$ itamae ssh -h my_host -u ec2-user -j nodes/node.json recipes/base.rb
```

# Note

* Nginx look at `/var/www/app/*` for Rails App.
* Each daemon starts automatically when run Itamae recipes.
* Currently spec file is just for Ruby build. (todo!)
* Add the file name in `recipes/base.rb` when you add a new recipe. (I thought its like ActiveRecord-like architecture and cool ya?)
