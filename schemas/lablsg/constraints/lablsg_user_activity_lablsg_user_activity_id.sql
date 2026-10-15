-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: lablsg_user_activity lablsg_user_activity_id
-- Type: CONSTRAINT

-- Name: lablsg_user_activity lablsg_user_activity_id; Type: CONSTRAINT; Schema: lablsg; Owner: -
--

ALTER TABLE ONLY lablsg.lablsg_user_activity
    ADD CONSTRAINT lablsg_user_activity_id PRIMARY KEY (user_activity_id);


--
