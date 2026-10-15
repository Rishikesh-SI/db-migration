-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_user_activity hsl_user_activity_id
-- Type: CONSTRAINT

-- Name: hsl_user_activity hsl_user_activity_id; Type: CONSTRAINT; Schema: hsl; Owner: -
--

ALTER TABLE ONLY hsl.hsl_user_activity
    ADD CONSTRAINT hsl_user_activity_id PRIMARY KEY (user_activity_id);


--
