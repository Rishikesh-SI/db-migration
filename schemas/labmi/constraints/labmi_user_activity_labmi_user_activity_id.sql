-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_user_activity labmi_user_activity_id
-- Type: CONSTRAINT

-- Name: labmi_user_activity labmi_user_activity_id; Type: CONSTRAINT; Schema: labmi; Owner: -
--

ALTER TABLE ONLY labmi.labmi_user_activity
    ADD CONSTRAINT labmi_user_activity_id PRIMARY KEY (user_activity_id);


--
