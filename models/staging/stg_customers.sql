with source as (

    select * from {{ source('shopify_raw', 'customers') }}

),

renamed as (

    select
        id as customer_id,
        first_name,
        last_name,
        email

    from source

)

select * from renamed
