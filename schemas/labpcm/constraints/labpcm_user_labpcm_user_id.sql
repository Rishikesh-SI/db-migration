-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_user labpcm_user_id
-- Type: CONSTRAINT

-- Name: labpcm_user labpcm_user_id; Type: CONSTRAINT; Schema: labpcm; Owner: -
--

ALTER TABLE ONLY labpcm.labpcm_user
    ADD CONSTRAINT labpcm_user_id PRIMARY KEY (user_id);


--
