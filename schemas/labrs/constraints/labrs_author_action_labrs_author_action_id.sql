-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs
-- Object: labrs_author_action labrs_author_action_id
-- Type: CONSTRAINT

-- Name: labrs_author_action labrs_author_action_id; Type: CONSTRAINT; Schema: labrs; Owner: -
--

ALTER TABLE ONLY labrs.labrs_author_action
    ADD CONSTRAINT labrs_author_action_id PRIMARY KEY (author_action_id);


--
