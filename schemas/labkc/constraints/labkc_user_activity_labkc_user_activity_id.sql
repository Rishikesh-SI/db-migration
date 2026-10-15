-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc
-- Object: labkc_user_activity labkc_user_activity_id
-- Type: CONSTRAINT

-- Name: labkc_user_activity labkc_user_activity_id; Type: CONSTRAINT; Schema: labkc; Owner: -
--

ALTER TABLE ONLY labkc.labkc_user_activity
    ADD CONSTRAINT labkc_user_activity_id PRIMARY KEY (user_activity_id);


--
