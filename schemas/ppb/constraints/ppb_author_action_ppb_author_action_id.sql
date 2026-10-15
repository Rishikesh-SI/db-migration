-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ppb_author_action ppb_author_action_id
-- Type: CONSTRAINT

-- Name: ppb_author_action ppb_author_action_id; Type: CONSTRAINT; Schema: ppb; Owner: -
--

ALTER TABLE ONLY ppb.ppb_author_action
    ADD CONSTRAINT ppb_author_action_id PRIMARY KEY (author_action_id);


--
