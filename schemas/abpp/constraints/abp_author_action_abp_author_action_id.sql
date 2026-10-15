-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_author_action abp_author_action_id
-- Type: CONSTRAINT

-- Name: abp_author_action abp_author_action_id; Type: CONSTRAINT; Schema: abpp; Owner: -
--

ALTER TABLE ONLY abpp.abp_author_action
    ADD CONSTRAINT abp_author_action_id PRIMARY KEY (author_action_id);


--
