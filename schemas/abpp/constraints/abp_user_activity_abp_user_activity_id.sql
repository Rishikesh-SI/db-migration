-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_user_activity abp_user_activity_id
-- Type: CONSTRAINT

-- Name: abp_user_activity abp_user_activity_id; Type: CONSTRAINT; Schema: abpp; Owner: -
--

ALTER TABLE ONLY abpp.abp_user_activity
    ADD CONSTRAINT abp_user_activity_id PRIMARY KEY (user_activity_id);


--
