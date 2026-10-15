-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_user_activity labisp_user_activity_id
-- Type: CONSTRAINT

-- Name: labisp_user_activity labisp_user_activity_id; Type: CONSTRAINT; Schema: labisp; Owner: -
--

ALTER TABLE ONLY labisp.labisp_user_activity
    ADD CONSTRAINT labisp_user_activity_id PRIMARY KEY (user_activity_id);


--
