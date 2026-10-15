-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_product_image_map dd_product_image_map_id
-- Type: CONSTRAINT

-- Name: labmi_product_image_map dd_product_image_map_id; Type: CONSTRAINT; Schema: labmi; Owner: -
--

ALTER TABLE ONLY labmi.labmi_product_image_map
    ADD CONSTRAINT dd_product_image_map_id PRIMARY KEY (product_image_map_id);


--
