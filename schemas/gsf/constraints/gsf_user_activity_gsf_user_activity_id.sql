-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: gsf_user_activity gsf_user_activity_id
-- Type: CONSTRAINT

-- Name: gsf_user_activity gsf_user_activity_id; Type: CONSTRAINT; Schema: gsf; Owner: -
--

ALTER TABLE ONLY gsf.gsf_user_activity
    ADD CONSTRAINT gsf_user_activity_id PRIMARY KEY (user_activity_id);


--
