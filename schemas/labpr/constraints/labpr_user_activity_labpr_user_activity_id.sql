-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_user_activity labpr_user_activity_id
-- Type: CONSTRAINT

-- Name: labpr_user_activity labpr_user_activity_id; Type: CONSTRAINT; Schema: labpr; Owner: -
--

ALTER TABLE ONLY labpr.labpr_user_activity
    ADD CONSTRAINT labpr_user_activity_id PRIMARY KEY (user_activity_id);


--
