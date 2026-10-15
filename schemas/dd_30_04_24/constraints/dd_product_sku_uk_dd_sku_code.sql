-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_product_sku uk_dd_sku_code
-- Type: CONSTRAINT

-- Name: dd_product_sku uk_dd_sku_code; Type: CONSTRAINT; Schema: dd_30_04_24; Owner: -
--

ALTER TABLE ONLY dd_30_04_24.dd_product_sku
    ADD CONSTRAINT uk_dd_sku_code UNIQUE (sku_code);


--
