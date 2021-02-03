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
1. [Env Set Up Part 1: Set up VSCode](https://www.loom.com/share/05cc7da36aa44886ac1e868fb21520da) **Note: I created my environment with `python==3.7.9`*
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
1. set up `profiles.yml`
   1. open [profiles_example.yml](profiles_example.yml)
   2. save it into your user folder in a new directory called `.dbt` and rename it to `profiles.yml`
   3. change the `schema` field to your initials
2. Open Azure Data Studio and to log in to our database
   1. connection info:
      1. server: dbtavatrain.database.windows.net
      2. authentication type: Azure Active Directory
      3. database: sandbox
3. touch db using dbt
   1. open up a new terminal and run
      1. `az login`
      2. `az account set --subscription ff2e23ae-7d7c-4cbd-99b8-116bb94dca6e`
   2. `pip install dbt-sqlserver`
   3. `dbt debug` it should show all green and get no error message!


### Exercises

#### Create tables (dbt run)

Let's make some dbt models! The following steps will show how `dim_customers`, a finished table gets created and transformed from raw data sources. We currently already have some source tables in our database: `raw.customers`, `raw.orders`, and `raw.payments` (view these tables in Azure Data Studio under the Tables folder - try to `Select Top 1000`)
1. We need to create staging tables from the tables listed above. The SQL files that create these tables are located in `models\staging`. Take a quick look at the code to understand the transformations! In the command line, individually run:
   1. `dbt run --model stg_customers`
   2. `dbt run --model stg_orders`
   3. `dbt run --model stg_payments`
   4. Take a look at each of the tables you just created in Azure Data Studio. These can be found under **Views** as `your_schema_name.stg_customers` and so on.
   5. *Optional: take a look at the compiled SQL code for each of these tables in `target\compiled\jaffle_shop\models\staging`*
2. Lets create more tables! Now we will build another layer of intermediary tables built off of the ones we just created in step 1. These tables can be found in `models\marts\core\intermediate`. Again, individually run:
   1. `dbt run --model customer_orders`
   2. `dbt run --model customer_payments`
   3. `dbt run --model order_payments`
   4. Take a look at each of the tables in Azure Data Studio under **Tables**.
   5. *Optional: take a look at the compiled SQL code for each of these tables in `target\compiled\jaffle_shop\models\marts\core\intermediate`*
3. All the tables we created up to now will be used to create `dim_customers`. The SQL code for this table can be found in `models\marts\core` as `dim_customers.sql`.
   1. Run `dbt run --model dim_customers`
   2. Take a look at this table in Azure Data Studio under **Tables**.
4. Congrats! You finished creating the end table `dim_customers` along with its parent tables. It is important to note that there is another end table in this database called `fct_orders` along with its parent tables.
   1. Run `dbt run`. Without the model parameter like in previous examples, this allows **all** the SQL files under the `models` folder to get materialized in SQL Server. Now, `dim_customers` and `fct_orders` are materialized, along with their parent tables.

#### Documentation (dbt docs)
We can document all table and column descriptions. Under the `models` folder, there is a YML file inside each folder with the documentation information. The YML for each models folder are as follows:
* Source tables: `models\source\src_schema.yml`
* Staging tables: `models\staging\stg_schema.yml`
* Intermediate and end tables: `models\marts\core\schema.yml`

When looking at each of them, you will notice that there is field for table description, column description, and column data type. These can be filled out as needed. To visualize the documentation better:
1. Run `dbt docs generate`
2. Run `dbt docs serve` - *Those two commands will take you to a website where you can easily visualize the documentation of each table*
3. From the menu on the left, click on Sources, then shopify_raw, then customers to see the documentation for the raw customers table.
4. Click on some other tables to view documentation for those
5. Click on the teal circle icon on the bottom right to view the DAG dbt generates for us. Click on the full screen icon. At the bottom, delete the entry for the `--select` field and press enter to view the full DAG for the entire database you built. Here you can see the path of each table and understand how each table is related to eachother.

#### Run Tests (dbt test)
After creating tables, we can run tests on them to see if each column is behaving as expected.
1. Open `models\marts\core\schema.yml`
2. Here you can see that there is only one test for `dim_customers` and many tests for `fct_orders`. You can look at a list of all tests that can be applied [here](https://docs.getdbt.com/reference/resource-properties/tests/).
3. Run `dbt test` to see which tests pass or fail. A fail will tell you where in your data you need to start debugging.


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

## 4. how can it help Avanade?