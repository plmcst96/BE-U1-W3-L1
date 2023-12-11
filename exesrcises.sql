------------------> CREAZIONE TABELLE <------------------------

CREATE TABLE public.client (
    number_client integer NOT NULL,
    first_name character varying(25) COLLATE pg_catalog."default" NOT NULL,
    last_name character varying(25) COLLATE pg_catalog."default" NOT NULL,
    year_birth integer NOT NULL,
    region_residence character varying(15) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT client_pkey PRIMARY KEY (number_client)
);

CREATE TABLE public.invoices (
    number_invoice integer NOT NULL,
    tipology character varying(15) COLLATE pg_catalog."default" NOT NULL,
    amount integer NOT NULL,
    iva integer NOT NULL DEFAULT 22,
    id_client integer NOT NULL,
    date_invoce date NOT NULL,
    number_supplier integer NOT NULL,
    CONSTRAINT invoices_pkey PRIMARY KEY (number_invoice)
);


CREATE TABLE public.products (
    id_products integer NOT NULL,
    descriptio character varying(100) COLLATE pg_catalog."default" NOT NULL,
    in_production boolean NOT NULL,
    in_market boolean NOT NULL,
    date_start date NOT NULL,
    date_end date NOT NULL,
    CONSTRAINT products_pkey PRIMARY KEY (id_products)
);

CREATE TABLE public.provider (
    num_provider integer NOT NULL,
    designation text COLLATE pg_catalog."default" NOT NULL,
    region_residence text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT provider_pkey PRIMARY KEY (num_provider)
);

------------------> ESERCIZIO 1 <------------------------

SELECT first_name FROM client WHERE first_name = 'Mario'

------------------> ESERCIZIO 2 <------------------------

SELECT first_name, last_name FROM client WHERE year_birth = 1982

------------------> ESERCIZIO 3 <------------------------

SELECT number_invoice, tipology, iva COUNT(*) FROM invoices WHERE iva = 22

------------------> ESERCIZIO 4 <------------------------

SELECT * FROM products WHERE date_start BETWEEN '01-01-2017' AND '31-12-2017' 
  AND in_production = true OR in_market = true

------------------> ESERCIZIO 5 <------------------------

SELECT * FROM invoices JOIN client ON invoices.id_cliente = client.number_client WHERE invoices.amount < 1000

------------------> ESERCIZIO 6 <------------------------

SELECT invoices.number_invoice, invoices.amount, invoices.iva, invoices.date_invoce, provider.designation 
  FROM invoices JOIN provider ON invoices.number_supplier = provider.num_provider 

------------------> ESERCIZIO 7 <------------------------

SELECT COUNT(*) AS count_fatture,
    EXTRACT(YEAR FROM date_invoce) AS year
FROM invoices
WHERE iva = '20'
GROUP BY year;

------------------> ESERCIZIO 8 <------------------------

SELECT COUNT(*) AS count_fatture,
    EXTRACT(YEAR FROM date_invoce) AS year, SUM(amount) AS tot
FROM invoices
GROUP BY year;

------------------> ESERCIZIO EXTRA 9 <------------------------

SELECT EXTRACT(YEAR FROM date_invoce) AS year,
COUNT(*) AS num FROM invoices
WHERE tipology LIKE '%a%'
GROUP BY year

------------------> ESERCIZIO EXTRA 10 <------------------------

SELECT SUM(invoices.amount) AS tot, client.region_residence
FROM invoices
JOIN client ON invoices.id_client = client.number_client 
GROUP BY client.region_residence

------------------> ESERCIZIO EXTRA 11 <------------------------

SELECT COUNT(DISTINCT client) AS num_invoice, client.year_birth 
FROM invoices JOIN client ON invoices.id_client = client.number_client
WHERE invoices.amount > 50
GROUP BY client.year_birth 
HAVING  client.year_birth = 1980

