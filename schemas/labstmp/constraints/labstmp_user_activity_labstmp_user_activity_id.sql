-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_user_activity labstmp_user_activity_id
-- Type: CONSTRAINT

-- Name: labstmp_user_activity labstmp_user_activity_id; Type: CONSTRAINT; Schema: labstmp; Owner: -
--

ALTER TABLE ONLY labstmp.labstmp_user_activity
    ADD CONSTRAINT labstmp_user_activity_id PRIMARY KEY (user_activity_id);


--
