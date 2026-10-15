-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_user_activity labdv_user_activity_id
-- Type: CONSTRAINT

-- Name: labdv_user_activity labdv_user_activity_id; Type: CONSTRAINT; Schema: labdv; Owner: -
--

ALTER TABLE ONLY labdv.labdv_user_activity
    ADD CONSTRAINT labdv_user_activity_id PRIMARY KEY (user_activity_id);


--
