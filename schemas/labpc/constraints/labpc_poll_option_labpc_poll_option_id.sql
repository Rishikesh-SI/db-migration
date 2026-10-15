-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_poll_option labpc_poll_option_id
-- Type: CONSTRAINT

-- Name: labpc_poll_option labpc_poll_option_id; Type: CONSTRAINT; Schema: labpc; Owner: -
--

ALTER TABLE ONLY labpc.labpc_poll_option
    ADD CONSTRAINT labpc_poll_option_id PRIMARY KEY (poll_option_id);


--
