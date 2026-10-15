-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_author_action yho_author_action_id
-- Type: CONSTRAINT

-- Name: yho_author_action yho_author_action_id; Type: CONSTRAINT; Schema: yho; Owner: -
--

ALTER TABLE ONLY yho.yho_author_action
    ADD CONSTRAINT yho_author_action_id PRIMARY KEY (author_action_id);


--
