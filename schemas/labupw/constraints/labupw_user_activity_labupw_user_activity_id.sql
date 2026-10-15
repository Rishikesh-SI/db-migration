-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupw
-- Object: labupw_user_activity labupw_user_activity_id
-- Type: CONSTRAINT

-- Name: labupw_user_activity labupw_user_activity_id; Type: CONSTRAINT; Schema: labupw; Owner: -
--

ALTER TABLE ONLY labupw.labupw_user_activity
    ADD CONSTRAINT labupw_user_activity_id PRIMARY KEY (user_activity_id);


--
