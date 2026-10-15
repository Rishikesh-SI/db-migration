-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_author_action labpc_author_action_id
-- Type: CONSTRAINT

-- Name: labpc_author_action labpc_author_action_id; Type: CONSTRAINT; Schema: labpc; Owner: -
--

ALTER TABLE ONLY labpc.labpc_author_action
    ADD CONSTRAINT labpc_author_action_id PRIMARY KEY (author_action_id);


--
