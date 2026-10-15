-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_inventory_method dd_inventory_method_id
-- Type: CONSTRAINT

-- Name: labmi_inventory_method dd_inventory_method_id; Type: CONSTRAINT; Schema: labmi; Owner: -
--

ALTER TABLE ONLY labmi.labmi_inventory_method
    ADD CONSTRAINT dd_inventory_method_id PRIMARY KEY (inventory_method_id);


--
