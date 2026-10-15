-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labpcm_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labpcm; Owner: -
--

ALTER TABLE ONLY labpcm.labpcm_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
