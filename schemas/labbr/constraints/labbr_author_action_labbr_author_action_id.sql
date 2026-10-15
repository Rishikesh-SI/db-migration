-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_author_action labbr_author_action_id
-- Type: CONSTRAINT

-- Name: labbr_author_action labbr_author_action_id; Type: CONSTRAINT; Schema: labbr; Owner: -
--

ALTER TABLE ONLY labbr.labbr_author_action
    ADD CONSTRAINT labbr_author_action_id PRIMARY KEY (author_action_id);


--
