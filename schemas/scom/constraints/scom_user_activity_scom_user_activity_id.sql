-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_user_activity scom_user_activity_id
-- Type: CONSTRAINT

-- Name: scom_user_activity scom_user_activity_id; Type: CONSTRAINT; Schema: scom; Owner: -
--

ALTER TABLE ONLY scom.scom_user_activity
    ADD CONSTRAINT scom_user_activity_id PRIMARY KEY (user_activity_id);


--
