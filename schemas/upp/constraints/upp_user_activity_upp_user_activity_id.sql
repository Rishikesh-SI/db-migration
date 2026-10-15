-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_user_activity upp_user_activity_id
-- Type: CONSTRAINT

-- Name: upp_user_activity upp_user_activity_id; Type: CONSTRAINT; Schema: upp; Owner: -
--

ALTER TABLE ONLY upp.upp_user_activity
    ADD CONSTRAINT upp_user_activity_id PRIMARY KEY (user_activity_id);


--
