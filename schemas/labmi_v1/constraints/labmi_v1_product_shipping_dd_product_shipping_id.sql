-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_product_shipping dd_product_shipping_id
-- Type: CONSTRAINT

-- Name: labmi_v1_product_shipping dd_product_shipping_id; Type: CONSTRAINT; Schema: labmi_v1; Owner: -
--

ALTER TABLE ONLY labmi_v1.labmi_v1_product_shipping
    ADD CONSTRAINT dd_product_shipping_id PRIMARY KEY (product_shipping_id);


--
