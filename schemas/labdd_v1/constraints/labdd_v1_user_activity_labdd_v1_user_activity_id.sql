-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_user_activity labdd_v1_user_activity_id
-- Type: CONSTRAINT

-- Name: labdd_v1_user_activity labdd_v1_user_activity_id; Type: CONSTRAINT; Schema: labdd_v1; Owner: -
--

ALTER TABLE ONLY labdd_v1.labdd_v1_user_activity
    ADD CONSTRAINT labdd_v1_user_activity_id PRIMARY KEY (user_activity_id);


--
