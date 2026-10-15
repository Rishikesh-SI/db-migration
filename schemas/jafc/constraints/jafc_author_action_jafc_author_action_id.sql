-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_author_action jafc_author_action_id
-- Type: CONSTRAINT

-- Name: jafc_author_action jafc_author_action_id; Type: CONSTRAINT; Schema: jafc; Owner: -
--

ALTER TABLE ONLY jafc.jafc_author_action
    ADD CONSTRAINT jafc_author_action_id PRIMARY KEY (author_action_id);


--
