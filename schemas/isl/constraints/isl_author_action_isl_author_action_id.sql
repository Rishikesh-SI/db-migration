-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_author_action isl_author_action_id
-- Type: CONSTRAINT

-- Name: isl_author_action isl_author_action_id; Type: CONSTRAINT; Schema: isl; Owner: -
--

ALTER TABLE ONLY isl.isl_author_action
    ADD CONSTRAINT isl_author_action_id PRIMARY KEY (author_action_id);


--
