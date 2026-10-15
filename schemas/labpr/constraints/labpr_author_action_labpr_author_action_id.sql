-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_author_action labpr_author_action_id
-- Type: CONSTRAINT

-- Name: labpr_author_action labpr_author_action_id; Type: CONSTRAINT; Schema: labpr; Owner: -
--

ALTER TABLE ONLY labpr.labpr_author_action
    ADD CONSTRAINT labpr_author_action_id PRIMARY KEY (author_action_id);


--
