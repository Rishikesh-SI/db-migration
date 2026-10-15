-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_author_action upp_author_action_id
-- Type: CONSTRAINT

-- Name: upp_author_action upp_author_action_id; Type: CONSTRAINT; Schema: upp; Owner: -
--

ALTER TABLE ONLY upp.upp_author_action
    ADD CONSTRAINT upp_author_action_id PRIMARY KEY (author_action_id);


--
