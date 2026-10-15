-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_product_review dd_product_review_id
-- Type: CONSTRAINT

-- Name: labmi_product_review dd_product_review_id; Type: CONSTRAINT; Schema: labmi; Owner: -
--

ALTER TABLE ONLY labmi.labmi_product_review
    ADD CONSTRAINT dd_product_review_id PRIMARY KEY (product_review_id);


--
