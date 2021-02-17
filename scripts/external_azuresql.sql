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
