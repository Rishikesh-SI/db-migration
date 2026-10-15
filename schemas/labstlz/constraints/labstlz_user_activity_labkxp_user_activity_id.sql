-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: labstlz_user_activity labkxp_user_activity_id
-- Type: CONSTRAINT

-- Name: labstlz_user_activity labkxp_user_activity_id; Type: CONSTRAINT; Schema: labstlz; Owner: -
--

ALTER TABLE ONLY labstlz.labstlz_user_activity
    ADD CONSTRAINT labkxp_user_activity_id PRIMARY KEY (user_activity_id);


--
