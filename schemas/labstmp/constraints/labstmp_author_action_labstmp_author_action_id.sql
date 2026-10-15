-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_author_action labstmp_author_action_id
-- Type: CONSTRAINT

-- Name: labstmp_author_action labstmp_author_action_id; Type: CONSTRAINT; Schema: labstmp; Owner: -
--

ALTER TABLE ONLY labstmp.labstmp_author_action
    ADD CONSTRAINT labstmp_author_action_id PRIMARY KEY (author_action_id);


--
