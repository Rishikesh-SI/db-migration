-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: cfc_author_action cfc_author_action_id
-- Type: CONSTRAINT

-- Name: cfc_author_action cfc_author_action_id; Type: CONSTRAINT; Schema: cfc; Owner: -
--

ALTER TABLE ONLY cfc.cfc_author_action
    ADD CONSTRAINT cfc_author_action_id PRIMARY KEY (author_action_id);


--
