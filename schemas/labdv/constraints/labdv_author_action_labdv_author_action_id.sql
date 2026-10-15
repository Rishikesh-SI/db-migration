-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_author_action labdv_author_action_id
-- Type: CONSTRAINT

-- Name: labdv_author_action labdv_author_action_id; Type: CONSTRAINT; Schema: labdv; Owner: -
--

ALTER TABLE ONLY labdv.labdv_author_action
    ADD CONSTRAINT labdv_author_action_id PRIMARY KEY (author_action_id);


--
