-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_author_action labgt_author_action_id
-- Type: CONSTRAINT

-- Name: labgt_author_action labgt_author_action_id; Type: CONSTRAINT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_author_action
    ADD CONSTRAINT labgt_author_action_id PRIMARY KEY (author_action_id);


--
