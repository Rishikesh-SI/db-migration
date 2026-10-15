-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_user stn_user_id
-- Type: CONSTRAINT

-- Name: stn_user stn_user_id; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_user
    ADD CONSTRAINT stn_user_id PRIMARY KEY (user_id);


--
