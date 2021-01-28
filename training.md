# Avanade Training!

Very humbled to have you all here to check out what we've been working on these past few months. Hopefully y'all will think it is as cool and useful as we have!

This is the FIRST official training, so apologies for where the training could be rough around the edges. There are some success stories already in that we now have four people on the team that know dbt (3 of whom are here today to help out and learn more).

## Table of Contents

0. Download & Install Software
1. Environment Set Up (30 min)
2. learn dbt!
3. Anders's spiel


## 0. Download & Install Software


Ahead of the call if you could please download and install the following (if you haven’t already):

- [Anaconda](https://www.anaconda.com/products/individual)
- [Microsoft ODBC Driver 17](https://www.microsoft.com/en-us/download/details.aspx?id=56567)
- [VSCode](https://code.visualstudio.com/Download)
- [Azure Data Studio](https://docs.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio?view=sql-server-ver15)
- [Azure CLI](https://git-scm.com/downloads)

## 1. Environment Set Up

This is the biggest hurdle to using dbt right now. IMHO, it isn't that big. Fishtown Analytics has a web-based IDE tool that you'll see being used in the training course. The advantage is that you can write dbt models and run them in the same window.

Here's a series of videos where I show the environment set up details from the moment you finish downloading and installing the softwaree
1. [Env Set Up Part 1: Set up VSCode](https://www.loom.com/share/05cc7da36aa44886ac1e868fb21520da)
2. [Env Set Up Part 2: connect to the database with dbt in VSCode using Azure CLI](https://www.loom.com/share/bd298e4a87154a1d8ad609d9d2e7ae26)
3. [Env Set Up Part 3: Azure Data Studio & more intro](https://www.loom.com/share/e6055de3c9154d1a93224517c1a7634d)

There may be an issue where your terminal can't find Git or Anaconda, in which case we made need to add to your system environment's PATH variable.

Here we'll be using a version of the same repo that Fishtown uses for their training.



### VSCode

Here's a partial list of steps
0. Open VSCode
   1. Clone [this repo](https://github.com/dbt-msft/jaffle_shop_mssql) in VSCode with the command pallette
      1. (`CTRL + Shift + P`)
      2. type Git: Clone and select the option
      3. Paste the git url: `https://github.com/dbt-msft/jaffle_shop_mssql` and hit enter
      4. Click "Open"
   2. After cloning, you should be prompted to install some extensions -- you should! The extensions are:
      1. `python extension`
      2. `better jinja`
      3. `vscode-dbt`
      4. `rainbow csv`
2. set up `profiles.yml`
   1. open [profiles_example.yml](profiles_example.yml)
   2. save it into your user folder in a new directory called `.dbt` and rename it to `profiles.yml`
   3. change the `schema` field to your initials
1. Open Azure Data Studio and to log in to our database
   1. connection info:
      2. server: dbtavatrain.database.windows.net
      1. database: sandbox
2. touch db using dbt
   1. open up a new terminal and run
      1. `az login`
      2. `az account set --subscription ff2e23ae-7d7c-4cbd-99b8-116bb94dca6e`
   2. 


## 2. Learning dbt from better teachers than Anders

Now you're cut loose to learn from the best. [Here's a video](https://www.loom.com/share/c0e55d1734c849c184b1dd3b7df83f02) of me giving a partial intro to these resources

here's where our special [`dim_customers.sql`](dim_customers.sql) lives (theirs doesn't work on TSQL)

- [Kyle's amazing course](https://courses.getdbt.com)
- [Claire's classic text + video walkthrough](https://docs.getdbt.com/tutorial/setting-up)
- [thorough docs worth going through](https://docs.getdbt.com/docs/building-a-dbt-project/projects)


## 3. dbt+msft better together

- [the dbt viewpoint](https://docs.getdbt.com/docs/about/viewpoint)
- [dbt-utils](https://github.com/fishtown-analytics/dbt-utils)
- production workflow