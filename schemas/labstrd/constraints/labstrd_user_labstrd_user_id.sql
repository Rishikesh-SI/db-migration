-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: labstrd_user labstrd_user_id
-- Type: CONSTRAINT

-- Name: labstrd_user labstrd_user_id; Type: CONSTRAINT; Schema: labstrd; Owner: -
--

ALTER TABLE ONLY labstrd.labstrd_user
    ADD CONSTRAINT labstrd_user_id PRIMARY KEY (user_id);


--
