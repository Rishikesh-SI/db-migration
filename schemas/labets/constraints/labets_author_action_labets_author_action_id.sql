-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: labets_author_action labets_author_action_id
-- Type: CONSTRAINT

-- Name: labets_author_action labets_author_action_id; Type: CONSTRAINT; Schema: labets; Owner: -
--

ALTER TABLE ONLY labets.labets_author_action
    ADD CONSTRAINT labets_author_action_id PRIMARY KEY (author_action_id);


--
