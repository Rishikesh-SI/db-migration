-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: kxp_user_activity kxp_user_activity_id
-- Type: CONSTRAINT

-- Name: kxp_user_activity kxp_user_activity_id; Type: CONSTRAINT; Schema: kxp; Owner: -
--

ALTER TABLE ONLY kxp.kxp_user_activity
    ADD CONSTRAINT kxp_user_activity_id PRIMARY KEY (user_activity_id);


--
