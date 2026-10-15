-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: labgg_user_activity labgg_user_activity_id
-- Type: CONSTRAINT

-- Name: labgg_user_activity labgg_user_activity_id; Type: CONSTRAINT; Schema: labgg; Owner: -
--

ALTER TABLE ONLY labgg.labgg_user_activity
    ADD CONSTRAINT labgg_user_activity_id PRIMARY KEY (user_activity_id);


--
