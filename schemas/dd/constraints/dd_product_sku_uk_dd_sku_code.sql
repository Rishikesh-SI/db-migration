-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_product_sku uk_dd_sku_code
-- Type: CONSTRAINT

-- Name: dd_product_sku uk_dd_sku_code; Type: CONSTRAINT; Schema: dd; Owner: -
--

ALTER TABLE ONLY dd.dd_product_sku
    ADD CONSTRAINT uk_dd_sku_code UNIQUE (sku_code);


--
