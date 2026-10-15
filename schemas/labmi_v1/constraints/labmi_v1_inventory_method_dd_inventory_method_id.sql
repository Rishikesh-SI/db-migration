-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_inventory_method dd_inventory_method_id
-- Type: CONSTRAINT

-- Name: labmi_v1_inventory_method dd_inventory_method_id; Type: CONSTRAINT; Schema: labmi_v1; Owner: -
--

ALTER TABLE ONLY labmi_v1.labmi_v1_inventory_method
    ADD CONSTRAINT dd_inventory_method_id PRIMARY KEY (inventory_method_id);


--
