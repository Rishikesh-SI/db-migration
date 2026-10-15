-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_author_action khi_author_action_id
-- Type: CONSTRAINT

-- Name: khi_author_action khi_author_action_id; Type: CONSTRAINT; Schema: khi; Owner: -
--

ALTER TABLE ONLY khi.khi_author_action
    ADD CONSTRAINT khi_author_action_id PRIMARY KEY (author_action_id);


--
