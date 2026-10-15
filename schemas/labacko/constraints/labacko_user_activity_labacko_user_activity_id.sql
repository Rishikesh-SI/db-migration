-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: labacko_user_activity labacko_user_activity_id
-- Type: CONSTRAINT

-- Name: labacko_user_activity labacko_user_activity_id; Type: CONSTRAINT; Schema: labacko; Owner: -
--

ALTER TABLE ONLY labacko.labacko_user_activity
    ADD CONSTRAINT labacko_user_activity_id PRIMARY KEY (user_activity_id);


--
