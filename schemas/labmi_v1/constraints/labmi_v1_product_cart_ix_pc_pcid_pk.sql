-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_product_cart ix_pc_pcid_pk
-- Type: CONSTRAINT

-- Name: labmi_v1_product_cart ix_pc_pcid_pk; Type: CONSTRAINT; Schema: labmi_v1; Owner: -
--

ALTER TABLE ONLY labmi_v1.labmi_v1_product_cart
    ADD CONSTRAINT ix_pc_pcid_pk PRIMARY KEY (product_cart_id);


--
