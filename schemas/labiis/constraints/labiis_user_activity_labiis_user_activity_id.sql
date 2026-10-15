-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: labiis_user_activity labiis_user_activity_id
-- Type: CONSTRAINT

-- Name: labiis_user_activity labiis_user_activity_id; Type: CONSTRAINT; Schema: labiis; Owner: -
--

ALTER TABLE ONLY labiis.labiis_user_activity
    ADD CONSTRAINT labiis_user_activity_id PRIMARY KEY (user_activity_id);


--
