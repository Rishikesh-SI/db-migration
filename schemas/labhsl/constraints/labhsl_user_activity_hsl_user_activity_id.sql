-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: labhsl_user_activity hsl_user_activity_id
-- Type: CONSTRAINT

-- Name: labhsl_user_activity hsl_user_activity_id; Type: CONSTRAINT; Schema: labhsl; Owner: -
--

ALTER TABLE ONLY labhsl.labhsl_user_activity
    ADD CONSTRAINT hsl_user_activity_id PRIMARY KEY (user_activity_id);


--
