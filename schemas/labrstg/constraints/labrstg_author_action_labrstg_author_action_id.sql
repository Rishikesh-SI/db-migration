-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_author_action labrstg_author_action_id
-- Type: CONSTRAINT

-- Name: labrstg_author_action labrstg_author_action_id; Type: CONSTRAINT; Schema: labrstg; Owner: -
--

ALTER TABLE ONLY labrstg.labrstg_author_action
    ADD CONSTRAINT labrstg_author_action_id PRIMARY KEY (author_action_id);


--
