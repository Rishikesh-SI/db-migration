-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_author_action labpcm_author_action_id
-- Type: CONSTRAINT

-- Name: labpcm_author_action labpcm_author_action_id; Type: CONSTRAINT; Schema: labpcm; Owner: -
--

ALTER TABLE ONLY labpcm.labpcm_author_action
    ADD CONSTRAINT labpcm_author_action_id PRIMARY KEY (author_action_id);


--
