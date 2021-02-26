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
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)


## 1. Environment Set Up

This is the biggest hurdle to using dbt right now. IMHO, it isn't that big. Fishtown Analytics has a web-based IDE tool that you'll see being used in the training course. The advantage is that you can write dbt models and run them in the same window.

Here's a series of videos where I show the environment set up details from the moment you finish downloading and installing the softwaree
1. [Env Set Up Part 1: Set up VSCode](https://www.loom.com/share/05cc7da36aa44886ac1e868fb21520da) **Note: I created my environment with `python==3.7.9`*
2. [Env Set Up Part 2: connect to the database with dbt in VSCode using Azure CLI](https://www.loom.com/share/bd298e4a87154a1d8ad609d9d2e7ae26)
3. [Env Set Up Part 3: Azure Data Studio & more intro](https://www.loom.com/share/e6055de3c9154d1a93224517c1a7634d)

There may be an issue where your terminal can't find Git or Anaconda, in which case we made need to add to your system environment's PATH variable.

Here we'll be using a version of the same repo that Fishtown uses for their training.

### VSCode

1. Clone [this repo](https://github.com/dbt-msft/jaffle_shop_mssql) in VSCode
   1. Open VSCode and type (`CTRL + Shift + P`) to access the command palette located at the top.
   2. Type `git: clone` and select the option.
   3. Paste the git URL: `https://github.com/dbt-msft/jaffle_shop_mssql` and hit enter.
   4. Choose which folder you want your code to go in and click "Select Repository Location".
   6. A pop up message should appear on the lower right of VSCode asking if you would like to open the cloned repository. Click "Open".
2. After cloning, you should be prompted to install some extensions -- you should! The extensions are:
   * `python extension`
   * `better jinja`
   * `vscode-dbt`
   * `rainbow csv`
3. Now we need to set up `profiles.yml` to connect to our database. In our repo, this is called [`profiles_example.yml`](profiles_example.yml).
   1. Create new directory called `.dbt` under your user folder (`C:\Users\your_user_folder`).
   2. Open `profiles_example.yml`.
   3. Save As the file into the `.dbt` directory you just made and rename it to `profiles.yml`.
   4. Edit the file in VSCode and change the `schema` field on line 5 to your initials or anything that serves as an identifier for your work.
4. Create your conda environment and install the necessary packages in here **once** so that you can reuse this environment for future dbt work.
   1. Open a new terminal by clicking on "Terminal" at the top and "New Terminal"
   2. Click "Allow" when a pop up appears asking if you allow the workspace to modify your terminal shell.
      * If you see "PS" next to your current directory on the command line, that means you're using powershell and we don't want to use that. The fix: open a new terminal again and you should now be using cmd.
   3. Since you already installed Anaconda, you should see `conda activate base` run automatically and (base) should be next to your current directory.
   4. Create a new, empty environment by running `conda create -n dbtenv python=3.7.9`. The name of your environment is `dbtenv` and we are using Python version 3.7.9.
   5. Install packages
      1. Run `pip install dbt-sqlserver`
      2. Run `pip install azure-cli`
5. Log into Azure. We want to connect to the database via Azure CLI.
   1. Run `az login`
   2. In the window that popped up, sign in with your Avanade credentials. Once signed, in you can close out of that window.
   3. If you belong to multiple subscriptions, you must specify the subscription by running `az account set --subscription ff2e23ae-7d7c-4cbd-99b8-116bb94dca6e`. This is the ID for AzureCloud.
6. Let's verify that we can connect to the database successfully.
   1. Run `dbt debug`. This command tries to connect to the database using the parameters from `profiles.yml` and `dbt_project.yml`.
      * You connected successfully if you see all green and no error messages!

### Azure Data Studio

1. Last step in the set-up is to log in to the database
   1. Open Azure Data Studio and click on the first icon on the left side panel called "Connections".
   2. Click "Add Connection" and paste in the connection info below in the relevant fields. This info can also be found in `profiles.yml`
      * Server: dbtavatrain.database.windows.net
      * Authentication type: Azure Active Directory
      * Account: Click the drop down menu, then "Add an account" and sign in like before
      * Azure AD tenant: Avanade
      * Database: Manually type "sandbox"
   3. Click Connect
      1. You are now connected to the database! 
         * Please note that there may be many tables in the database already. These are other people's tables that they created using their schema name. Yours will start to show up as you start creating your dbt models.
2. Now you are ready to start the exercises in the next section below! 
   * If you are not familiar with Azure Data Studio, here are some pro tips that might be useful when going through the exercises:
      1. The server you are connected to and the **Tables** and **Views** folders are located on the left side of the page
         1. To quickly query a table or view: Go into the relevant folder, right click the name, and click "Select Top 1000".
         2. To write a new query, right click the server, and click "New Query"
      3. If you're wondering why you're not seeing your tables/views show up after running dbt commands in VSCode, you can right click on the **Tables** or **Views** folder and click "Refresh".
         * You can also do this to the server itself as well, but this might take longer.


## 2. Learning dbt

Try the walk-through tutorial of using dbt below. There are also additional resources found at the end of this section as well. Happy modeling!

### Prerequisites:

1. Create an Azure SQL database. Go through the steps listed [here](https://docs.microsoft.com/en-us/azure/azure-sql/database/single-database-create-quickstart?tabs=azure-portal). We recommend using Portal to create.
      * Note: we will be creating our own data source with pre-populated tables so select None for the "Use existing data" section (Step 14 for Portal instructions).
      * Caveats:
         * If you choose the General Purpose option, you can choose between provisioned and serverless compute tiers. Expect this [connectivity limitation](https://docs.microsoft.com/en-us/azure/azure-sql/database/serverless-tier-overview#connectivity) when choosing serverless.
         * If you pick less than the standard tier database, you will have to edit [dbt_project.yml](dbt_project.yml) and change the as_columnstore field on line 23 to "false" like below. For more information on tier comparisons click [here](https://docs.microsoft.com/en-us/azure/azure-sql/database/service-tiers-general-purpose-business-critical#service-tier-comparison).
         ```yml
         models:
         jaffle_shop:
               +as_columnstore: false
         ```
2. Authenticate to the database with Azure Active Directory
   1. In Portal, navigate to the SQL server you created your database in.
   2. On the left side panel, click on "Active Directory admin".
   3. Click "Set admin", then select your email that you created your Azure credentials with.

### Tutorial

#### 0. Connect to External Data Source
Before we jump in and start creating dbt models, we need to locate our source tables. If you are making your own database, then you need to create an external data source and materialize the raw tables from the external data source. These are named `raw.customers`, `raw.orders`, and `raw.payments`. Follow the instructions below to connect to our blob storage called `JaffleShopBlob` and pull the data from there. Otherwise, if you already see the source tables under **Tables** in Azure Data Studio, skip this section and go to the next section.

1. Open Azure Data Studio and create a "New Query" by right clicking on the server name and choosing the option.
2. Paste the Azure SQL code below into the new query and click "Run" at the top. To view the Synapse version of the code click [here](scripts/external_synapse.sql).

```sql
CREATE EXTERNAL DATA SOURCE JaffleShopBlob
WITH (
   TYPE = BLOB_STORAGE,
   LOCATION = 'https://dbtmsftblob.blob.core.windows.net'
);


go
SELECT *
INTO raw.customers
FROM OPENROWSET(
   BULK  'jaffle-shop/raw_customers.csv',
   DATA_SOURCE = 'JaffleShopBlob',
   FORMAT ='CSV',
   FORMATFILE = 'jaffle-shop/raw_customer.xml',
   FORMATFILE_DATA_SOURCE = 'JaffleShopBlob'
) as temp
go
SELECT *
INTO raw.orders
FROM OPENROWSET(
   BULK  'jaffle-shop/raw_orders.csv',
   DATA_SOURCE = 'JaffleShopBlob',
   FORMAT ='CSV',
   FORMATFILE = 'jaffle-shop/raw_orders.xml',
   FORMATFILE_DATA_SOURCE = 'JaffleShopBlob'
) as temp
go
SELECT *
INTO raw.payments
FROM OPENROWSET(
   BULK  'jaffle-shop/raw_payments.csv',
   DATA_SOURCE = 'JaffleShopBlob',
   FORMAT ='CSV',
   FORMATFILE = 'jaffle-shop/raw_payments.xml',
   FORMATFILE_DATA_SOURCE = 'JaffleShopBlob'
) as temp
go
```

#### 1. Create tables

Let's make some dbt models! The following steps will show how `dim_customers`, an end table, gets created and transformed from raw data sources. From the previous step, we currently have the following tables in our database: `raw.customers`, `raw.orders`, and `raw.payments` (try viewing these tables in Azure Data Studio).

1. We need to create staging tables from the tables listed above. The SQL files that create these tables are located in `models\staging`. Take a quick look at each of the files to understand the transformations. In the command line, individually run:
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
   3. *Note: If you're wondering what dictates whether a dbt model gets turned into a table or view, check out `dbt_project.yml`. You can see on lines 21-27 that we can choose which which SQL files will get materialized to a table or view at the model level. In our case, we set all the files in the `staging` folder to be views, and the rest tables.*
4. Congrats! You finished creating the end table, `dim_customers`, along with its parent tables. It is important to note that there is another end table in this database called `fct_orders` along with its parent tables.
   1. Run `dbt run`. Without the model parameter like in previous examples, this allows **all** the SQL files under the `models` folder to get materialized in SQL Server. Now, `dim_customers` and `fct_orders` are materialized, along with their parent tables.

#### 2. Documentation

We can document all table and column descriptions. Under the `models` folder, there is a YML file inside each folder with the documentation information. The files are as follows:

* Source tables: `models\source\src_schema.yml`
* Staging tables: `models\staging\stg_schema.yml`
* Intermediate and end tables: `models\marts\core\schema.yml`

When looking at each of them, you will notice that there are fields for table description, column description, and column data type. These can be filled out as needed. To visualize the documentation better:

1. Run `dbt docs generate`
2. Run `dbt docs serve`
   * Those two commands will take you to a website where you can easily visualize the documentation of each table.
3. From the menu on the left, click on "Sources", then "shopify_raw", then "customers" to see the documentation for the raw customers table.
4. Click on some other tables to view documentation for those.
5. Click on the teal circle icon on the bottom right to view the DAG that dbt generates for us. Click on the full screen icon. At the bottom, delete the entry for the `--select` field and press enter to view the full DAG for the entire database you built. Here you can see the path of each table and understand how each table is related to eachother.

#### 3. Run Tests on Columns

After creating tables, we can run tests on them to see if each column is behaving as expected.

1. Open `models\marts\core\schema.yml`
2. Here you can see that there is only one test for `dim_customers` and many tests for `fct_orders`. You can look at a list of all tests that can be applied [here](https://docs.getdbt.com/reference/resource-properties/tests/).
   * Some tests to note from the file are
      1. `unique`: this test passes when there are no duplicates in the column
      2. `not_null`: this test passes when there are no null values in the column
      3. `relationships`: this test passes when all records in a child table have a corresponding record in a parent table.
3. Run `dbt test` to see which tests pass or fail. A fail will tell you where in your data you need to start debugging.

### Additional Resources

- [Claire's classic text + video walkthrough](https://docs.getdbt.com/tutorial/setting-up) - check this out if you want to learn how to set up and deploy a dbt project using BigQuery (flip through the modules under "Getting Started" on the left)
- [Kyle's amazing course](https://courses.getdbt.com) - this course shows you how to use dbt cloud and goes over some fundamental concepts around dbt
- [thorough docs worth going through](https://docs.getdbt.com/docs/building-a-dbt-project/projects) - these are great overviews about modeling, testing, documentation, sources, and other additional topics we did not cover (flip through the topics under "Building a dbt Project" on the left)


## 3. dbt+msft better together

- [the dbt viewpoint](https://docs.getdbt.com/docs/about/viewpoint)
- [dbt-utils](https://github.com/fishtown-analytics/dbt-utils)
- production workflow
