-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_image tfa_image_id
-- Type: CONSTRAINT

-- Name: tfa_image tfa_image_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_image
    ADD CONSTRAINT tfa_image_id PRIMARY KEY (image_id);


--
