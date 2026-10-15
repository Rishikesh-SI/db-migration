-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_product_sku uk_dd_sku_code
-- Type: CONSTRAINT

-- Name: labmi_product_sku uk_dd_sku_code; Type: CONSTRAINT; Schema: labmi_beta_22042024; Owner: -
--

ALTER TABLE ONLY labmi_beta_22042024.labmi_product_sku
    ADD CONSTRAINT uk_dd_sku_code UNIQUE (sku_code);


--
