{# DROP TABLE raw.customers #}
CREATE TABLE [raw].[customers] (
 [id] [int] NULL,
 [first_name] [varchar](16) NULL,
 [last_name] [varchar](16) NULL,
 [email] [varchar](31) NULL
)
WITH
(
 DISTRIBUTION = ROUND_ROBIN,
 CLUSTERED COLUMNSTORE INDEX
);
COPY INTO raw.customers
FROM 'https://dbtmsftblob.blob.core.windows.net/jaffle-shop/raw_customers.csv'

{# DROP TABLE raw.orders #}
CREATE TABLE [raw].[orders] (
	[id] [int] NULL,
	[user_id] [int] NULL,
	[order_date] [varchar](16) NULL,
	[status] [varchar](16) NULL
)
WITH
(
 DISTRIBUTION = ROUND_ROBIN,
 CLUSTERED COLUMNSTORE INDEX
);
COPY INTO raw.orders
FROM 'https://dbtmsftblob.blob.core.windows.net/jaffle-shop/raw_orders.csv'

{# DROP TABLE raw.payments #}
CREATE TABLE [raw].[payments] (
	[id] [int] NULL,
	[order_id] [int] NULL,
	[payment_method] [varchar](16) NULL,
	[amount] [int] NULL
)
WITH
(
 DISTRIBUTION = ROUND_ROBIN,
 CLUSTERED COLUMNSTORE INDEX
);
COPY INTO raw.payments
FROM 'https://dbtmsftblob.blob.core.windows.net/jaffle-shop/raw_payments.csv'