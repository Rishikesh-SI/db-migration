-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_user_activity yho_user_activity_id
-- Type: CONSTRAINT

-- Name: yho_user_activity yho_user_activity_id; Type: CONSTRAINT; Schema: yho; Owner: -
--

ALTER TABLE ONLY yho.yho_user_activity
    ADD CONSTRAINT yho_user_activity_id PRIMARY KEY (user_activity_id);


--
