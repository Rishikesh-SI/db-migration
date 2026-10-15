-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: labdsp_user_activity labdsp_user_activity_id
-- Type: CONSTRAINT

-- Name: labdsp_user_activity labdsp_user_activity_id; Type: CONSTRAINT; Schema: labdsp; Owner: -
--

ALTER TABLE ONLY labdsp.labdsp_user_activity
    ADD CONSTRAINT labdsp_user_activity_id PRIMARY KEY (user_activity_id);


--
