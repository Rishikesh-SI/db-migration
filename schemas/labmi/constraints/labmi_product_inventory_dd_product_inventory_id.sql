-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_product_inventory dd_product_inventory_id
-- Type: CONSTRAINT

-- Name: labmi_product_inventory dd_product_inventory_id; Type: CONSTRAINT; Schema: labmi; Owner: -
--

ALTER TABLE ONLY labmi.labmi_product_inventory
    ADD CONSTRAINT dd_product_inventory_id PRIMARY KEY (product_inventory_id);


--
