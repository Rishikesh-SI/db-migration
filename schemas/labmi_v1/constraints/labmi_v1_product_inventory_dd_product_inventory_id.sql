-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_product_inventory dd_product_inventory_id
-- Type: CONSTRAINT

-- Name: labmi_v1_product_inventory dd_product_inventory_id; Type: CONSTRAINT; Schema: labmi_v1; Owner: -
--

ALTER TABLE ONLY labmi_v1.labmi_v1_product_inventory
    ADD CONSTRAINT dd_product_inventory_id PRIMARY KEY (product_inventory_id);


--
