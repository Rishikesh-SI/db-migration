-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_seo_data tfa_seo_data_id
-- Type: CONSTRAINT

-- Name: tfa_seo_data tfa_seo_data_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_seo_data
    ADD CONSTRAINT tfa_seo_data_id PRIMARY KEY (seo_data_id);


--
