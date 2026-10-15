-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_user_activity labpc_user_activity_id
-- Type: CONSTRAINT

-- Name: labpc_user_activity labpc_user_activity_id; Type: CONSTRAINT; Schema: labpc; Owner: -
--

ALTER TABLE ONLY labpc.labpc_user_activity
    ADD CONSTRAINT labpc_user_activity_id PRIMARY KEY (user_activity_id);


--
