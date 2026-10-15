-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_product_shipping dd_product_shipping_id
-- Type: CONSTRAINT

-- Name: labmi_product_shipping dd_product_shipping_id; Type: CONSTRAINT; Schema: labmi; Owner: -
--

ALTER TABLE ONLY labmi.labmi_product_shipping
    ADD CONSTRAINT dd_product_shipping_id PRIMARY KEY (product_shipping_id);


--
