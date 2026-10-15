-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs
-- Object: labrs_user_activity labrs_user_activity_id
-- Type: CONSTRAINT

-- Name: labrs_user_activity labrs_user_activity_id; Type: CONSTRAINT; Schema: labrs; Owner: -
--

ALTER TABLE ONLY labrs.labrs_user_activity
    ADD CONSTRAINT labrs_user_activity_id PRIMARY KEY (user_activity_id);


--
