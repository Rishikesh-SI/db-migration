-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_author_action labpkl_author_action_id
-- Type: CONSTRAINT

-- Name: labpkl_v1_author_action labpkl_author_action_id; Type: CONSTRAINT; Schema: labpkl_v1; Owner: -
--

ALTER TABLE ONLY labpkl_v1.labpkl_v1_author_action
    ADD CONSTRAINT labpkl_author_action_id PRIMARY KEY (author_action_id);


--
