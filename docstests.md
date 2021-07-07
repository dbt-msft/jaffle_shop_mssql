# Bonus! Documentation and Tests

## Documentation

We can document all table and column descriptions. Under the `models` folder, there is a YML file inside each folder with the documentation information. The files are as follows:

* Staging tables: `models\staging\schema.yml`
* Mart tables: `models\schema.yml`

When looking at each of them, you will notice that there are fields for table description, column description, and column data type. These can be filled out as needed. To visualize the documentation better:

1. Run `dbt docs generate`
2. Run `dbt docs serve`
   * Those two commands will take you to a website where you can easily visualize the documentation of each table.
3. From the menu on the left under Projects, you'll notice the parent folder "jaffle_shop" and two folders within it: "data" and "models". "data" contains the raw CSV files and "models" contain the staging and mart tables.
4. Click on some of those tables to view documentation for those.
5. Click on the teal circle icon on the bottom right to view the DAG that dbt generates for us. Click on the full screen icon. At the bottom, delete the entry for the `--select` field and press enter to view the full DAG for the entire database you built. Here you can see the path of each table and understand how each table is related to eachother.

## Testing

After creating tables, we can run tests on them to see if each column is behaving as expected.

1. Open any of the `schema.yml` files. You'll notice they have a field called `tests` for each column which dictates which test you want to run for that column. You can look at a list of all tests that can be applied [here](https://docs.getdbt.com/reference/resource-properties/tests/).
   * Some tests to note from the file are
      1. `unique`: this test passes when there are no duplicates in the column
      2. `not_null`: this test passes when there are no null values in the column
      3. `relationships`: this test passes when all records in a child table have a corresponding record in a parent table.
3. Run `dbt test` to see which tests pass or fail. A fail will tell you where in your data you need to start debugging.