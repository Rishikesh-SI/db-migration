-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: labstrd_user_activity labstrd_user_activity_id
-- Type: CONSTRAINT

-- Name: labstrd_user_activity labstrd_user_activity_id; Type: CONSTRAINT; Schema: labstrd; Owner: -
--

ALTER TABLE ONLY labstrd.labstrd_user_activity
    ADD CONSTRAINT labstrd_user_activity_id PRIMARY KEY (user_activity_id);


--
