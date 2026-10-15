-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: labhsl_author_action hsl_author_action_id
-- Type: CONSTRAINT

-- Name: labhsl_author_action hsl_author_action_id; Type: CONSTRAINT; Schema: labhsl; Owner: -
--

ALTER TABLE ONLY labhsl.labhsl_author_action
    ADD CONSTRAINT hsl_author_action_id PRIMARY KEY (author_action_id);


--
