-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_user_language_map labpc_user_language_map_id
-- Type: CONSTRAINT

-- Name: labpc_user_language_map labpc_user_language_map_id; Type: CONSTRAINT; Schema: labpc; Owner: -
--

ALTER TABLE ONLY labpc.labpc_user_language_map
    ADD CONSTRAINT labpc_user_language_map_id PRIMARY KEY (user_language_map_id);


--
