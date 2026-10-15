-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_user_activity labkc_v1_user_activity_id
-- Type: CONSTRAINT

-- Name: labkc_v1_user_activity labkc_v1_user_activity_id; Type: CONSTRAINT; Schema: labkc_v1; Owner: -
--

ALTER TABLE ONLY labkc_v1.labkc_v1_user_activity
    ADD CONSTRAINT labkc_v1_user_activity_id PRIMARY KEY (user_activity_id);


--
