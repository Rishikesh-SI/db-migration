-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: labwf_user_activity labwf_user_activity_id
-- Type: CONSTRAINT

-- Name: labwf_user_activity labwf_user_activity_id; Type: CONSTRAINT; Schema: labwf; Owner: -
--

ALTER TABLE ONLY labwf.labwf_user_activity
    ADD CONSTRAINT labwf_user_activity_id PRIMARY KEY (user_activity_id);


--
