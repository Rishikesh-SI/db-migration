-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_author_action labtcs_author_action_id
-- Type: CONSTRAINT

-- Name: labtcs_author_action labtcs_author_action_id; Type: CONSTRAINT; Schema: labtcs; Owner: -
--

ALTER TABLE ONLY labtcs.labtcs_author_action
    ADD CONSTRAINT labtcs_author_action_id PRIMARY KEY (author_action_id);


--
