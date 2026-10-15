-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: gsf_author_action gsf_author_action_id
-- Type: CONSTRAINT

-- Name: gsf_author_action gsf_author_action_id; Type: CONSTRAINT; Schema: gsf; Owner: -
--

ALTER TABLE ONLY gsf.gsf_author_action
    ADD CONSTRAINT gsf_author_action_id PRIMARY KEY (author_action_id);


--
