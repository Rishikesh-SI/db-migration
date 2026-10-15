-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_user_activity labdsg_user_activity_id
-- Type: CONSTRAINT

-- Name: labdsg_user_activity labdsg_user_activity_id; Type: CONSTRAINT; Schema: labdsg; Owner: -
--

ALTER TABLE ONLY labdsg.labdsg_user_activity
    ADD CONSTRAINT labdsg_user_activity_id PRIMARY KEY (user_activity_id);


--
