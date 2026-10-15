-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: gfg_user_activity gfg_user_activity_id
-- Type: CONSTRAINT

-- Name: gfg_user_activity gfg_user_activity_id; Type: CONSTRAINT; Schema: gfg; Owner: -
--

ALTER TABLE ONLY gfg.gfg_user_activity
    ADD CONSTRAINT gfg_user_activity_id PRIMARY KEY (user_activity_id);


--
