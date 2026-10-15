-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_user_activity labyho_user_activity_id
-- Type: CONSTRAINT

-- Name: labyho_user_activity labyho_user_activity_id; Type: CONSTRAINT; Schema: labyho; Owner: -
--

ALTER TABLE ONLY labyho.labyho_user_activity
    ADD CONSTRAINT labyho_user_activity_id PRIMARY KEY (user_activity_id);


--
