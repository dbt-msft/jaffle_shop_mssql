# Avanade Training!

Very humbled to have you all here to check out what we've been working on these past few months. Hopefully y'all will think it is as cool and useful as we have!

This is the FIRST official training, so apologies for where the training could be rough around the edges. There are some success stories already in that we now have four people on the team that know dbt (3 of whom are here today to help out and learn more).

## Table of Contents

0. Download & Install Software
1. Environment Set Up (30 min)
2. Anders's spiel
3. learn dbt!


## 0. Download & Install Software


Ahead of the call if you could please download and install the following (if you haven’t already):

[Anaconda](https://www.anaconda.com/products/individual)
[Microsoft ODBC Driver 17](https://www.microsoft.com/en-us/download/details.aspx?id=56567)
[VSCode](https://code.visualstudio.com/Download)
[Azure Data Studio](https://docs.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio?view=sql-server-ver15)
[Azure CLI](https://git-scm.com/downloads)

## 1. Environment Set Up

This is the biggest hurdle to using dbt right now. IMHO, it isn't that big. Fishtown Analytics has a web-based IDE tool that you'll see being used in the training course. The advantage is that you can write dbt models and run them in the same window.

Here's a video that with how to get started once you've download and installed all the software.

There may be an issue where your terminal can't find Git or Anaconda, in which case we made need to add to your system environment's PATH variable.

Regardless, here's the general steps

### VSCode

Here we'll be using a version of the same repo that Fishtown uses for their training
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
1. Open Azure Data Studio and to log in to our database



## 2. Anders's spiel