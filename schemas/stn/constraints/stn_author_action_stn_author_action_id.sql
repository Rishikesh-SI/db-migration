-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_author_action stn_author_action_id
-- Type: CONSTRAINT

-- Name: stn_author_action stn_author_action_id; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_author_action
    ADD CONSTRAINT stn_author_action_id PRIMARY KEY (author_action_id);


--
