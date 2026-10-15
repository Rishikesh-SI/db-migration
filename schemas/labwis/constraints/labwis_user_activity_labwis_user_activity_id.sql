-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_user_activity labwis_user_activity_id
-- Type: CONSTRAINT

-- Name: labwis_user_activity labwis_user_activity_id; Type: CONSTRAINT; Schema: labwis; Owner: -
--

ALTER TABLE ONLY labwis.labwis_user_activity
    ADD CONSTRAINT labwis_user_activity_id PRIMARY KEY (user_activity_id);


--
