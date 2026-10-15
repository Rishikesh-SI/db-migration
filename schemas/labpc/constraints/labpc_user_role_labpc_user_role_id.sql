-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_user_role labpc_user_role_id
-- Type: CONSTRAINT

-- Name: labpc_user_role labpc_user_role_id; Type: CONSTRAINT; Schema: labpc; Owner: -
--

ALTER TABLE ONLY labpc.labpc_user_role
    ADD CONSTRAINT labpc_user_role_id PRIMARY KEY (user_role_id);


--
