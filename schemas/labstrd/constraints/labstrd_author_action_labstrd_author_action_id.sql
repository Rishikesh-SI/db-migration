-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: labstrd_author_action labstrd_author_action_id
-- Type: CONSTRAINT

-- Name: labstrd_author_action labstrd_author_action_id; Type: CONSTRAINT; Schema: labstrd; Owner: -
--

ALTER TABLE ONLY labstrd.labstrd_author_action
    ADD CONSTRAINT labstrd_author_action_id PRIMARY KEY (author_action_id);


--
