-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_product_cart ix_pc_pcid_pk
-- Type: CONSTRAINT

-- Name: labmi_product_cart ix_pc_pcid_pk; Type: CONSTRAINT; Schema: labmi_beta_22042024; Owner: -
--

ALTER TABLE ONLY labmi_beta_22042024.labmi_product_cart
    ADD CONSTRAINT ix_pc_pcid_pk PRIMARY KEY (product_cart_id);


--
