-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: pbl_user_activity pbl_user_activity_id
-- Type: CONSTRAINT

-- Name: pbl_user_activity pbl_user_activity_id; Type: CONSTRAINT; Schema: pbl; Owner: -
--

ALTER TABLE ONLY pbl.pbl_user_activity
    ADD CONSTRAINT pbl_user_activity_id PRIMARY KEY (user_activity_id);


--
