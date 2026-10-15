-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_user_activity labpcm_user_activity_id
-- Type: CONSTRAINT

-- Name: labpcm_user_activity labpcm_user_activity_id; Type: CONSTRAINT; Schema: labpcm; Owner: -
--

ALTER TABLE ONLY labpcm.labpcm_user_activity
    ADD CONSTRAINT labpcm_user_activity_id PRIMARY KEY (user_activity_id);


--
