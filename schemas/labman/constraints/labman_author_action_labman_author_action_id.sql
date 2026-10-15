-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: labman_author_action labman_author_action_id
-- Type: CONSTRAINT

-- Name: labman_author_action labman_author_action_id; Type: CONSTRAINT; Schema: labman; Owner: -
--

ALTER TABLE ONLY labman.labman_author_action
    ADD CONSTRAINT labman_author_action_id PRIMARY KEY (author_action_id);


--
